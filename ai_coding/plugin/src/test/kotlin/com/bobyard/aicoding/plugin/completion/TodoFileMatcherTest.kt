package com.bobyard.aicoding.plugin.completion

import kotlin.test.Test
import kotlin.test.assertFalse
import kotlin.test.assertTrue

class TodoFileMatcherTest {
    @Test
    fun `matches todo markdown files`() {
        assertTrue(TodoFileMatcher.matches("todo.md"))
        assertTrue(TodoFileMatcher.matches("todo2.md"))
        assertTrue(TodoFileMatcher.matches("todo-plugin.md"))
    }

    @Test
    fun `rejects non matching files`() {
        assertFalse(TodoFileMatcher.matches("Todo.md"))
        assertFalse(TodoFileMatcher.matches("notes.md"))
        assertFalse(TodoFileMatcher.matches("todo.txt"))
    }
}
