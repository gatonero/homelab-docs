---
title: "Architecture - Platform and Roles"
---

# Architecture - Platform and Roles

← Back to the [Architecture Overview](Overview-Architektur.md)

Conceptual description of the platform layer
and the roles defined on it within the homelab.

## Purpose
This page describes how physical and logical platforms
are classified within the homelab
and which roles they assume in the overall system.

The goal is a clear separation between hardware,
platform services, and workloads running on top of them.

## Platform Concept
A platform provides resources and basic functions
on which systems and services can be operated.

This includes, in particular:

- Compute resources
- Storage
- Network
- Base services for operation and management

Platforms are a means to an end,
not the primary functional focus.

## Roles of Platforms
Platforms assume clearly defined roles, for example:

- Hosting of virtual machines
- Provision of container runtime environments
- Separation of productive and experimental workloads
- Isolation of different operational zones

A platform can assume multiple roles
while remaining logically well separated.

## Separation from Workloads
Platforms deliberately differ from workloads:

- Platforms provide infrastructure
- Workloads consume this infrastructure
- Platforms change less frequently than workloads
- Platform stability has high priority

This separation simplifies operations,
maintenance, and fault analysis.

## Lifecycle
Platforms follow their own lifecycle:

- Planning and setup
- Stable operation
- Planned changes and extensions
- Decommissioning or replacement

Changes to platforms are more controlled
than changes to individual workloads.

## Scope
This page does not contain:

- hardware lists or specifications
- tool or product decisions
- concrete installation steps

Such details are described on specialized detail pages.

## Further Reading

The following pages deepen the technical implementation
of the platform layer:

- [Virtualization](Virtualisierung.md)
- [Containers and Workloads](Container-und-Workloads.md)
- [LAN Configuration](LAN-Konfiguration.md)
