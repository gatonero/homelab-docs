---
title: "Paperless-ngx Service"
---

# Paperless-ngx Service

Paperless-ngx provides document ingestion, processing, indexing, and retrieval within the Homelab.

It is an application service with persistent data and defined backup requirements.

---

## Purpose

The service exists to:

- Digitize incoming documents
- Classify and index content
- Provide searchable document storage
- Reduce reliance on physical archives

Data integrity is operationally critical.

---

## Scope

Paperless-ngx covers:

- Document ingestion workflows
- Metadata extraction and indexing
- Long-term document storage
- User access to archived documents

It is not used as a general file storage system.

---

## Dependencies

The Paperless-ngx service depends on:

- Persistent storage
- Database and message components
- OCR and processing backends
- Reverse proxy for access

Loss of dependencies impacts data availability.

---

## Operational Considerations

- Backups are mandatory and verified
- Storage growth is monitored
- Updates are performed cautiously
- Restore procedures are defined

Unrecoverable document loss is unacceptable.

