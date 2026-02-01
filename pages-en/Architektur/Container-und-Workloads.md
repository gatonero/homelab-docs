---
title: "Architecture - Containers and Workloads"
---

# Architecture - Containers and Workloads

← Back to the [Architecture Overview](Overview-Architektur.md)

Conceptual description of containers and workloads as flexible
execution units on the platform.

## Purpose
This page describes how containers and other workloads are
classified within the homelab and which role they play
in the overall system.

The goal is to clearly separate short-lived, easily changeable
components from stable platform and system layers.

## Workload Concept
A workload is an executable unit with a clear purpose:

- Provision of a service
- Processing of data
- Support of operational tasks

Workloads are functionally focused and replaceable.

## Containers as Workloads
Containers are a central form of workloads:

- Low startup and change costs
- Clear separation of dependencies
- Good automation potential
- Tight coupling to the underlying platform

Containers are particularly suitable for application and helper services.

## Separation from Virtual Systems
Containers deliberately differ from virtual systems:

- No own operating systems
- Shorter lifecycles
- Higher change frequency
- Lower degree of isolation

Virtual systems remain the more stable base for long-lived roles.

## Operational Principles
The following principles apply to containers and workloads:

- Reproducibility instead of manual maintenance
- Clear separation of code, configuration, and data
- Fast recoverability

## Further Reading

Additional pages on structural and organizational aspects of workloads:

* [`Virtualization`](Virtualisierung.md)
* [`Platform and Roles`](Plattform-und-Rollen.md)
* [`Integration Principles`](Integrationsprinzipien.md)
