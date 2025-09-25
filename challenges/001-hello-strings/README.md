# Challenge 001: Hello Strings (functions & tests)

## Problem (context)
Verify small, portable C code that exposes functions returning/formatting greeting strings.
Goal is to keep logic testable on host (Linux), independent from embedded hardware.

## Goal
- Provide a small, well-documented example that demonstrates:
  - function API design (buffer-in/out)
  - host-executable unit tests
  - reproducible builds (host + Docker)
  - CI-friendly tests

## Files
- `src/greetings.h`, `src/greetings.c` — implementation
- `tests/test_greetings.c` — unit test
- `tests/run_tests.sh` — harness to compile & run tests
- `Dockerfile` (optional) — reproducible container run

## How to run (host)
From repository root (Codespaces / WSL / Linux):
- `cd challenges/001-hello-strings`
- `chmod +x tests/run_tests.sh        # first time only (or CI runs via bash)`
- `./tests/run_tests.sh`
