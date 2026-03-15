package com.bobyard.aicoding.plugin.skills

import java.nio.file.Files
import java.nio.file.Path

class SkillCommandLoader(
    private val projectRoot: Path,
) {
    fun load(): List<SkillCommand> {
        val aiCodingCommonDirectory = projectRoot.resolve(AI_CODING_COMMON_PATH)
        val parsedCommands = SkillCommandParser.parseInstructionsFile(
            Files.readString(aiCodingCommonDirectory.resolve(SKILLS_INSTRUCTIONS_FILE_NAME)),
        )

        return parsedCommands.map { parsedCommand ->
            val instructionPath = aiCodingCommonDirectory.resolve(parsedCommand.instructionReference)
            val helpText = firstNonBlankLine(instructionPath)
            SkillCommand(
                command = parsedCommand.command,
                helpText = helpText,
                instructionPath = instructionPath,
            )
        }
    }

    private fun firstNonBlankLine(path: Path): String {
        Files.newBufferedReader(path).useLines { lines ->
            return lines.first { it.isNotBlank() }.trim()
        }
    }

    companion object {
        private val AI_CODING_COMMON_PATH = Path.of(".ai_coding", "ai_coding_common")
        private const val SKILLS_INSTRUCTIONS_FILE_NAME = "instructions--skills.md"
    }
}
