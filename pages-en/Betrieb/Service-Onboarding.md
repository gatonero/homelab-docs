# Service Onboarding

This document describes the process for onboarding new services into the homelab.

The goal is to ensure that new services are introduced in a controlled, documented, and reproducible manner.

---

## Purpose

Service onboarding ensures that:

* new services are integrated consistently
* operational requirements are met
* documentation remains complete and accurate

No service is considered production-ready without proper onboarding.

---

## Scope

The onboarding process applies to:

* infrastructure services
* platform services
* application services

Temporary test services are excluded unless explicitly documented.

---

## Onboarding Steps

### 1. Planning

* Define the purpose of the service
* Identify dependencies and integrations
* Evaluate backup and restore requirements

---

### 2. Documentation

* Create or update service documentation
* Register the service in NetBox
* Define DNS names, ports, and protocols

Documentation must exist before deployment.

---

### 3. Deployment

* Deploy the service according to documented procedures
* Apply naming and configuration standards
* Integrate the service with DNS and the Reverse Proxy

---

### 4. Verification

* Verify service availability
* Validate access via DNS and TLS
* Confirm backup coverage where applicable

---

### 5. Acceptance

* Confirm that documentation is complete
* Confirm that NetBox reflects the target state
* Declare the service operational

---

## Responsibilities

* The homelab operator is responsible for onboarding
* Deviations must be documented explicitly

Skipping onboarding steps is considered an operational risk.

---

## Relationship to Other Documents

* Architecture documents define constraints
* Service model defines structure
* Operational procedures define execution

Service onboarding ties these elements together.
