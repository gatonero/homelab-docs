# Paperless-ngx

This document describes the Paperless-ngx document management service within the homelab.

Paperless-ngx is used to manage, index, and search documents.

---

## Purpose

Paperless-ngx provides:

* centralized document storage
* automated document ingestion
* full-text search and metadata management

It is a user-facing application service.

---

## Deployment Model

* Paperless-ngx is operated as a containerized service
* Supporting components (e.g. database, broker) run as containers
* Persistent data is stored outside containers

Containers are treated as replaceable; data is not.

---

## Networking and Access

* Access is provided via a defined DNS name
* Traffic is routed through the Reverse Proxy
* TLS termination is handled centrally

Direct exposure of backend services is avoided.

---

## Data Storage

* Documents and metadata are stored on persistent storage
* Backup coverage is explicitly defined
* Storage paths and mounts are documented

Data integrity is critical for this service.

---

## Backup Considerations

* All Paperless-ngx data is included in regular backups
* Restore procedures are tested periodically

Backup and restore are treated as mandatory operational requirements.

---

## Operational Notes

* Updates are performed in a controlled manner
* Schema changes are reviewed before upgrades
* Logs are monitored for ingestion and processing issues

Paperless-ngx is operated as a long-running production service.
