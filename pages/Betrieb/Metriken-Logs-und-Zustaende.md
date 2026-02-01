---
title: "Metrics, Logs, and States"
---

# Metrics, Logs, and States

Operational observability is built on three pillars: metrics, logs, and states.

Each serves a distinct purpose and must not be mixed indiscriminately.

---

## Metrics

Metrics represent quantitative measurements over time.

Examples include:

- Disk utilization
- Memory consumption
- Service uptime

Metrics are useful when clear thresholds exist that trigger operational decisions.

---

## Logs

Logs provide contextual, event-oriented information.

They are primarily used for:

- Root cause analysis
- Incident investigation
- Verification of expected behavior

Logs are not suitable for primary alerting.

---

## States

States represent binary or discrete conditions.

Examples include:

- Backup successful or failed
- Service running or stopped
- Host reachable or unreachable

States are preferred for alerting because they directly map to actions.

---

## Operational Usage

Metrics explain trends.  
Logs explain causes.  
States explain whether action is required.

Mixing these concepts leads to unclear signals and operational noise.

