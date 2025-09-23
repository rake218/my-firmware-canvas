# My Firmware Canvas 🖌️

> A personal playground for embedded C challenges, firmware experiments, and hands-on problem-solving.

[![CI](https://github.com/rake218/my-firmware-canvas/actions/workflows/ci.yml/badge.svg)](https://github.com/rake218/my-firmware-canvas/actions/workflows/ci.yml)  

---

## Table of contents

- [Why this repo exists](#why-this-repo-exists)  
- [What you’ll find here](#what-youll-find-here)  
- [Project structure (canonical)](#project-structure-canonical)  
- [How to run tests (quick)](#how-to-run-tests-quick)  
- [Run single challenge (Docker)](#run-single-challenge-docker)  
- [Development (Codespaces / Devcontainer)](#development-codespaces--devcontainer)
- [How to add a new challenge — step-by-step](#how-to-add-a-new-challenge)
- [CI / expectations](#ci--expectations)  
- [Contributing](#contributing)  
- [Release checklist & tags](#release-checklist--tags)  
- [FAQ / Practical tips](#faq--practical-tips)
- [Commit message style (recommended)](#commit-message-style)
- [License & contact](#license--contact)


# Why this repo exists

This is my personal engineering notebook — not just code snippets, but full problem narratives:

- capture why a problem matters  
- record how I designed the solution  
- provide portable, tested code that anyone can run  
- show good engineering practices (CI, containerization, documentation)

Target audience: fellow firmware engineers and future-me.

---

# What you’ll find here

- `challenges/` — each challenge is a standalone story (ID, problem, design, code, tests, results).  
- `templates/` — boilerplate to create a new challenge quickly and consistently.  
- `tools/` — helper scripts (`run_all_tests.sh`, `lint.sh`).  
- `.devcontainer/` — Codespaces / VS Code Remote container configuration.  
- `.github/workflows/` — CI pipelines (build/test).  
- `docs/` — styleguide, roadmap, experimental notes.

---

# Project structure (canonical)

```
my-firmware-canvas/
├─ README.md
├─ challenges/
│  ├─ 001-audio-buffer-rtos/
│  │  ├─ src/
│  │  │  └─ audio_buffer.c
│  │  ├─ tests/
│  │  │  └─ test_audio_buffer.c
│  │  ├─ docs/
│  │  │  └─ design.md
│  │  ├─ Dockerfile
│  │  └─ README.md
│  └─ 002-driver-pattern/
├─ templates/
│  └─ challenge-README-template.md
├─ tools/
│  ├─ run_all_tests.sh
│  └─ lint.sh
├─ .github/
│  └─ workflows/ci.yml
└─ .devcontainer/
   ├─ devcontainer.json
   └─ Dockerfile
```

---
# How to run tests (quick)

**Recommended:** open this repository in GitHub Codespaces or any Linux shell / WSL.

From repository root:

```bash
# Make helper scripts executable (once)
chmod +x ./tools/run_all_tests.sh

# Run all challenge tests
./tools/run_all_tests.sh
```

`tools/run_all_tests.sh` is intentionally simple: it finds and builds canonical test files under `challenges/*/tests/` and runs them. CI calls the same script.

---

# Run single challenge (Docker)

Some challenges include a `Dockerfile` for reproducible execution:

```bash
cd challenges/001-audio-buffer-rtos
docker build -t mfc-challenge-001 .
docker run --rm mfc-challenge-001
```

Docker ensures the same toolchain and environment across machines.

---

# Development (Codespaces / Devcontainer)

Open the repo in GitHub Codespaces or use VS Code Remote - Containers. The `.devcontainer/` folder provides a prebuilt environment with `gcc`, `cmake`, `make`, and common tooling.

Typical steps:

1. Click **Code → Open with Codespaces → New codespace** (or open folder in VS Code Remote - Containers).  
2. Wait for container build; open terminal.  
3. Run `./tools/run_all_tests.sh` to validate the environment.

---

# How to add a new challenge

1. Copy `templates/challenge-README-template.md` (or use repository UI Add file → new file).  
2. Create a new folder under `challenges/` using a zero-padded ID and a short slug: e.g. `challenges/003-short-slug/`.  
3. Add subfolders: `src/`, `tests/`, `docs/`.  
4. Add `README.md` from the template and update “Problem”, “Approach”, and “Results”.  
5. Add one or more `tests/` that compile and run on a Linux host (no hardware required). Tests should exit `0` on success.  
6. Optionally add a `Dockerfile` for reproducibility.  
7. Run `./tools/run_all_tests.sh` locally (or push & let CI run).  
8. Create a PR with meaningful commit messages (see style guide in `docs/`).

---

---

# CI / expectations

GitHub Actions in `.github/workflows/ci.yml` should:

- Build and run **all host-executable tests** via `tools/run_all_tests.sh`.  
- Run lint/format checks (optional).  
- Optionally build artifacts for release per challenge.

**CI expectations:**

- Tests must be deterministic on Ubuntu runners.  
- Avoid hardware-only tests in CI; include host-simulated tests or mocks instead.  
- For peripheral behavior, include integration notes and `Renode`/`QEMU` scripts under `docs/` or `sim/`.

---

# Contributing

Short rules (see `docs/CONTRIBUTING.md` for full guidance):

- Add **one challenge per PR**. Keep PRs focused and small.  
- Include tests that validate the solution on a host compiler.  
- Use the challenge template for README and follow naming conventions.  
- Commit messages examples:
  - `feat(challenge-003): add ring-buffer with unit tests`
  - `fix(ci): update test harness`
- Branch names examples: `feat/003-ring-buffer`, `fix/ci-runner`.

Want to contribute an idea or patch? Open an issue describing the problem and your proposed approach.

---

# Release checklist & tags

When a challenge graduates to a polished project, follow this checklist before tagging:

- [ ] All tests pass locally and in CI.  
- [ ] README includes design doc, results, and how-to-run.  
- [ ] `Dockerfile` builds and runs (if included).  
- [ ] `docs/` updated with any hardware notes.  
- [ ] Add screenshots or short video under `assets/`.  
- [ ] Create Git tag `v0.1.0` (format `v<major>.<minor>.<patch>`).

Example first release:

```bash
git tag -a v0.1.0 -m "v0.1.0 - initial public release of my-firmware-canvas"
git push origin v0.1.0
```

---

## Commit message style

Use the **Conventional Commit** style for clarity and tooling compatibility:

```
<type>(<scope>): <short summary>

[optional body — explain *why*, not *what*]
[optional footer — issue refs, co-authors, sign-off]
```

**Common `type` values you’ll use for docs and maintenance:**

- `docs` — documentation changes (README, CONTRIBUTING)  
- `chore` — repo maintenance (formatting, build tweaks)  
- `ci` — CI/workflow changes

**Guidelines**

- Keep the short summary **≤ 50 characters**.  
- Use a blank line between the short summary and the optional body.  
- The optional body should explain **why** the change was made, not what changed.  
- If relevant, include issue references or `Co-authored-by:` footers.

**Examples**

```
docs(readme): add commit message style guidance

Explains Conventional Commit format and examples to help contributors write clear commits.
```

```
chore(readme): reformat headings and code blocks
```

```
ci(workflow): add test matrix for ubuntu and macos
```

**PR title suggestion:** use the same short summary as your primary commit message, e.g.  
`docs(readme): add commit message style guidance`

**Amending commits**

If you just committed and want to change the message:

```bash
# Edit the last commit message
git commit --amend -m "docs(readme): better commit message here"

# If already pushed, force-update the remote safely
git push --force-with-lease
```

# FAQ / Practical tips

**Q: I don’t have hardware on hand — how do I test?**  
A: Keep tests host-side and use mocks or small simulators. Use QEMU or Renode for more advanced peripheral simulation.


---

# License & contact

Licensed under the **MIT License** — see `LICENSE` for details.
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)]

