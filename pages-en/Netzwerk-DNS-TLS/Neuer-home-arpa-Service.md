# Adding a New `home.arpa` Service

This document describes the procedure for adding a new service under the internal `home.arpa` domain.

It ensures consistent DNS, TLS, and Reverse Proxy integration.

---

## Purpose

Adding a new service under `home.arpa` must:

* follow established naming conventions
* integrate with DNS and TLS
* align with the service and security model

This avoids ad-hoc or inconsistent service exposure.

---

## Prerequisites

Before adding a new service:

* the service purpose must be defined
* the hosting system must be documented in NetBox
* required ports and protocols must be known

Services are not exposed without prior documentation.

---

## DNS Configuration

* Create a DNS entry under `home.arpa`
* Point the record to the Reverse Proxy
* Avoid direct backend exposure

DNS reflects the logical service, not the physical host.

---

## TLS Configuration

* Issue or reuse a valid internal certificate
* Configure TLS termination at the Reverse Proxy
* Verify certificate trust on client systems

TLS is mandatory for new services.

---

## Reverse Proxy Configuration

* Create a new routing rule
* Define backend target and port
* Enable required proxy features (e.g. WebSockets)

Reverse Proxy configuration must be documented.

---

## Verification

* Verify DNS resolution
* Validate TLS certificate and trust
* Confirm service availability

The service is not considered operational until verification succeeds.

---

## Documentation

* Register the service in NetBox
* Update service documentation
* Record any deviations

Documentation completeness is part of service acceptance.
