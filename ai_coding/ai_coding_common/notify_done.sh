#!/bin/zsh

AGENT_SERVICE=$1
PROJECT_NAME=$2
SUMMARY=$3

terminal-notifier \
  -title "${PROJECT_NAME} ${AGENT_SERVICE}" \
  -subtitle "${SUMMARY}" \
  -message "${SUMMARY}" \
  -ignoreDnD \
  -sound "Default"
