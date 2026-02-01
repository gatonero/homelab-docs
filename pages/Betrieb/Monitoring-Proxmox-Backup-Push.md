---
title: "Proxmox Backup Monitoring (Push-Based)"
---

# Proxmox Backup Monitoring (Push-Based)

Proxmox backup monitoring follows the push-based monitoring model used throughout this Homelab.

The backup system actively reports its execution results instead of being polled.

---

## Rationale

Backups are critical but infrequent operations.

Polling-based monitoring risks missing failures between intervals or assuming success without confirmation.

Push-based reporting provides explicit success or failure signals.

---

## Monitored Events

The following events are monitored:

- Backup completed successfully
- Backup failed
- Backup skipped or aborted
- Backup duration outside expected range

Each event generates a clear operational signal.

---

## Failure Handling

Any failed or missing backup signal is treated as an incident.

There is no grace period or silent retry logic without visibility.

---

## Operational Outcome

A backup that is not explicitly reported as successful is considered unreliable.

Unverified backups are operationally equivalent to missing backups.

