package com.aitodo.aicoding.plugin.navigation

import com.aitodo.aicoding.plugin.completion.TodoCommandTokenFinder
import com.aitodo.aicoding.plugin.completion.TodoFileMatcher
import com.intellij.codeInsight.navigation.actions.GotoDeclarationHandler
import com.intellij.openapi.editor.Editor
import com.intellij.openapi.project.DumbAware
import com.intellij.openapi.vfs.LocalFileSystem
import com.intellij.psi.PsiElement
import com.intellij.psi.PsiManager
import java.nio.file.Path

class TodoSkillGotoDeclarationHandler : GotoDeclarationHandler, DumbAware {
    override fun getGotoDeclarationTargets(sourceElement: PsiElement?, offset: Int, editor: Editor): Array<PsiElement>? {
        sourceElement ?: return null

        val fileName = sourceElement.containingFile.virtualFile?.name ?: return null
        if (!TodoFileMatcher.matches(fileName)) {
            return null
        }

        val token = TodoCommandTokenFinder.find(editor.document.charsSequence, offset)
        if (!token.text.startsWith("$")) {
            return null
        }

        val projectBasePath = sourceElement.project.basePath ?: error("Project base path is unavailable")
        val instructionPath = TodoSkillNavigationResolver(Path.of(projectBasePath)).resolve(token.text) ?: return null
        val instructionVirtualFile = LocalFileSystem.getInstance().findFileByNioFile(instructionPath)
            ?: error("Instruction file is unavailable: $instructionPath")
        val instructionPsiFile = PsiManager.getInstance(sourceElement.project).findFile(instructionVirtualFile)
            ?: error("Instruction PSI file is unavailable: $instructionPath")

        return arrayOf(instructionPsiFile)
    }
}
