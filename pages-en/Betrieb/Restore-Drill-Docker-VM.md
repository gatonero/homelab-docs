# Restore Drill – Docker VM

This document describes the restore drill for the Docker virtual machine.

A restore drill is a planned exercise to verify that backups and restore procedures work as intended.

---

## Purpose

The restore drill exists to:

* validate backup integrity
* verify restore procedures
* reduce risk during real incidents

A restore that has not been tested is considered unreliable.

---

## Scope

This drill covers:

* the Docker virtual machine
* attached storage and volumes
* service startup after restore

It does not validate application-level data consistency.

---

## Preconditions

Before starting the drill:

* current backups must be available
* the target Proxmox environment must be operational
* sufficient time must be reserved

Drills must not be performed under time pressure.

---

## Drill Procedure

### 1. Preparation

* Identify the backup to be used
* Document the current system state
* Inform affected users, if applicable

---

### 2. Restore

* Stop the Docker VM
* Restore the VM from backup
* Start the restored VM

---

### 3. Verification

* Verify VM availability
* Check critical services
* Review logs for anomalies

---

### 4. Evaluation

* Document findings
* Identify gaps or improvements
* Update procedures if necessary

---

## Documentation

* Record the drill date and outcome
* Store results alongside operational documentation

Restore drills are part of regular operations, not exceptional events.
