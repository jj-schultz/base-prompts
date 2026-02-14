#!/bin/bash
set -e

brew install -q terminal-notifier

# Install AI coding CLI tools (skip if already installed)
# Claude Code - https://www.npmjs.com/package/@anthropic-ai/claude-code
if ! command -v claude &> /dev/null; then
  npm install -g @anthropic-ai/claude-code
fi

# OpenAI Codex - https://www.npmjs.com/package/@openai/codex
if ! command -v codex &> /dev/null; then
  npm install -g @openai/codex
fi

# Google Gemini CLI - https://www.npmjs.com/package/@google/gemini-cli
#if ! command -v gemini &> /dev/null; then
#  npm install -g @google/gemini-cli
#fi

# Derive the ai_coding_common path from this script's location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AI_CODING_COMMON_PATH="$SCRIPT_DIR/ai_coding_common"

# Capture the project root (where .ai_coding will live)
PROJECT_ROOT="$(pwd)"

# Create symbolic link for common
mkdir -p "./.ai_coding"
rm -rf ./.ai_coding/ai_coding_common
ln -s "$AI_CODING_COMMON_PATH" ./.ai_coding/ai_coding_common

# Ensure .ai_coding is ignored in git
touch ./.gitignore
grep -qE '(^|/)\.ai_coding/?$' ./.gitignore || {
  printf '/.ai_coding\n' >> ./.gitignore
}

# Tools and commands
#TOOLS=(claude codex gemini)
TOOLS=(claude codex)
COMMANDS=(todo todo2 todo3)

# Create base directories
for tool in "${TOOLS[@]}"; do
  mkdir -p "./.ai_coding/$tool"
done

# Shared TODO header template (tool-specific)
for tool in "${TOOLS[@]}"; do
  for cmd in "${COMMANDS[@]}"; do
    # Tool-specific startup instructions
    case "$tool" in
      claude)
        START_INSTRUCTIONS="To start the Claude Code CLI, run:
\`\`\`
cd $PROJECT_ROOT && claude
\`\`\`"
        ;;
      codex)
        START_INSTRUCTIONS="To start the Codex CLI, run:
\`\`\`
cd $PROJECT_ROOT && codex
\`\`\`"
        ;;
      gemini)
        START_INSTRUCTIONS="To start the Gemini CLI, run:
\`\`\`
cd $PROJECT_ROOT && gemini
\`\`\`"
        ;;
    esac

    read -r -d '' TODO_HEADER <<EOF || true
# User Guide
(heads up:  you can safely delete the contents of this file once you've read this user guide)

## Starting the Coding Tool

$START_INSTRUCTIONS

## Using This TODO File

1. Write your instructions in this file
2. Execute the following command in $tool:
   \`/$cmd\`

EOF

    path="./.ai_coding/$tool/$cmd.md"
    if [ ! -f "$path" ]; then
      printf '%s\n' "$TODO_HEADER" > "$path"
    fi
  done
done

# Gemini commands (TOML format)
#mkdir -p ~/.gemini/commands
#for cmd in "${COMMANDS[@]}"; do
#  cat > "$HOME/.gemini/commands/$cmd.toml" <<EOF
#description = "Execute TODO items from .ai_coding/gemini/$cmd.md"
#prompt = """
#Please do the TODO items in [$cmd.md](.ai_coding/gemini/$cmd.md), **fully respecting** the rules defined in [instructions---top_level.md](.ai_coding/ai_coding_common/instructions---top_level.md)
#"""
#EOF
#done

# Claude commands
mkdir -p ~/.claude/commands
for cmd in "${COMMANDS[@]}"; do
  printf 'Please do the TODO items in [%s.md](.ai_coding/claude/%s.md), **fully respecting** the rules defined in [instructions---top_level.md](.ai_coding/ai_coding_common/instructions---top_level.md)\n' \
    "$cmd" "$cmd" > "$HOME/.claude/commands/$cmd.md"
done

# Codex prompts
mkdir -p ~/.codex/prompts
for cmd in "${COMMANDS[@]}"; do
  printf 'Please do the TODO items in [%s.md](.ai_coding/codex/%s.md), **fully respecting** the rules defined in [instructions---top_level.md](.ai_coding/ai_coding_common/instructions---top_level.md)\n' \
    "$cmd" "$cmd" > "$HOME/.codex/prompts/$cmd.md"
done
