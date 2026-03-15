#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

BUILD_FILE="$SCRIPT_DIR/build.gradle.kts"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required to install plugin build dependencies." >&2
  exit 1
fi

if ! brew list --versions openjdk@21 >/dev/null 2>&1; then
  HOMEBREW_NO_INSTALL_CLEANUP=1 brew install openjdk@21
fi

JAVA_HOME="$(/usr/libexec/java_home -v 21 2>/dev/null || true)"

if [ -n "$JAVA_HOME" ]; then
  if [ ! -x "$JAVA_HOME/bin/java" ]; then
    JAVA_HOME=""
  else
    java_version_output="$("$JAVA_HOME/bin/java" -version 2>&1 || true)"
    if [[ "$java_version_output" != *21.* ]]; then
      JAVA_HOME=""
    fi
  fi
fi

if [ -z "$JAVA_HOME" ]; then
  JAVA_HOME="$(brew --prefix openjdk@21)/libexec/openjdk.jdk/Contents/Home"
fi
export JAVA_HOME
export PATH="$JAVA_HOME/bin:$PATH"

version_line="$(grep -m 1 -E '^[[:space:]]*version = "[0-9]+\.[0-9]+\.[0-9]+"[[:space:]]*$' "$BUILD_FILE")"
current_version="$(printf '%s\n' "$version_line" | sed -E 's/^[[:space:]]*version = "([0-9]+\.[0-9]+\.[0-9]+)"[[:space:]]*$/\1/')"
IFS='.' read -r major_version minor_version patch_version <<< "$current_version"
next_version="${major_version}.${minor_version}.$((patch_version + 1))"

perl -0pi -e 's/^[[:space:]]*version = "\Q'"$current_version"'\E"[[:space:]]*$/version = "'"$next_version"'"/m' "$BUILD_FILE"

echo "Incremented plugin version: $current_version -> $next_version"

./gradlew clean build buildPlugin

distribution_path="$(find "$SCRIPT_DIR/build/distributions" -maxdepth 1 -type f -name '*.zip' | sort | tail -n 1)"

echo "Plugin distribution created at: $distribution_path"
