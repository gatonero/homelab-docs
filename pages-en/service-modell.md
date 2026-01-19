# Service Model

This document defines the service model used in the homelab.

The service model describes how services are identified, documented, and related to infrastructure components.

---

## Definition of a Service

A *service* is any functionality that is:

* reachable via the network
* exposed via a defined protocol and port
* intended for regular or long-term use

A service may be provided by:

* a virtual machine
* a container
* a physical device

---

## Scope

The service model applies to:

* internally used services
* infrastructure services (DNS, reverse proxy, monitoring)
* user-facing applications

Temporary test services are excluded unless explicitly documented.

---

## Service Representation

Each service is documented with the following attributes:

* service name
* protocol (e.g. HTTP, HTTPS, TCP)
* port
* hosting system (device or VM)
* short description of purpose

This information is maintained centrally in NetBox.

---

## Naming Rules

* Service names are descriptive and stable
* Names reflect the *function*, not the implementation
* Abbreviations are avoided unless well established

Examples:

* `paperless-ngx-web`
* `jellyfin-media-server`
* `nginx-proxy-manager`

---

## Relationship to DNS and TLS

* Each service is reachable via a defined DNS name
* TLS termination is documented explicitly
* Reverse proxy involvement is clearly stated

DNS, TLS, and service documentation must remain consistent.

---

## Lifecycle Management

* Services are documented before being put into production
* Changes are reflected immediately
* Decommissioned services are removed or archived

Undocumented services are considered **out of policy**.

---

## Purpose of the Model

The service model ensures:

* transparency of exposed functionality
* traceability of dependencies
* consistent documentation across the homelab

It is a foundational element for operations, troubleshooting, and future expansion.
