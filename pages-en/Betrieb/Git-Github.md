# Git and GitHub

This document describes how Git and GitHub are used together in the homelab documentation workflow.

It focuses on practical usage patterns rather than Git fundamentals.

---

## Purpose

Git and GitHub are used to:

* track changes to documentation
* provide a clear history of decisions
* support review and rollback

They are essential tools for maintainable documentation.

---

## Local Workflow

* Changes are made locally
* Documentation is reviewed before committing
* Commits represent logical units of change

Working copies are kept clean and reproducible.

---

## Branch Usage

* New work is done on dedicated branches
* Branch names are descriptive
* Long-lived branches are avoided unless explicitly required

The `main` branch remains stable at all times.

---

## Commit Messages

* Commit messages describe *what* and *why*
* Imperative mood is preferred
* Noise commits are avoided

Readable history is considered an operational asset.

---

## Synchronization

* Regular pulls keep branches up to date
* Rebasing is preferred for local cleanup
* Conflicts are resolved deliberately

Synchronization issues are addressed immediately.

---

## Publishing Changes

* Only reviewed changes are pushed to public branches
* Sensitive information is never committed
* Public visibility is always assumed

GitHub is treated as a public documentation platform.
