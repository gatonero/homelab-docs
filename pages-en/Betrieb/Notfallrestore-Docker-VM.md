# Emergency Restore – Docker VM

This document describes the emergency restore procedure for the Docker virtual machine.

It is intended to be used in failure scenarios where fast and reliable recovery is required.

---

## Scope

This procedure applies to:

* the Docker virtual machine
* services hosted on that VM
* associated persistent data

It does not cover application-level restore details.

---

## Preconditions

Before starting the restore:

* backups must be available and verified
* the target Proxmox node must be operational
* required credentials must be accessible

Missing prerequisites must be resolved before proceeding.

---

## Restore Principles

* Follow the documented steps strictly
* Avoid improvisation during emergency situations
* Document deviations immediately

Consistency is more important than speed.

---

## High-Level Procedure

1. Stop the affected virtual machine
2. Identify the correct backup and restore point
3. Restore the VM using Proxmox backup tools
4. Verify VM startup and basic functionality
5. Validate service availability

Detailed steps are documented in the corresponding restore drill.

---

## Verification

After restore:

* confirm VM accessibility
* verify critical services
* check logs for errors

The restore is not complete until verification succeeds.

---

## Documentation

* Record the incident and restore actions
* Update documentation if gaps were identified

Every emergency restore is a learning opportunity.
