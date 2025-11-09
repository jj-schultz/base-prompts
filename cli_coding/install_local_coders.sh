#!/bin/bash
set -e

echo "Removing existing directory ./.claude/support"
rm -rf ./.claude/support

echo "Creating symbolic link from ~/src/base-prompts/.claude/support to ./.claude/support"
ln -s ~/src/base-prompts/cli_coding/.claude/support ./.claude/support

echo "Removing existing directory ./.codex/support"
rm -rf ./.codex/support

echo "Creating symbolic link from ~/src/base-prompts/.codex/support to ./.codex/support"
ln -s ~/src/base-prompts/cli_coding/.codex/support ./.codex/support
