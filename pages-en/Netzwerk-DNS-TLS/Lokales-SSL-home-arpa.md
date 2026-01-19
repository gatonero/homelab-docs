# Local SSL for `home.arpa`

This document describes the use of local SSL certificates for the internal `home.arpa` domain.

It defines how TLS is implemented for internal services without relying on public certificate authorities.

---

## Purpose

Local SSL is used to:

* enable encrypted access to internal services
* avoid browser warnings
* maintain a consistent TLS model for all services

Internal services should behave like publicly exposed services from a TLS perspective.

---

## Domain Scope

* The `home.arpa` domain is used exclusively for internal services
* It is not resolvable via public DNS
* Certificates are issued only for internal use

This avoids conflicts with public domains and certificates.

---

## Certificate Strategy

* Certificates are generated locally
* A local Certificate Authority (CA) is used
* Trust is established by installing the CA on client systems

Public certificate authorities are not used for internal domains.

---

## Certificate Deployment

* Certificates are deployed to the Reverse Proxy
* TLS termination is handled centrally
* Backend services communicate over trusted internal networks

Certificate handling is kept out of individual services where possible.

---

## Operational Rules

* Certificate generation and renewal are documented
* Expiration dates are monitored
* Clients must trust the internal CA

Expired or untrusted certificates are treated as operational issues.

---

## Relationship to Other Documentation

* DNS documentation defines name resolution
* Reverse Proxy documentation defines TLS termination
* Service documentation defines access paths

All TLS-related documentation must remain consistent.
