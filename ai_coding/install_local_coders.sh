#!/bin/bash
set -e

# Create directories if they don't exist
mkdir -p ./.ai_coding/claude
mkdir -p ./.ai_coding/codex
mkdir -p ./.ai_coding/gemini

# Create todo.md in claude if it doesn't exist
if [ ! -f ./.ai_coding/claude/todo.md ]; then
  echo -e "# TODO List - **you must** first read and execute all the rules and steps defined in \`./.ai_coding/ai_coding_common/high_level_instructions.md\`, **ignore all files in \`./.ai_coding/codex**\`, then proceed to the following todo items:\n\n" > ./.ai_coding/claude/todo.md
fi

# Create todo.md in gemini if it doesn't exist
if [ ! -f ./.ai_coding/gemini/todo.md ]; then
  echo -e "# TODO List - **you must** first read and execute all the rules and steps defined in \`./.ai_coding/ai_coding_common/high_level_instructions.md\`, **ignore all files in \`./.ai_coding/codex**\`, then proceed to the following todo items:\n\n" > ./.ai_coding/gemini/todo.md
fi

# Create todo.md in codex if it doesn't exist
if [ ! -f ./.ai_coding/codex/todo.md ]; then
  echo -e "# TODO List - **you must** first read and execute all the rules and steps defined in \`./.ai_coding/ai_coding_common/high_level_instructions.md\`, **ignore all files in \`./.ai_coding/claude**\`, then proceed to the following todo items:\n\n" > ./.ai_coding/codex/todo.md
fi

# Create symbolic link for common
if [ -L ./.ai_coding/common ] || [ -e ./.ai_coding/common ]; then
  rm -rf ./.ai_coding/common
fi
if [ -L ./.ai_coding/ai_coding_common ] || [ -e ./.ai_coding/ai_coding_common ]; then
  rm -rf ./.ai_coding/ai_coding_common
fi
ln -s ~/src/base-prompts/ai_coding/ai_coding_common ./.ai_coding/ai_coding_common

# Ensure .ai_coding is ignored in git
if [ ! -f ./.gitignore ]; then
  touch ./.gitignore
fi

if ! grep -qE '(^|/)\.ai_coding/?$' ./.gitignore; then
  echo "/.ai_coding" >> ./.gitignore
  echo "Added /.ai_coding to .gitignore"
fi
