# Operations – Overview

This document provides an overview of operational practices (*Betrieb*) within the homelab.

It acts as an entry point for all operational procedures, policies, and drills.

---

## Scope

Operational documentation covers:

* day-to-day operation of systems and services
* change and maintenance procedures
* backup and restore operations
* incident handling and recovery drills

The goal is predictable and reproducible operations.

---

## Principles

Operations follow these principles:

* **Documentation before action**
* **Consistency over convenience**
* **Recoverability at all times**

If an operation cannot be restored, it is considered unsafe.

---

## Structure

Operational documentation is organized into:

* overviews and policies
* step-by-step procedures
* emergency and recovery drills

Each document has a clear scope and responsibility.

---

## Change Discipline

* Changes are planned and documented
* Dependencies are identified upfront
* Rollback paths are defined where applicable

Unplanned changes are treated as incidents.

---

## Relationship to Other Documentation

* Architecture documents define the target state
* Service documents define functional behavior
* NetBox defines the authoritative inventory

Operational documents define **how things are actually done**.

---

## Audience

This documentation is intended for:

* the homelab operator
* technically experienced administrators

It assumes familiarity with the overall homelab architecture.
