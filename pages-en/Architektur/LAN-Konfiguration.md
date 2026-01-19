# LAN Configuration

This document describes the LAN configuration of the homelab.

It defines addressing, segmentation, and basic network rules within the local network.

---

## Purpose

The LAN configuration is designed to:

* provide stable and predictable connectivity
* support clear separation of concerns
* simplify troubleshooting and maintenance

Network simplicity is preferred over unnecessary complexity.

---

## IP Addressing

* IP ranges are defined explicitly
* Address usage is documented
* Static assignments are preferred for infrastructure components

Dynamic addressing is limited to non-critical systems.

---

## Network Segmentation

* Infrastructure components are logically grouped
* Services are separated where appropriate
* Segmentation decisions are documented

Segmentation is used deliberately, not by default.

---

## Routing and Access

* Routing behavior is predictable and transparent
* Inter-segment access is controlled
* Exceptions are documented explicitly

Implicit routing paths are avoided.

---

## Documentation and Source of Truth

* Network configuration is documented in NetBox
* Markdown documentation provides context
* Deviations are treated as configuration drift

NetBox remains the authoritative source for network data.

---

## Operational Rules

* Network changes are planned and documented
* Impact is evaluated before implementation
* Rollback options are considered

LAN configuration changes are treated as infrastructure changes.
