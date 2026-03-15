package com.aitodo.aicoding.plugin.skills

import kotlin.test.Test
import kotlin.test.assertEquals

class SkillCommandParserTest {
    @Test
    fun `parses file-backed skills and normalizes instruction references`() {
        val dollar = '$'
        val contents = """
            # SKILLS

            ## File-backed skills
            - `${dollar}PLAN`: `skill--plan.md`
            - `${dollar}TAKEHOME_REVIEW_MLOPS`: `./.ai_coding/ai_coding_common/[skill--takehome_review_mlops.md](skill--takehome_review_mlops.md)`

            ## SKILLS: Allowed Scope
            - ignored
        """.trimIndent()

        assertEquals(
            listOf(
                ParsedSkillCommand(
                    command = "${dollar}PLAN",
                    instructionReference = "skill--plan.md",
                ),
                ParsedSkillCommand(
                    command = "${dollar}TAKEHOME_REVIEW_MLOPS",
                    instructionReference = "skill--takehome_review_mlops.md",
                ),
            ),
            SkillCommandParser.parseInstructionsFile(contents),
        )
    }
}
