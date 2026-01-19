# Proxmox

This document describes the role of Proxmox in the homelab.

Proxmox is used as the central virtualization platform for virtual machines and containers.

---

## Purpose

Proxmox provides:

* centralized management of virtual machines
* reliable virtualization based on KVM
* integrated storage and networking features
* a stable foundation for long-running services

It is a core infrastructure component.

---

## Cluster Model

The homelab uses a Proxmox cluster model:

* one or more Proxmox nodes
* consistent node naming
* shared operational principles

Even single-node setups follow the cluster model to ensure future scalability.

---

## Naming and Identity

* Proxmox node names are stable and descriptive
* Hostname, node name, and certificates must be consistent
* Each node is documented in NetBox

Inconsistent naming is considered a configuration error.

---

## Access and Security

* Administrative access is performed via HTTPS
* TLS certificates are explicitly managed
* Direct access via IP addresses is avoided where possible

Security exceptions are treated as temporary and must be resolved.

---

## Virtual Machines

* Each virtual machine has a defined purpose
* VM names reflect their role
* Resource allocation is documented

Virtual machines are treated as long-lived systems, not disposable test instances.

---

## Backups

* All Proxmox-managed virtual machines are backed up regularly
* Backup schedules and retention policies are documented
* Restore procedures are tested and documented

Backups are an operational requirement, not an optional feature.

---

## Operational Principles

* Changes are planned and documented
* Proxmox configuration drift is avoided
* Updates are performed in a controlled manner

Proxmox is operated as production infrastructure, even in a homelab context.
