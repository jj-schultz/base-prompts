package com.aitodo.aicoding.plugin.completion

object TodoFileMatcher {
    private val todoMarkdownPattern = Regex("^todo.*\\.md$")

    fun matches(fileName: String): Boolean = todoMarkdownPattern.matches(fileName)
}
