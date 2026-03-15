package com.aitodo.aicoding.plugin.skills

object SkillCommandParser {
    private val fileBackedHeadingPattern = Regex("^##\\s+File-backed skills\\s*$")
    private val headingPattern = Regex("^##\\s+")
    private val commandPattern = Regex("^-\\s+`(\\$[^`]+)`:\\s+`([^`]+)`\\s*$")
    private val markdownLinkTargetPattern = Regex(""".*\]\(([^)]+)\).*""")

    fun parseInstructionsFile(contents: String): List<ParsedSkillCommand> {
        val commands = mutableListOf<ParsedSkillCommand>()
        var inFileBackedSection = false

        for (rawLine in contents.lineSequence()) {
            val line = rawLine.trim()

            if (!inFileBackedSection) {
                if (fileBackedHeadingPattern.matches(line)) {
                    inFileBackedSection = true
                }
                continue
            }

            if (headingPattern.matches(line)) {
                break
            }

            val match = commandPattern.matchEntire(line) ?: continue
            commands += ParsedSkillCommand(
                command = match.groupValues[1],
                instructionReference = normalizeInstructionReference(match.groupValues[2]),
            )
        }

        check(commands.isNotEmpty()) { "No file-backed skill commands found in instructions--skills.md" }
        return commands
    }

    private fun normalizeInstructionReference(reference: String): String {
        val markdownLinkTarget = markdownLinkTargetPattern.matchEntire(reference)?.groupValues?.get(1)
        return (markdownLinkTarget ?: reference).removePrefix("./.ai_coding/ai_coding_common/")
    }
}
