#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AI_CODING_COMMON_PATH="$SCRIPT_DIR/ai_coding_common"
SKILLS_INSTRUCTIONS_PATH="$AI_CODING_COMMON_PATH/instructions--skills.md"
PROJECT_ROOT="$(pwd)"
COMMANDS=(todo todo2 todo3)
TODO_DIR="./.ai_coding/todo"
PYCHARM_TEMPLATE_GROUP="AI Coding Skills"
PYCHARM_TEMPLATE_FILE_NAME="$PYCHARM_TEMPLATE_GROUP.xml"
SKILL_COMMANDS=()

build_runner_prompt() {
  local cmd="$1"

  cat <<EOF
Before doing anything else, open [$cmd.md](.ai_coding/todo/$cmd.md) and read the first non-empty line.
If that line starts with \`\$\`, resolve that skill using [instructions--skills.md](.ai_coding/ai_coding_common/instructions--skills.md) before planning, analysis, or editing.
The resolved skill overrides the generic instruction to "do the TODO items". If no skill line is present, assume \`\$IMPL\`.
Then do the TODO items in [$cmd.md](.ai_coding/todo/$cmd.md), fully respecting the rules defined in [instructions---top_level.md](.ai_coding/ai_coding_common/instructions---top_level.md)
EOF
}

build_codex_runner_prompt() {
  local cmd="$1"

  cat <<EOF
Before doing anything else, open [$cmd.md](.ai_coding/todo/$cmd.md) and read the first non-empty line.
If that line begins with a skill marker (a leading dollar sign), resolve the matching skill using [instructions--skills.md](.ai_coding/ai_coding_common/instructions--skills.md) before planning, analysis, or editing.
That resolved skill overrides the generic instruction to "do the TODO items". If no skill line is present, use the implementation workflow by default.
Then do the TODO items in [$cmd.md](.ai_coding/todo/$cmd.md), fully respecting the rules defined in [instructions---top_level.md](.ai_coding/ai_coding_common/instructions---top_level.md)
EOF
}

install_cli_tools() {
  brew install -q terminal-notifier

  # Claude Code - https://www.npmjs.com/package/@anthropic-ai/claude-code
  if ! command -v claude &> /dev/null; then
    npm install -g @anthropic-ai/claude-code
  fi

  # OpenAI Codex - https://www.npmjs.com/package/@openai/codex
  if ! command -v codex &> /dev/null; then
    npm install -g @openai/codex
  fi

  # Google Gemini CLI - https://www.npmjs.com/package/@google/gemini-cli
  if ! command -v gemini &> /dev/null; then
    npm install -g @google/gemini-cli
  fi
}

setup_ai_coding_common_link() {
  mkdir -p "./.ai_coding"
  rm -rf ./.ai_coding/ai_coding_common
  ln -s "$AI_CODING_COMMON_PATH" ./.ai_coding/ai_coding_common
}

ensure_ai_coding_ignored() {
  touch ./.gitignore
  grep -qE '(^|/)\.ai_coding/?$' ./.gitignore || {
    printf '/.ai_coding\n' >> ./.gitignore
  }
}

write_todo_files() {
  local cmd
  local path
  local todo_header

  mkdir -p "$TODO_DIR"

  for cmd in "${COMMANDS[@]}"; do
    read -r -d '' todo_header <<EOF || true
# User Guide
(heads up:  you can safely delete the contents of this file once you've read this user guide)

## Starting the Coding Tool

To start the Claude Code CLI, run:
\`\`\`
cd $PROJECT_ROOT && claude
\`\`\`

To start the Codex CLI, run:
\`\`\`
cd $PROJECT_ROOT && codex
\`\`\`

## Using This TODO File

1. Write your instructions in this file
2. In Claude Code, execute:
   \`/$cmd\`
3. In Codex, execute:
   \`/$cmd\`

## Documentation

- Keyword documentation: https://github.com/bobyard-real/developer-tools/blob/main/ai_coding/keywords.md
- Full documentation: https://github.com/bobyard-real/developer-tools/blob/main/ai_coding/README.md

EOF

    path="$TODO_DIR/$cmd.md"
    if [ ! -f "$path" ]; then
      printf '%s\n' "$todo_header" > "$path"
    fi
  done
}

write_gemini_commands() {
  local cmd

  mkdir -p ~/.gemini/commands
  for cmd in "${COMMANDS[@]}"; do
    cat > "$HOME/.gemini/commands/$cmd.toml" <<EOF
description = "Execute TODO items from .ai_coding/todo/$cmd.md"
prompt = """
$(build_runner_prompt "$cmd")
"""
EOF
  done
}

write_claude_commands() {
  local cmd

  mkdir -p ~/.claude/commands
  for cmd in "${COMMANDS[@]}"; do
    build_runner_prompt "$cmd" > "$HOME/.claude/commands/$cmd.md"
  done
}

write_codex_prompts() {
  local cmd

  mkdir -p ~/.codex/prompts
  for cmd in "${COMMANDS[@]}"; do
    build_codex_runner_prompt "$cmd" > "$HOME/.codex/prompts/$cmd.md"
  done
}

load_skill_commands() {
  local skill_command

  SKILL_COMMANDS=()
  while IFS= read -r skill_command; do
    SKILL_COMMANDS+=("$skill_command")
  done < <(sed -n 's/^- `\(\$[^`]*\)`:.*$/\1/p' "$SKILLS_INSTRUCTIONS_PATH")

  if [ "${#SKILL_COMMANDS[@]}" -eq 0 ]; then
    echo "No skill commands found in $SKILLS_INSTRUCTIONS_PATH" >&2
    exit 1
  fi
}

has_pycharm_installation() {
  local jetbrains_dir="$HOME/Library/Application Support/JetBrains"
  local pycharm_dir

  shopt -s nullglob
  for pycharm_dir in "$jetbrains_dir"/PyCharm*; do
    if [ -d "$pycharm_dir" ]; then
      shopt -u nullglob
      return 0
    fi
  done
  shopt -u nullglob

  return 1
}

main() {
  install_cli_tools
  setup_ai_coding_common_link
  ensure_ai_coding_ignored
  write_todo_files
  write_gemini_commands
  write_claude_commands
  write_codex_prompts
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
