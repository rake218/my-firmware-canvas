#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
echo "Repository root: $ROOT"

PASS=0
FAIL=0

for d in "$ROOT"/challenges/*/; do
  [ -d "$d" ] || continue
  echo
  echo "=== Running tests for: $(basename "$d") ==="

  # 1) If explicit harness exists, run it via bash
  if [ -f "${d}tests/run_tests.sh" ]; then
    echo "Found harness: ${d}tests/run_tests.sh — running with bash"
    (cd "$d" && bash tests/run_tests.sh) && { echo "OK (harness)"; PASS=$((PASS+1)); } || { echo "FAIL (harness)"; FAIL=$((FAIL+1)); }
    continue
  fi

  # 2) compile any test_*.c files found in tests/
  shopt -s nullglob || true
  tests=( "$d"tests/test_*.c )
  if [ "${#tests[@]}" -gt 0 ]; then
    for t in "${tests[@]}"; do
      exe="${t%.c}.exe"
      echo "Compiling: $t -> $exe"
      gcc -Wall -Werror -O2 -std=c99 -I"$d/src" "$t" "$d/src/"*.c -o "$exe"
      echo "Running: $exe"
      (cd "$(dirname "$t")" && "./$(basename "$exe")") && { echo "OK: $(basename "$t")"; PASS=$((PASS+1)); } || { echo "FAIL: $(basename "$t")"; FAIL=$((FAIL+1)); }
    done
    continue
  fi

  echo "No host tests found in $(basename "$d"), skipping."
done

echo
echo "Summary: Passed: $PASS, Failed: $FAIL"

if [ "$FAIL" -ne 0 ]; then
  echo "Some tests failed."
  exit 2
fi

echo "All challenge tests succeeded."
