# Architecture – Overview

This document provides an overview of the homelab architecture.

It describes the structural layout, core components, and guiding architectural decisions.

---

## Purpose

The architecture documentation exists to:

* describe the target state of the homelab
* provide orientation for operational and service documents
* make dependencies and responsibilities explicit

It focuses on structure, not implementation details.

---

## Architectural Scope

The architecture covers:

* physical hardware
* virtualization and hosting platforms
* network segmentation and connectivity
* core infrastructure services

Detailed configurations are documented in the corresponding sub-documents.

---

## Design Principles

The architecture follows these principles:

* **Clarity over complexity**
* **Consistency across layers**
* **Separation of concerns**
* **Recoverability by design**

Architectural decisions are documented and revisited deliberately.

---

## Layers

The homelab architecture is structured into layers:

* **Physical layer** – hardware and network devices
* **Virtualization layer** – Proxmox and virtual machines
* **Service layer** – containers and applications
* **Access layer** – DNS, TLS, and Reverse Proxy

Each layer has defined responsibilities and interfaces.

---

## Documentation Relationship

* Architecture documents define constraints and structure
* Operational documents define procedures
* Service documents define functionality
* NetBox defines the authoritative inventory

All documentation layers must remain consistent.

---

## Target Audience

This document is intended for:

* the homelab operator
* technically experienced administrators

It assumes familiarity with virtualization and networking concepts.
