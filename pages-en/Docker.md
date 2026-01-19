# Docker

This document describes how Docker is used within the homelab.

Docker is primarily used to run application services in a controlled, reproducible manner.

---

## Purpose

Docker is used to:

* deploy services in a standardized way
* reduce configuration drift
* simplify updates and rollbacks

Containers are treated as part of the production infrastructure.

---

## Deployment Model

* Services are deployed using Docker Compose
* Each service has a clearly defined scope
* Persistent data is stored outside containers

Container images are considered replaceable; data is not.

---

## Networking

* Containers are integrated into the internal network
* Service exposure is documented via DNS and the Reverse Proxy
* Direct container exposure is avoided unless explicitly documented

Networking behavior must be predictable and transparent.

---

## Configuration

* Configuration is managed via versioned files
* Secrets are not stored in repositories
* Environment variables are documented where relevant

Configuration changes are tracked and reproducible.

---

## Lifecycle Management

* Containers are updated in a controlled manner
* Breaking changes are evaluated before deployment
* Deprecated containers are removed cleanly

Ad-hoc container changes are avoided.

---

## Relationship to Other Systems

* Docker services are documented in NetBox
* DNS and TLS configuration must remain consistent
* Backup coverage is explicitly defined

Docker is integrated into the overall homelab service model.
