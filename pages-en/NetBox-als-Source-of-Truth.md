# NetBox as the Source of Truth

This document defines the role of NetBox as the central *Source of Truth* for the homelab.

NetBox is used to document infrastructure, services, and relationships in a structured and authoritative way.

---

## Purpose

NetBox serves as the single authoritative source for:

* physical devices
* virtual machines
* IP addressing and networks
* services and service dependencies
* roles, tags, and metadata

If information exists both in NetBox and elsewhere, **NetBox takes precedence**.

---

## Scope of Documentation

The following elements are documented in NetBox:

* physical hosts (servers, NAS, network devices)
* virtual machines and containers
* network interfaces and IP addresses
* VLANs and network segments
* services and exposed endpoints
* relationships between components

NetBox does **not** replace operational documentation, but complements it.

---

## Roles and Naming

### Device and VM Roles

* Roles describe the **function**, not the implementation
* Roles are stable and reused consistently
* A device or VM has exactly **one primary role**

Examples:

* `server`
* `network`
* `storage`
* `infrastructure`

---

### Naming Conventions

* Names in NetBox follow the global naming conventions
* Hostnames, VM names, and service names must match documentation
* Deviations are not permitted

Consistency between NetBox and documentation is mandatory.

---

## Service Model

Services are documented in NetBox with:

* service name
* protocol and port
* associated device or VM
* purpose and description

NetBox represents the **logical service model**, not runtime configuration details.

---

## Operational Rules

* NetBox is updated **before or together with** any infrastructure change
* Temporary deviations must be documented explicitly
* NetBox data is reviewed regularly

If something is not reflected in NetBox, it is considered **undefined**.

---

## Benefits

Using NetBox as the Source of Truth provides:

* a consistent and authoritative data model
* improved troubleshooting and impact analysis
* reduced configuration drift
* long-term maintainability

NetBox is not optional. It is a **core component** of the homelab architecture.
