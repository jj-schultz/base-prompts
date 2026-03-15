package com.aitodo.aicoding.plugin.completion

import com.aitodo.aicoding.plugin.skills.SkillCommandLoader
import com.intellij.codeInsight.AutoPopupController
import com.intellij.codeInsight.completion.CompletionContributor
import com.intellij.codeInsight.completion.CompletionParameters
import com.intellij.codeInsight.completion.CompletionProvider
import com.intellij.codeInsight.completion.CompletionResultSet
import com.intellij.codeInsight.completion.CompletionType
import com.intellij.codeInsight.completion.InsertHandler
import com.intellij.codeInsight.lookup.LookupElement
import com.intellij.codeInsight.lookup.LookupElementBuilder
import com.intellij.openapi.editor.Editor
import com.intellij.openapi.project.DumbAware
import com.intellij.openapi.project.Project
import com.intellij.patterns.PlatformPatterns
import com.intellij.psi.PsiFile
import com.intellij.util.ProcessingContext
import com.intellij.codeInsight.completion.PlainPrefixMatcher
import com.intellij.codeInsight.editorActions.TypedHandlerDelegate
import java.nio.file.Path

class TodoSkillCompletionContributor : CompletionContributor(), DumbAware {
    init {
        extend(
            CompletionType.BASIC,
            PlatformPatterns.psiElement(),
            TodoSkillCompletionProvider(),
        )
    }
}

class TodoSkillTypedHandler : TypedHandlerDelegate(), DumbAware {
    override fun checkAutoPopup(charTyped: Char, project: Project, editor: Editor, file: PsiFile): Result {
        if (charTyped != '$') {
            return Result.CONTINUE
        }

        val fileName = file.virtualFile?.name ?: return Result.CONTINUE
        if (!TodoFileMatcher.matches(fileName)) {
            return Result.CONTINUE
        }

        AutoPopupController.getInstance(project).scheduleAutoPopup(editor)
        return Result.STOP
    }
}

private class TodoSkillCompletionProvider : CompletionProvider<CompletionParameters>() {
    override fun addCompletions(
        parameters: CompletionParameters,
        context: ProcessingContext,
        result: CompletionResultSet,
    ) {
        val fileName = parameters.originalFile.virtualFile?.name ?: return
        if (!TodoFileMatcher.matches(fileName)) {
            return
        }

        val token = TodoCommandTokenFinder.find(parameters.editor.document.charsSequence, parameters.offset)
        if (token.text.isNotEmpty() && !token.text.startsWith("$")) {
            return
        }

        val prefix = parameters.editor.document.charsSequence
            .subSequence(token.startOffset, parameters.offset)
            .toString()
        val prefixedResult = result.withPrefixMatcher(PlainPrefixMatcher(prefix))
        val projectBasePath = parameters.position.project.basePath ?: error("Project base path is unavailable")

        SkillCommandLoader(Path.of(projectBasePath)).load().forEach { skillCommand ->
            prefixedResult.addElement(
                LookupElementBuilder.create(skillCommand.command)
                    .withTypeText(skillCommand.helpText, true)
                    .withInsertHandler(TodoSkillInsertHandler),
            )
        }
    }
}

private object TodoSkillInsertHandler : InsertHandler<LookupElement> {
    override fun handleInsert(context: com.intellij.codeInsight.completion.InsertionContext, item: LookupElement) {
        val token = TodoCommandTokenFinder.find(context.document.charsSequence, context.tailOffset)
        context.document.replaceString(token.startOffset, token.endOffset, item.lookupString)
        context.editor.caretModel.moveToOffset(token.startOffset + item.lookupString.length)
    }
}
