#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
echo "Repository root: $ROOT"

# By default, skip challenges that provide their own Dockerfile.
# To force running Dockerfile-based challenges locally, set:
#   RUN_DOCKER_CHALLENGES=1 ./tools/run_all_tests.sh
RUN_DOCKER_CHALLENGES="${RUN_DOCKER_CHALLENGES:-}"

PASS=0
FAIL=0

for d in "$ROOT"/challenges/*/; do
  [ -d "$d" ] || continue
  CHAL_NAME="$(basename "$d")"
  echo
  echo "=== Running tests for: $CHAL_NAME ==="

  # If a per-challenge Dockerfile exists, skip by default.
  if [ -f "${d}Dockerfile" ] && [ -z "$RUN_DOCKER_CHALLENGES" ]; then
    echo "Found per-challenge Dockerfile in $CHAL_NAME — skipping in host-runner."
    echo "To run locally, set RUN_DOCKER_CHALLENGES=1 and ensure Docker is available."
    continue
  fi

  # If Dockerfile exists and RUN_DOCKER_CHALLENGES=1, build & run inside Docker
  if [ -f "${d}Dockerfile" ] && [ -n "$RUN_DOCKER_CHALLENGES" ]; then
    echo "Found per-challenge Dockerfile in $CHAL_NAME — building and running inside Docker."
    IMAGE_NAME="mfc-${CHAL_NAME}-local"
    (
      set -x
      docker build -t "${IMAGE_NAME}" "${d}"
      # Run tests inside container. Mount repo root to /workspace and run either harness or make test.
      docker run --rm -v "${ROOT}":/workspace -w "/workspace/challenges/${CHAL_NAME}" "${IMAGE_NAME}" bash -lc '
        if [ -f tests/run_tests.sh ]; then
          chmod +x tests/run_tests.sh || true
          bash tests/run_tests.sh
        elif [ -f Makefile ]; then
          make test
        else
          echo "No tests found in container for this challenge." ; exit 0
        fi
      '
    ) && { echo "OK (docker)"; PASS=$((PASS+1)); } || { echo "FAIL (docker)"; FAIL=$((FAIL+1)); }
    continue
  fi

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

  echo "No host tests found in $CHAL_NAME, skipping."
done

echo
echo "Summary: Passed: $PASS, Failed: $FAIL"

if [ "$FAIL" -ne 0 ]; then
  echo "Some tests failed."
  exit 2
fi

echo "All challenge tests succeeded."
