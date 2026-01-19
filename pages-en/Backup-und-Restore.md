# Backup and Restore

This document describes the backup and restore strategy of the homelab.

Reliable backups and well-tested restore procedures are essential for stable operation.

---

## Backup Strategy

The backup strategy is designed to:

* protect against data loss
* enable fast and predictable recovery
* minimize operational risk

Backups are treated as a first-class operational concern.

---

## Scope of Backups

The following components are included in regular backups:

* virtual machines managed by Proxmox
* application data stored on network storage
* critical configuration files

Temporary data and caches are excluded unless explicitly documented.

---

## Backup Frequency

* Backups are performed on a regular schedule
* The frequency depends on the criticality of the system
* Backup jobs are monitored for successful completion

Failures are investigated immediately.

---

## Retention Policy

* Backup retention is defined explicitly
* Retention balances recovery needs and storage usage
* Old backups are removed automatically according to policy

Retention settings are documented and reviewed periodically.

---

## Restore Procedures

* Restore procedures are documented step by step
* Restores are tested regularly
* Dependencies and prerequisites are clearly stated

A backup that cannot be restored is considered **invalid**.

---

## Operational Rules

* Backup configurations are versioned
* Changes to backup jobs are documented
* Emergency restores follow predefined procedures

Backup and restore operations must be reproducible and auditable.

---

## Responsibility

Backup and restore are the responsibility of the homelab operator.

Automation is used where possible, but manual understanding is mandatory.
