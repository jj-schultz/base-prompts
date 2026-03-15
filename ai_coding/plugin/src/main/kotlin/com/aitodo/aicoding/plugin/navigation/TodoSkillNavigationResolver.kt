package com.aitodo.aicoding.plugin.navigation

import com.aitodo.aicoding.plugin.skills.SkillCommandLoader
import java.nio.file.Path

class TodoSkillNavigationResolver(
    projectRoot: Path,
) {
    private val instructionPathsByCommand = SkillCommandLoader(projectRoot)
        .load()
        .associate { skillCommand -> skillCommand.command to skillCommand.instructionPath }

    fun resolve(command: String): Path? = instructionPathsByCommand[command]
}
