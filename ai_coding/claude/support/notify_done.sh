#!/bin/zsh

PARENT_DIR=$(basename "$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")")

terminal-notifier -title "${PARENT_DIR} Claude" -subtitle "All Claude TODO items are complete" -message "Task finished in $PARENT_DIR." -sound "Default"