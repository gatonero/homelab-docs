# Control Plane Policy – Nginx Proxy Manager

This document defines the control plane policy for Nginx Proxy Manager (NPM) within the homelab.

It describes how NPM is used as the central Reverse Proxy and TLS termination point.

---

## Purpose

The control plane policy exists to:

* enforce consistent traffic routing
* centralize TLS termination
* reduce configuration drift across services

NPM is treated as a critical infrastructure component.

---

## Role of Nginx Proxy Manager

Nginx Proxy Manager is responsible for:

* terminating TLS connections
* routing incoming traffic to backend services
* applying consistent access rules

Backend services are not exposed directly unless explicitly documented.

---

## Control Plane Principles

* All HTTP(S) ingress flows through NPM
* TLS certificates are managed centrally
* Routing rules are explicit and documented

Implicit or ad-hoc proxy configurations are avoided.

---

## Backend Integration

* Backends are addressed via internal IPs or networks
* Health and connectivity are verified
* Special requirements (e.g. WebSockets) are documented

Backend configuration must be reproducible.

---

## Change Management

* Proxy changes are planned and documented
* Impact on dependent services is evaluated
* Rollback options are considered

Unplanned proxy changes are treated as incidents.

---

## Security Considerations

* Administrative access to NPM is restricted
* TLS settings follow defined standards
* Logs are reviewed regularly

NPM is part of the security boundary of the homelab.

---

## Documentation

* All proxy rules are documented
* Deviations are explicitly justified
* NetBox reflects service exposure

NPM configuration and documentation must remain consistent.
