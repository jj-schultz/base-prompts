package com.bobyard.aicoding.plugin.navigation

import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import java.nio.file.Files
import java.nio.file.Path
import kotlin.test.assertEquals
import kotlin.test.assertNull

class TodoSkillNavigationResolverTest {
    @TempDir
    lateinit var tempDirectory: Path

    @Test
    fun `resolves a known skill command to its instruction file`() {
        val dollar = '$'
        val aiCodingCommonDirectory = writeInstructionsFile(
            """
                - `${dollar}IMPL`: `skill--impl.md`
            """.trimIndent(),
        )
        Files.writeString(aiCodingCommonDirectory.resolve("skill--impl.md"), "Implement the requested change.")

        assertEquals(
            aiCodingCommonDirectory.resolve("skill--impl.md"),
            TodoSkillNavigationResolver(tempDirectory).resolve("\$IMPL"),
        )
    }

    @Test
    fun `returns no navigation target for an unknown skill command`() {
        val dollar = '$'
        val aiCodingCommonDirectory = writeInstructionsFile(
            """
                - `${dollar}PLAN`: `skill--plan.md`
            """.trimIndent(),
        )
        Files.writeString(aiCodingCommonDirectory.resolve("skill--plan.md"), "Create a plan.")

        assertNull(TodoSkillNavigationResolver(tempDirectory).resolve("\$IMPL"))
    }

    @Test
    fun `resolves markdown link instruction references`() {
        val dollar = '$'
        val aiCodingCommonDirectory = writeInstructionsFile(
            """
                - `${dollar}TAKEHOME_REVIEW_MLOPS`: `./.ai_coding/ai_coding_common/[skill--takehome_review_mlops.md](skill--takehome_review_mlops.md)`
            """.trimIndent(),
        )
        Files.writeString(
            aiCodingCommonDirectory.resolve("skill--takehome_review_mlops.md"),
            "Review the takehome with the MLOps rubric.",
        )

        assertEquals(
            aiCodingCommonDirectory.resolve("skill--takehome_review_mlops.md"),
            TodoSkillNavigationResolver(tempDirectory).resolve("\$TAKEHOME_REVIEW_MLOPS"),
        )
    }

    private fun writeInstructionsFile(fileBackedSkillsSection: String): Path {
        val aiCodingCommonDirectory = tempDirectory.resolve(".ai_coding").resolve("ai_coding_common")
        Files.createDirectories(aiCodingCommonDirectory)
        Files.writeString(
            aiCodingCommonDirectory.resolve("instructions--skills.md"),
            """
                # SKILLS

                ## File-backed skills
                $fileBackedSkillsSection

                ## SKILLS: Allowed Scope
            """.trimIndent(),
        )
        return aiCodingCommonDirectory
    }
}
