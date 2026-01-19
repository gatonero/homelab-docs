# GitHub Setup

This document describes how GitHub is used for version control and documentation management in the homelab.

GitHub serves as the central repository for all documentation and related configuration artifacts.

---

## Purpose

GitHub is used to:

* version documentation and configuration files
* track changes and decisions over time
* enable review and collaboration

It is the authoritative source for the documentation history.

---

## Repository Structure

* The repository is organized by functional areas
* Documentation lives primarily under the `pages/` directory
* Supporting files are kept alongside relevant documentation

The structure is designed for clarity and long-term maintainability.

---

## Branching Model

* `main` represents the stable baseline
* Feature or topic branches are used for changes
* Documentation changes are reviewed before merging

Branches are kept focused and short-lived.

---

## Commit Policy

* Commits are small and logically scoped
* Commit messages are descriptive and consistent
* Each commit should represent a meaningful change

History readability is considered important.

---

## Review and Merging

* Changes are reviewed before merging into `main`
* Reviews focus on correctness and clarity
* Breaking changes are highlighted explicitly

Merging is a deliberate action, not a routine task.

---

## Publishing

* The repository is public
* Documentation is intended to be readable without additional context
* Sensitive information is never committed

GitHub is treated as a public-facing platform.
