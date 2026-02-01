---
title: "Reverse Proxy Service"
---

# Reverse Proxy Service

The reverse proxy provides controlled access to services and acts as the primary ingress point for externally reachable components.

It enforces separation between internal services and external exposure.

---

## Purpose

The reverse proxy exists to:

- Terminate incoming connections
- Apply access and routing rules
- Provide a single controlled ingress point
- Reduce direct exposure of internal services

Direct external access to services is avoided.

---

## Scope

The reverse proxy handles:

- HTTP and HTTPS traffic
- Service routing based on host headers
- Access control where required

It does not perform application-level logic.

---

## Dependencies

The reverse proxy depends on:

- Network availability
- Correct DNS resolution
- Valid certificates where applicable

Downstream services depend on the reverse proxy for exposure.

---

## Operational Considerations

- Configuration changes are managed via automation
- Reloads are controlled and monitored
- Access patterns are observable

Ingress failures are treated as high-priority incidents.

