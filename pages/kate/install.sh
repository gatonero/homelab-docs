#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Building snippets..."

source "$ROOT/.venv/bin/activate"

python "$ROOT/build.py"

echo
echo "Generated files:"

find "$ROOT/snippets" -type f | sort
