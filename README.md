# Homelab Documentation

This repository contains a **conceptual, versioned documentation** of a personal homelab environment.

The focus is on **architecture, networking, services, operations, security, and governance**, with a strong emphasis on clarity, reproducibility, and long-term maintainability. The documentation applies **production-style thinking** to a homelab context.

---

## Purpose

The goal of this repository is to:

- document the homelab as a **coherent system**, not a collection of tools
- make **architectural and operational decisions explicit and traceable**
- separate **principles and concepts** from concrete implementations
- provide a stable reference for **operation, change, and recovery**

This is not a quick-start guide. It is a **long-term reference**.

---

## Documentation Languages

The documentation is available in two languages:

- 🇩🇪 **German documentation:** `pages/`
- 🇬🇧 **English documentation:** `pages-en/`

The English documentation is a **complete translation** of the German original and follows the same structure, conventions, and conceptual boundaries.

---

## Structure

The documentation is organized into clearly separated layers:

- **Architecture** – structure, principles, dependencies, integration
- **Operations** – backup, restore, monitoring, lifecycle
- **Security** – access models, segmentation, secrets
- **Governance** – documentation rules, review processes, versioning
- **Inventory (NetBox)** – source of truth and relationships

Each layer builds on the previous ones.

---

## Start Here

If you are new to this documentation, start with the following pages:

- **Homelab Overview**  
  [`pages/00-Overview-Homelab.md`](pages/00-Overview-Homelab.md)  
  High-level introduction and conceptual entry point.

- **Architecture Overview**  
  [`pages/Architektur/Overview-Architektur.md`](pages/Architektur/Overview-Architektur.md)  
  Structural principles, roles, and dependencies.

- **Operations Overview**  
  [`pages/Betrieb/Overview-Betrieb.md`](pages/Betrieb/Overview-Betrieb.md)  
  Backup, restore, monitoring, and lifecycle concepts.

- **Security Overview**  
  [`pages/Sicherheit/Zugriffsmodell.md`](pages/Sicherheit/Zugriffsmodell.md)  
  Access models and security boundaries.

- **Inventory / NetBox Overview**  
  [`pages/NetBox/Overview-NetBox.md`](pages/NetBox/Overview-NetBox.md)  
  Inventory model and source-of-truth concepts.
---

## Guiding Principles

- Conceptual first, implementation second
- Stability over short-term optimization
- Explicit dependencies instead of implicit knowledge
- Documentation as part of operations
- Reproducibility and traceability

---

## Intended Audience

This documentation is written for **technically experienced administrators and engineers**.

It is not a step-by-step beginner tutorial. Instead, it is intended to serve as:

- a technical reference
- a decision log
- a long-term knowledge base

---

## Versions

Releases mark **stable reference points** of the documentation:

- `v1.x` – initial documentation
- `v2.0.0` – canonical structure established
- `v2.1.0` – consolidated architecture, operations, security, and governance

The `main` branch always reflects the latest stable state.

---

## Logseq and GitHub

The same content is also maintained in a **Logseq graph** for local knowledge management and navigation.

- **GitHub** is used for canonical version control, releases, and external reference
- **Logseq** is used as a working environment and exploration tool

---

## License

This documentation is intended for learning, inspiration, and reuse.

See [`LICENSE`](LICENSE) for details.

---

## Status

Current stable release: **v2.1.0**

The documentation is actively maintained and extended in small, deliberate steps.
