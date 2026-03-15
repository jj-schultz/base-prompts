package com.aitodo.aicoding.plugin.completion

import kotlin.test.Test
import kotlin.test.assertEquals

class TodoCommandTokenFinderTest {
    @Test
    fun `finds the command token around the caret`() {
        val dollar = '$'
        assertEquals(
            TodoCommandToken(
                startOffset = 0,
                endOffset = 3,
                text = "${dollar}PL",
            ),
            TodoCommandTokenFinder.find("${dollar}PL", 3),
        )
    }

    @Test
    fun `finds the token inside surrounding text`() {
        val dollar = '$'
        val text = "before ${dollar}PLAN after"

        assertEquals(
            TodoCommandToken(
                startOffset = 7,
                endOffset = 12,
                text = "${dollar}PLAN",
            ),
            TodoCommandTokenFinder.find(text, 12),
        )
    }
}
