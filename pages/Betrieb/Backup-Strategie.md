---
title: "Backup Strategy"
---

# Backup Strategy

The backup strategy prioritizes reliability, clarity, and recoverability over storage efficiency.

---

## Strategy Principles

The strategy follows these principles:

- Backups are automated
- Backup results are monitored
- Failures are surfaced immediately
- Retention is defined explicitly
- Recovery paths are known in advance

---

## Backup Types

The following backup types are used:

- Full system backups for virtual machines
- Application-level backups for selected services
- Configuration-only backups where appropriate

Each backup type is chosen based on recovery requirements.

---

## Retention Policy

Retention policies are defined per backup class.

Short-term retention supports fast recovery.  
Long-term retention supports disaster recovery and auditing.

Retention without restore validation is not acceptable.

---

## Failure Handling

Any backup failure is treated as an incident.

Retries without visibility are avoided. Failures must be investigated and resolved explicitly.

