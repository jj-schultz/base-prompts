package com.aitodo.aicoding.plugin.skills

import java.nio.file.Path

data class SkillCommand(
    val command: String,
    val helpText: String,
    val instructionPath: Path,
)

data class ParsedSkillCommand(
    val command: String,
    val instructionReference: String,
)
