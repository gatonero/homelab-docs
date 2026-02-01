---
title: "Ingress"
---

# Central Entry Point for External and Internal HTTP(S) Access

← Back to the [`Architecture Overview`](/pages/Architektur/Overview-Architektur.md)

External access to web services operated in the homelab
is handled exclusively via a **dedicated ingress**.

This ingress represents a deliberately limited, controlled,
and traceable entry point.

The state described here represents a **verified reference state**
after full hardening and practical access testing.

---

## Architecture

### Role of the Ingress

The ingress serves as the central component for:

- the sole entry point for HTTP(S) traffic
- separation layer between external access and internal services
- TLS termination and access control

The ingress contains **no application logic**
and **no persistent storage**.

The technical implementation of the reverse proxy
as part of the ingress is described in detail at:  
[`Network – Reverse Proxy and Access Paths`](/pages/Netzwerk-DNS-TLS/Reverse-Proxy-und-Zugriffspfade.md)

---

### Network Principles

The ingress follows clear network guidelines:

- Only the ports required for HTTP(S) are externally reachable
- Administrative access is **not publicly exposed**
- Management access occurs exclusively via controlled internal paths
- Unused protocols and address families are consistently excluded

These principles reduce the attack surface and simplify analysis and operation.

---

## Security Principles

### Firewall Fundamentals

The ingress is secured according to the **fail-closed principle**:

- incoming traffic is blocked by default
- explicitly allowed connections are limited to the necessary minimum
- established connections are forwarded correctly

Firewall rules are fully reproducible and part of automated system configuration.

---

### TLS and HTTP Security

#### TLS

- modern, distribution-compliant TLS configuration
- deliberate avoidance of application-specific special configurations
- centralized maintenance of TLS parameters

#### HTTP Security Headers

Security headers are applied consistently
without forcing conflicts between ingress and applications.

Consciously implemented measures include, among others:

- protection against MIME type sniffing
- controlled referrer behavior
- framing defined by the respective application

Enforcement of additional headers at the ingress level
only occurs where no conflicts arise.

---

## Verified Access Tests

The reference state was validated through targeted tests, including:

- correct HTTPS reachability
- deterministic redirection from HTTP to HTTPS
- controlled handling of undefined paths
- blocking of insecure HTTP methods
- no unintended leakage of internal information

These tests confirm the effectiveness of the architectural
and security decisions taken.

---

## Conscious Acceptances

Certain aspects are deliberately accepted
to ensure stability and maintainability, including:

- no enforced global HSTS policy at ingress level
- application-side responsibility for specific headers
- controlled visibility of technical information for rejected requests

These decisions are documented, evaluated,
and can be reassessed if requirements change.

---

## Reference Status

The described state is:

- technically verified
- security-reviewed
- methodically documented
- frozen as a stable reference state

Changes are made exclusively after renewed evaluation
and documented decision-making.
