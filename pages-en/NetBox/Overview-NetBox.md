# NetBox – Overview

This document provides an overview of how NetBox is used within the homelab.

NetBox acts as the central system for documenting infrastructure, services, and their relationships.

---

## Role of NetBox

NetBox is used as:

* the authoritative inventory of devices and virtual machines
* the central registry for IP addresses and networks
* the documentation layer for services and dependencies

It complements, but does not replace, operational documentation.

---

## Scope

Within the homelab, NetBox covers:

* physical hardware
* virtual machines and their roles
* network topology and addressing
* service exposure and dependencies

Information stored in NetBox must always reflect the current target state.

---

## Data Ownership

* NetBox is the single source of truth for structural data
* Other documentation may reference NetBox, but must not contradict it
* In case of conflict, NetBox data takes precedence

---

## Usage Principles

* NetBox is updated before or together with infrastructure changes
* Temporary states are documented explicitly
* Historical information is not kept in NetBox

NetBox represents the *current*, not the historical, state.

---

## Benefits

Using NetBox in this way provides:

* a consistent and queryable data model
* improved transparency across the homelab
* reduced configuration drift
* better long-term maintainability
