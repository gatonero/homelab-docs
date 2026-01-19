# NetBox – Working Model

This document describes the working model used for NetBox in the homelab.

It defines how NetBox is maintained, updated, and integrated into daily operations.

---

## Principles

The NetBox working model follows these principles:

* NetBox reflects the **current target state**
* Changes are documented intentionally and explicitly
* Accuracy is more important than completeness

NetBox is treated as operational infrastructure, not as a passive inventory.

---

## Update Workflow

* Planned changes are reflected in NetBox before implementation
* Ad-hoc changes are documented immediately afterwards
* Temporary deviations are explicitly marked

Outdated information is considered an operational risk.

---

## Responsibility

* The homelab operator is responsible for NetBox accuracy
* There is a single authoritative maintainer
* External tools may reference NetBox data, but must not modify it

---

## Review and Maintenance

* NetBox data is reviewed regularly
* Inconsistencies are resolved promptly
* Deprecated elements are removed or archived

Maintenance is continuous, not event-driven.

---

## Integration with Documentation

* NetBox provides structured data
* Markdown documentation provides context and procedures
* Both must remain consistent

Neither NetBox nor documentation alone is sufficient.

---

## Benefits

This working model ensures:

* reliable and trustworthy infrastructure data
* reduced configuration drift
* improved troubleshooting
* long-term sustainability of the homelab
