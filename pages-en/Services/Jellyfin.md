# Jellyfin

This document describes the Jellyfin media server service within the homelab.

Jellyfin is used to provide media streaming for video and audio content.

---

## Purpose

Jellyfin provides:

* centralized media library management
* streaming of video and audio content
* access via web interface and client applications

It is a user-facing application service.

---

## Deployment Model

* Jellyfin is operated as a containerized service
* Persistent media data is stored outside the container
* Configuration and metadata are persisted

The container itself is treated as replaceable.

---

## Networking and Access

* Jellyfin is accessed via a defined DNS name
* Access is routed through the Reverse Proxy
* TLS termination is handled centrally

Direct access to backend ports is avoided unless explicitly documented.

---

## Storage

* Media files are stored on network storage
* Access permissions are read-only where possible
* Mounts are documented explicitly

Storage configuration is critical for data integrity.

---

## Backup Considerations

* Media files are backed up according to storage policy
* Configuration and metadata are included in backups

Backup scope and retention are documented separately.

---

## Operational Notes

* Updates are performed in a controlled manner
* Compatibility is verified before upgrades
* Logs are reviewed in case of issues

Jellyfin is treated as a long-running service.
