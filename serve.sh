#!/usr/bin/env bash
set -e
ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT/src"

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js is required. Install from https://nodejs.org/"
  exit 1
fi

if [ ! -d "$SRC/node_modules" ]; then
  echo "Installing dependencies..."
  (cd "$SRC" && npm install)
fi

echo "Starting local server at http://localhost:8080"
(cd "$SRC" && node node_modules/@11ty/eleventy/cmd.cjs --serve)
