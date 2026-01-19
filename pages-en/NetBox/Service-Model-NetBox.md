# NetBox – Service Model

This document describes how the service model is represented and maintained in NetBox.

It explains which service-related information is stored in NetBox and how it relates to the overall homelab documentation.

---

## Purpose

The NetBox service model provides:

* a structured overview of exposed services
* clear assignment of services to devices or virtual machines
* a logical view of protocols and ports

It represents the **logical service layer**, not runtime configuration details.

---

## What Is Documented

For each service, NetBox documents:

* service name
* protocol (e.g. HTTP, HTTPS, TCP)
* port
* associated device or VM
* short functional description

Only actively used services are documented.

---

## Naming Rules

* Service names are stable and descriptive
* Names reflect the service function
* Implementation details are avoided in names

Consistency with DNS names and documentation is mandatory.

---

## Relationship to DNS and TLS

* Services are linked conceptually to their DNS names
* TLS usage and termination points are documented
* Reverse Proxy involvement is clearly stated

NetBox must remain consistent with DNS and TLS documentation.

---

## Lifecycle Management

* Services are added to NetBox before production use
* Changes are reflected immediately
* Deprecated services are removed or archived

Undocumented services are considered out of policy.

---

## Boundaries

NetBox does **not** store:

* configuration files
* secrets or credentials
* implementation-specific parameters

Those belong to operational documentation and configuration management.
