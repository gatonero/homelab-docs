# Homelab – High-Level Overview

This document provides a high-level overview of the homelab.

It describes the guiding principles, structural decisions, and the general operating model. Detailed technical instructions are intentionally covered in the corresponding sub-documents.

---

## Goals

The homelab is designed with the following goals in mind:

* **Stability** – services must run reliably over long periods
* **Reproducibility** – setups must be rebuildable from documentation
* **Transparency** – decisions and dependencies are explicitly documented
* **Maintainability** – future changes should be predictable and controlled

---

## Guiding Principles

### Documentation First

Every relevant decision, configuration, or operational procedure is documented.

If something is not documented, it is considered *non-existent* from an operational point of view.

---

### Consistency Over Convenience

Naming, structure, and configuration follow defined rules, even if this is occasionally less convenient.

Consistency reduces errors, simplifies troubleshooting, and improves long-term maintainability.

---

### Clear Separation of Concerns

* Infrastructure, services, and operations are documented separately
* Responsibilities and dependencies are explicitly stated
* Cross-cutting concerns (DNS, TLS, backups) are handled centrally

---

## Documentation Structure

The documentation is structured into the following main areas:

* **Architecture** – physical and logical structure of the homelab
* **Networking / DNS / TLS** – naming, certificates, and traffic flow
* **Services** – applications and platforms provided by the homelab
* **Operations** – backup, restore, updates, and operational procedures
* **NetBox** – source of truth for infrastructure and services
* **Archive** – historical documents and deprecated approaches

Each area contains an overview document and more detailed sub-documents.

---

## Target State

The homelab is intended to be:

* self-documented
* auditable
* resilient against partial failures
* understandable even after long periods of inactivity

This documentation is a core component of that target state.
