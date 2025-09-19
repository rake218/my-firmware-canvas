# My Firmware Canvas 🖌️

> A personal playground for embedded C challenges, firmware experiments, and hands-on problem-solving.

## 🎯 Purpose
A living portfolio of embedded C challenges documenting:
- Real-world firmware problems
- Design patterns, algorithms, and optimizations
- Portable, tested solutions
- CI/CD and containerized builds

## 📂 Structure
- `challenges/` – each challenge with `src`, `tests`, `docs`, README
- `templates/` – starter templates for new challenges
- `docs/` – roadmap, style guides, contributing
- `tools/` – scripts for testing/linting
- `.github/workflows/` – CI pipelines
- `.devcontainer/` – Codespaces container setup

## 🚦 Quick Start
Run all tests via:
- `./tools/run_all_tests.sh`
Run a single challenge in Docker
- `cd challenges/001-sample-challenge`
- `docker build -t challenge001 .`
- `docker run challenge001`

## License
MIT — see LICENSE.




