#!/usr/bin/env bash
set -euo pipefail

# Simple harness to compile and run the C unit test on host
# Works in Codespaces / WSL / Linux and inside CI via: bash ./tests/run_tests.sh

here="$(cd "$(dirname "$0")" && pwd)"
srcdir="$(cd "$here/../src" && pwd)"

echo "Compiling test..."
gcc -Wall -Werror -O2 -std=c99 -I "$srcdir" "$srcdir/greetings.c" "$here/test_greetings.c" -o "$here/test_greetings"

echo "Running test..."
"$here/test_greetings"
