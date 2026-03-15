package com.aitodo.aicoding.plugin.completion

data class TodoCommandToken(
    val startOffset: Int,
    val endOffset: Int,
    val text: String,
)

object TodoCommandTokenFinder {
    fun find(text: CharSequence, offset: Int): TodoCommandToken {
        require(offset in 0..text.length) { "Offset $offset is outside document bounds ${text.length}" }

        var startOffset = offset
        while (startOffset > 0 && !text[startOffset - 1].isWhitespace()) {
            startOffset -= 1
        }

        var endOffset = offset
        while (endOffset < text.length && !text[endOffset].isWhitespace()) {
            endOffset += 1
        }

        return TodoCommandToken(
            startOffset = startOffset,
            endOffset = endOffset,
            text = text.subSequence(startOffset, endOffset).toString(),
        )
    }
}
