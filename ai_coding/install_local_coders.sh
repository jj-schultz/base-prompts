#!/bin/bash
# by:expose yes
# by:summary Install the local Claude, Codex, and Gemini TODO-command helpers into the current project.
# by:args [--help]
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEVELOPER_TOOLS_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
AI_CODING_COMMON_PATH="$DEVELOPER_TOOLS_ROOT/ai_coding/ai_coding_common"
SKILLS_INSTRUCTIONS_PATH="$AI_CODING_COMMON_PATH/instructions--skills.md"
PROJECT_ROOT="$(pwd)"
COMMANDS=(todo todo2 todo3)
TODO_DIR="./.ai_coding/todo"
CODEX_SKILLS_DIR="$HOME/.codex/skills"
CODEX_PROMPTS_DIR="$HOME/.codex/prompts"
CODEX_CONFIG_PATH="$HOME/.codex/config.toml"
CLAUDE_CONFIG_PATH="$HOME/.claude.json"
LINEAR_MCP_NAME="linear"
LINEAR_MCP_URL="https://mcp.linear.app/mcp"
PYCHARM_TEMPLATE_GROUP="AI Coding Skills"
PYCHARM_TEMPLATE_FILE_NAME="$PYCHARM_TEMPLATE_GROUP.xml"
SKILL_COMMANDS=()

by_build_gemini_runner_prompt() {
  local cmd="$1"

  cat <<EOF
Before doing anything else, open [$cmd.md](.ai_coding/todo/$cmd.md) and read the first non-empty line.
If that line starts with \`\$\`, resolve that skill using [instructions--skills.md](.ai_coding/ai_coding_common/instructions--skills.md) before planning, analysis, or editing.
The resolved skill overrides the generic instruction to "do the TODO items". If no skill line is present, assume \`\$IMPL\`.
Then do the TODO items in [$cmd.md](.ai_coding/todo/$cmd.md), fully respecting the rules defined in [instructions---top_level.md](.ai_coding/ai_coding_common/instructions---top_level.md)
EOF
}

by_build_claude_linear_auth_prompt() {
  cat <<EOF

If Linear MCP authentication is needed for this task, first confirm with the user in the CLI that you are about to start Linear login, then run \`/mcp\` and authenticate \`$LINEAR_MCP_NAME\`.
Reuse the existing cached Linear auth when it is already available. Claude Code stores MCP auth per user, so do not ask the user to re-authenticate on every install.
EOF
}

by_build_claude_runner_prompt() {
  local cmd="$1"

  cat <<EOF
Before doing anything else, open [$cmd.md](.ai_coding/todo/$cmd.md) and read the first non-empty line.
If that line starts with \`\$\`, resolve that skill using [instructions--skills.md](.ai_coding/ai_coding_common/instructions--skills.md) before planning, analysis, or editing.
The resolved skill overrides the generic instruction to "do the TODO items". If no skill line is present, assume \`\$IMPL\`.
Then do the TODO items in [$cmd.md](.ai_coding/todo/$cmd.md), fully respecting the rules defined in [instructions---top_level.md](.ai_coding/ai_coding_common/instructions---top_level.md)$(by_build_claude_linear_auth_prompt)
EOF
}

by_build_codex_linear_auth_prompt() {
  cat <<EOF

If Linear MCP authentication is needed for this task, first confirm with the user in the CLI that you are about to start Linear login, then run \`codex mcp login $LINEAR_MCP_NAME\`.
Reuse the existing cached Linear auth when it is already available. Codex stores MCP auth per user, so do not ask the user to re-authenticate on every install.
EOF
}

by_build_codex_runner_prompt() {
  local cmd="$1"

  cat <<EOF
Before doing anything else, open [$cmd.md](.ai_coding/todo/$cmd.md) and read the first non-empty line.
If that line begins with a skill marker (a leading dollar sign), resolve the matching skill using [instructions--skills.md](.ai_coding/ai_coding_common/instructions--skills.md) before planning, analysis, or editing.
That resolved skill overrides the generic instruction to "do the TODO items". If no skill line is present, use the implementation workflow by default.
Then do the TODO items in [$cmd.md](.ai_coding/todo/$cmd.md), fully respecting the rules defined in [instructions---top_level.md](.ai_coding/ai_coding_common/instructions---top_level.md)$(by_build_codex_linear_auth_prompt)
EOF
}

by_install_cli_tools() {
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

by_setup_ai_coding_common_link() {
  mkdir -p "./.ai_coding"
  rm -rf ./.ai_coding/ai_coding_common
  ln -s "$AI_CODING_COMMON_PATH" ./.ai_coding/ai_coding_common
}

by_ensure_local_helper_dirs_ignored() {
  touch ./.gitignore
  grep -qE '(^|/)\.ai_coding/?$' ./.gitignore || {
    printf '/.ai_coding\n' >> ./.gitignore
  }
  grep -qE '(^|/)\.codex/?$' ./.gitignore || {
    printf '/.codex\n' >> ./.gitignore
  }
}

by_write_todo_files() {
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
   \`\$$cmd\`

   Tip: type \`$\` in Codex to open the skills list, then pick \`$cmd\`.

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

by_write_gemini_commands() {
  local cmd

  mkdir -p ~/.gemini/commands
  for cmd in "${COMMANDS[@]}"; do
    cat > "$HOME/.gemini/commands/$cmd.toml" <<EOF
description = "Execute TODO items from .ai_coding/todo/$cmd.md"
prompt = """
$(by_build_gemini_runner_prompt "$cmd")
"""
EOF
  done
}

by_write_claude_commands() {
  local cmd

  mkdir -p ~/.claude/commands
  for cmd in "${COMMANDS[@]}"; do
    by_build_claude_runner_prompt "$cmd" > "$HOME/.claude/commands/$cmd.md"
  done
}

by_write_codex_skills() {
  local cmd
  local skill_dir

  mkdir -p "$CODEX_SKILLS_DIR"
  for cmd in "${COMMANDS[@]}"; do
    skill_dir="$CODEX_SKILLS_DIR/$cmd"
    mkdir -p "$skill_dir/agents"

    cat > "$skill_dir/SKILL.md" <<EOF
---
name: "$cmd"
description: "Execute TODO items from .ai_coding/todo/$cmd.md in this project."
---

$(by_build_codex_runner_prompt "$cmd")
EOF

    cat > "$skill_dir/agents/openai.yaml" <<EOF
interface:
  display_name: "$cmd"
  short_description: "Execute TODO items from .ai_coding/todo/$cmd.md"
  default_prompt: "Use the $cmd skill for the current repository's .ai_coding/todo/$cmd.md file."
EOF
  done
}

by_write_codex_prompts() {
  local cmd

  mkdir -p "$CODEX_PROMPTS_DIR"
  for cmd in "${COMMANDS[@]}"; do
    by_build_codex_runner_prompt "$cmd" > "$CODEX_PROMPTS_DIR/$cmd.md"
  done
}

by_upsert_toml_string_key() {
  local file_path="$1"
  local section_name="$2"
  local key_name="$3"
  local key_value="$4"
  local temp_file

  mkdir -p "$(dirname "$file_path")"
  touch "$file_path"
  temp_file="$(mktemp)"

  awk \
    -v section_name="$section_name" \
    -v key_name="$key_name" \
    -v key_value="$key_value" \
    '
      BEGIN {
        in_target_section = 0
        section_found = 0
        key_written = 0
      }

      $0 == "[" section_name "]" {
        if (in_target_section && !key_written) {
          print key_name " = \"" key_value "\""
        }
        in_target_section = 1
        section_found = 1
        key_written = 0
        print
        next
      }

      in_target_section && /^\[/ {
        if (!key_written) {
          print key_name " = \"" key_value "\""
        }
        in_target_section = 0
      }

      in_target_section && $0 ~ ("^" key_name "[[:space:]]*=") {
        if (!key_written) {
          print key_name " = \"" key_value "\""
          key_written = 1
        }
        next
      }

      {
        print
      }

      END {
        if (in_target_section && !key_written) {
          print key_name " = \"" key_value "\""
        }
        if (!section_found) {
          if (NR > 0) {
            print ""
          }
          print "[" section_name "]"
          print key_name " = \"" key_value "\""
        }
      }
    ' "$file_path" > "$temp_file"

  mv "$temp_file" "$file_path"
}

by_write_codex_linear_mcp_config() {
  by_upsert_toml_string_key "$CODEX_CONFIG_PATH" "mcp_servers.$LINEAR_MCP_NAME" "url" "$LINEAR_MCP_URL"
}

by_write_claude_linear_mcp_config() {
  mkdir -p "$(dirname "$CLAUDE_CONFIG_PATH")"

  node - "$CLAUDE_CONFIG_PATH" "$LINEAR_MCP_NAME" "$LINEAR_MCP_URL" <<'EOF'
const fs = require("fs");

const [, , configPath, serverName, serverUrl] = process.argv;
const existingContents = fs.existsSync(configPath) ? fs.readFileSync(configPath, "utf8").trim() : "";
const config = existingContents === "" ? {} : JSON.parse(existingContents);

if (!config.mcpServers || Array.isArray(config.mcpServers) || typeof config.mcpServers !== "object") {
  config.mcpServers = {};
}

config.mcpServers[serverName] = {
  type: "http",
  url: serverUrl,
};

fs.writeFileSync(configPath, `${JSON.stringify(config, null, 2)}\n`, "utf8");
EOF
}

by_write_linear_mcp_config() {
  by_write_codex_linear_mcp_config
  by_write_claude_linear_mcp_config
}

by_is_interactive_terminal() {
  [[ -t 0 && -t 1 ]]
}

by_confirm_yes_no() {
  local prompt_message="$1"
  local response

  printf "%s [y/N] " "$prompt_message"
  read -r response

  [[ "$response" =~ ^([Yy]|[Yy][Ee][Ss])$ ]]
}

by_should_start_linear_auth_now() {
  case "${BY_INSTALL_AI_CODING_AUTO_START_LINEAR_AUTH:-}" in
    1|true|TRUE|yes|YES)
      return 0
      ;;
    0|false|FALSE|no|NO)
      return 1
      ;;
  esac

  if ! by_is_interactive_terminal; then
    return 1
  fi

  by_confirm_yes_no "Start Linear MCP authentication now for Codex and Claude Code?"
}

by_authenticate_codex_linear_mcp() {
  echo "Starting Codex Linear MCP authentication..."
  codex mcp login "$LINEAR_MCP_NAME"
}

by_authenticate_claude_linear_mcp() {
  cat <<EOF
Starting Claude Code for Linear MCP authentication.
Inside Claude Code, run \`/mcp\`, authenticate \`$LINEAR_MCP_NAME\`, then exit Claude Code to return to the installer.
EOF
  claude
}

by_maybe_authenticate_linear_mcp() {
  if ! by_should_start_linear_auth_now; then
    if by_is_interactive_terminal; then
      cat <<EOF
Skipped Linear MCP authentication.
You can authenticate later with:
  - \`codex mcp login $LINEAR_MCP_NAME\`
  - \`claude\`, then \`/mcp\` to authenticate \`$LINEAR_MCP_NAME\`
EOF
      return
    fi

    cat <<EOF
Linear MCP authentication was not started because this installer is not running in an interactive terminal.
To authenticate later:
  - Run \`codex mcp login $LINEAR_MCP_NAME\`.
  - Start \`claude\`, then run \`/mcp\` and authenticate \`$LINEAR_MCP_NAME\`.
EOF
    return
  fi

  by_authenticate_codex_linear_mcp
  by_authenticate_claude_linear_mcp
}

by_print_linear_mcp_auth_steps() {
  cat <<EOF
Configured Linear MCP for Codex and Claude Code.
Linear MCP auth is cached per user by each CLI, so you normally only need to authenticate once per machine/account.
If you start authentication from a later Codex or Claude Code session, first confirm with the user in the CLI that you are about to start Linear login.
EOF
}

by_load_skill_commands() {
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

by_has_pycharm_installation() {
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

by_usage() {
  echo "Usage: $0 [--help]"
  echo
  echo "Install the local AI coding helpers into the current project root."
  echo "Run this command from the repository where you want .ai_coding configured."
}

by_main() {
  if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    by_usage
    exit 0
  fi

  by_install_cli_tools
  by_setup_ai_coding_common_link
  by_ensure_local_helper_dirs_ignored
  by_write_todo_files
  by_write_gemini_commands
  by_write_claude_commands
  by_write_codex_skills
  by_write_codex_prompts
  by_write_linear_mcp_config
  by_print_linear_mcp_auth_steps
  by_maybe_authenticate_linear_mcp
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  by_main "$@"
fi
