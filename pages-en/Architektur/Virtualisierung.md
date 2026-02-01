---
title: "Architecture - Virtualization"
---

# Architecture - Virtualization

← Back to the [Architecture Overview](Overview-Architektur.md)

Conceptual description of virtualization
as the central abstraction
between physical platform and operated systems.

## Purpose
This page describes the role of virtualization
within the homelab
and classifies it as a fundamental abstraction layer.

The goal is to decouple physical resources
from logical systems
and enable flexible, controllable operation.

## Role of Virtualization
Virtualization fulfills several central tasks:

- Abstraction of hardware
- Isolation of systems
- Flexible allocation of resources
- Simplification of backup, restore, and migration

It forms the basis
for operating many services and platforms.

## Virtual Systems
Virtual systems are treated as independent units:

- Clear responsibility per system
- Defined purpose and lifecycle
- Own configuration and documentation

Virtual machines represent stable,
long-lived system roles.

## Separation from Containers
Virtualization and containerization
are deliberately distinguished:

- Virtual machines encapsulate complete operating systems
- Containers share a common kernel
- Virtualization is heavier but more robust
- Containers are lighter and faster to change

Both concepts complement each other
and are combined deliberately.

## Operational Aspects
Special operational aspects apply
to virtualized systems:

- Resource planning and limitation
- Clear naming and role models
- Controlled changes to systems

## Further Reading

Additional pages address adjacent aspects
of the virtualization strategy:

* [`Virtualization and Containers`](/pages/Architektur/Virtualisierung-und-Container.md)
* [`Containers and Workloads`](/pages/Architektur/Container-und-Workloads.md)
* [`Platform and Roles`](/pages/Architektur/Plattform-und-Rollen.md)
