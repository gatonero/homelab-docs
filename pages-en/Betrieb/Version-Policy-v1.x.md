# Version Policy – v1.x

This document defines the versioning policy for documentation and related artifacts in the homelab.

It ensures predictable changes and long-term stability.

---

## Purpose

The version policy exists to:

* make changes traceable
* communicate stability expectations
* avoid accidental breaking changes

Versioning applies primarily to documentation, not to running services.

---

## Version Scheme

* The `v1.x` series represents a stable documentation baseline
* Minor versions (`x`) indicate backward-compatible changes
* Breaking changes require a new major version

---

## What Constitutes a Change

Examples of version-relevant changes:

* structural reorganization of documentation
* changes to operational procedures
* updates that affect restore or backup processes

Pure typo fixes may not require a version increment.

---

## Release Process

* Changes are collected on feature branches
* A release is created deliberately
* Release notes summarize relevant changes

Releases represent reviewed and approved states.

---

## Compatibility

* Documentation within the same major version is considered compatible
* Older versions remain readable but may be outdated

Readers should always refer to the latest release.

---

## Responsibility

* The homelab operator decides on version increments
* Version changes are documented explicitly

Versioning is a communication tool, not bureaucracy.
