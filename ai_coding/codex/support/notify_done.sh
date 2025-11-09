#!/bin/zsh

PARENT_DIR=$(basename "$(dirname "$(dirname "$(realpath "$0")")")")

terminal-notifier -title "${PARENT_DIR} Codex" -subtitle "All Codex TODO items are complete" -message "Task finished in $PARENT_DIR." -sound "Default"