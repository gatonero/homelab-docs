# Services

This document provides an overview of the services operated within the homelab.

It serves as a structural entry point for service-specific documentation.

---

## Purpose

The services layer represents the user-facing and infrastructure functionality provided by the homelab.

Services are:

* documented before production use
* operated in a controlled manner
* integrated into the overall architecture

---

## Categories of Services

Services are grouped into the following categories:

* **Infrastructure services** (e.g. DNS, Reverse Proxy, monitoring)
* **Platform services** (e.g. virtualization, container platforms)
* **Application services** (e.g. media servers, document management)

Each category is documented separately.

---

## Documentation Rules

For each service:

* the purpose is clearly described
* exposure (DNS, ports, TLS) is documented
* dependencies are stated explicitly
  nServices are also registered in NetBox.

---

## Lifecycle

* New services are documented before deployment
* Changes are reflected immediately
* Retired services are removed or archived

Undocumented services are considered out of policy.

---

## Relationship to Other Documentation

* Detailed setup instructions live in service-specific documents
* NetBox provides the structured service inventory
* Backup and restore implications are documented where relevant

This document provides orientation, not implementation details.
