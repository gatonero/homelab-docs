# Backup – Overview

This document provides an overview of backup operations within the homelab.

It summarizes scope, responsibilities, and guiding principles for all backup-related procedures.

---

## Purpose

Backups exist to:

* protect against data loss
* enable reliable recovery
* support disaster and failure scenarios

Backups are an operational requirement, not an optional convenience.

---

## Scope

Backup operations cover:

* virtual machines
* application data
* critical configuration files

Each backup scope is documented explicitly in the corresponding procedures.

---

## Responsibility

* The homelab operator is responsible for backup integrity
* Backup jobs are monitored regularly
* Failures are investigated immediately

Responsibility is not delegated to automation alone.

---

## Verification

* Backups are verified via restore tests
* Restore procedures are documented
* Verification results are reviewed periodically

An untested backup is considered unreliable.

---

## Retention

* Retention policies are defined per backup type
* Storage usage and recovery needs are balanced
* Retention settings are reviewed regularly

Retention is part of the backup strategy, not an afterthought.

---

## Relationship to Other Documentation

* Detailed backup procedures are documented separately
* Restore drills validate backup effectiveness
* NetBox documents affected systems

This document provides orientation, not step-by-step instructions.
