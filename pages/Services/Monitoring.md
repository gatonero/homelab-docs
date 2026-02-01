---
title: "Monitoring Service"
---

# Monitoring Service

The monitoring service provides visibility into the operational state of infrastructure and services.

It supports early detection, alerting, and operational confidence.

---

## Purpose

The monitoring service exists to:

- Detect failures and degradations
- Surface actionable alerts
- Provide operational signals
- Support unattended operation

Monitoring is treated as a core service.

---

## Scope

The monitoring service covers:

- Infrastructure components
- Services and applications
- Backup and automation outcomes

Monitoring follows a push-based model.

---

## Dependencies

The monitoring service depends on:

- Network reachability
- Correct client-side configuration
- Reliable notification channels

Other services depend on monitoring for visibility.

---

## Operational Considerations

- Alerts are actionable and rare
- Missing signals are treated as failures
- Monitoring itself is monitored

Unobserved systems are considered unsafe.

