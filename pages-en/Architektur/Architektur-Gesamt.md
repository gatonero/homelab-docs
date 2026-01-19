# Overall Architecture

This document describes the overall architecture of the homelab.

It provides a consolidated view of all architectural layers and their interactions.

---

## Overview

The homelab architecture is designed as a cohesive system composed of multiple clearly defined layers.

Each layer has a specific responsibility and interacts with other layers through well-defined interfaces.

---

## Physical Layer

The physical layer consists of:

* servers and compute nodes
* storage systems
* network hardware

Physical components are selected for reliability, efficiency, and long-term operation.

---

## Virtualization Layer

The virtualization layer is built on Proxmox and provides:

* virtual machines for long-running services
* controlled resource allocation
* isolation between workloads

Virtualization abstracts hardware complexity from services.

---

## Service Layer

The service layer includes:

* containerized services (Docker)
* VM-based applications
* infrastructure services

Services are documented, versioned, and monitored.

---

## Access and Control Plane

The access layer provides:

* DNS-based service discovery
* TLS-secured access
* traffic routing via Reverse Proxy

This layer defines how users and systems access services.

---

## Data and Backup Layer

The data layer covers:

* persistent application data
* backups and snapshots
* restore mechanisms

Data protection is treated as a core architectural concern.

---

## Architectural Consistency

* Naming conventions apply across all layers
* Documentation reflects the target state
* NetBox provides the authoritative inventory

Consistency reduces complexity and operational risk.

---

## Evolution

The architecture is expected to evolve over time.

Changes are:

* planned and documented
* reviewed for impact
* implemented incrementally

Architecture is treated as a living system, not a fixed design.
