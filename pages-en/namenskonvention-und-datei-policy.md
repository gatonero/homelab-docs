# Naming Conventions and File Policy

This document defines the binding naming conventions and file policies used throughout the homelab documentation.

The goal is to ensure consistency, clarity, and long-term maintainability.

---

## General Principles

* Names must be **clear, descriptive, and unambiguous**
* Abbreviations are only used if they are well established (e.g. DNS, VM, TLS)
* Naming rules are applied consistently across all systems and documents

If a resource is not named according to these rules, it is considered **non-compliant**.

---

## File and Directory Naming

### Language and Format

* File and directory names use **English**
* Words are separated by hyphens (`-`)
* Uppercase and lowercase are used intentionally and consistently

**Examples:**

* `networking-dns-tls.md`
* `proxmox-backup-strategy.md`
* `docker-services-overview.md`

---

### Stability of File Names

Once a file name is established:

* it must **not** be changed lightly
* renaming requires a clear reason
* references from other documents must be updated accordingly

Stable file names ensure reliable links and long-term usability.

---

## Terminology Policy

### Technical Terms

* Technical terms remain in **English** (e.g. *Reverse Proxy*, *Retention*, *Node*)
* The same term is used consistently across all documents
* Synonyms are avoided unless explicitly documented

---

### Consistency Over Translation

When translating from German to English:

* consistency takes precedence over literal translation
* technically correct wording is preferred over stylistic elegance
* ambiguous terms are clarified where necessary

---

## Document Lifecycle

* Documents reflect the **current target state** by default
* Deprecated approaches are moved to the **Archive**
* Historical context is preserved, but clearly marked

Documentation is treated as a **living system**, but changes are controlled and intentional.

---

## Enforcement

These conventions are binding for:

* all documentation under `pages/`
* future extensions of the repository

Exceptions must be explicitly documented and justified.
