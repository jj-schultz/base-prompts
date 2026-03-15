package com.bobyard.aicoding.plugin.skills

import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import java.nio.file.Files
import java.nio.file.Path
import kotlin.test.assertEquals

class SkillCommandLoaderTest {
    @TempDir
    lateinit var tempDirectory: Path

    @Test
    fun `loads commands from the project ai coding directory and derives help text from skill files`() {
        val dollar = '$'
        val aiCodingCommonDirectory = tempDirectory.resolve(".ai_coding").resolve("ai_coding_common")
        Files.createDirectories(aiCodingCommonDirectory)
        Files.writeString(
            aiCodingCommonDirectory.resolve("instructions--skills.md"),
            """
                # SKILLS

                ## File-backed skills
                - `${dollar}PLAN`: `skill--plan.md`
                - `${dollar}IMPL`: `skill--impl.md`

                ## SKILLS: Allowed Scope
            """.trimIndent(),
        )
        Files.writeString(
            aiCodingCommonDirectory.resolve("skill--plan.md"),
            """

            Create a step-by-step plan that Codex or Claude Code can follow.
            More text.
            """.trimIndent(),
        )
        Files.writeString(
            aiCodingCommonDirectory.resolve("skill--impl.md"),
            """
            Implement the code change described following all principles.
            More text.
            """.trimIndent(),
        )

        assertEquals(
            listOf(
                SkillCommand(
                    command = "${dollar}PLAN",
                    helpText = "Create a step-by-step plan that Codex or Claude Code can follow.",
                    instructionPath = aiCodingCommonDirectory.resolve("skill--plan.md"),
                ),
                SkillCommand(
                    command = "${dollar}IMPL",
                    helpText = "Implement the code change described following all principles.",
                    instructionPath = aiCodingCommonDirectory.resolve("skill--impl.md"),
                ),
            ),
            SkillCommandLoader(tempDirectory).load(),
        )
    }
}
