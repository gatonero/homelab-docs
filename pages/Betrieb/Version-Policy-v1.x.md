# Version-Policy – v1.x (Homelab)

**Gültig ab:** Release `v1.0-homelab`
**Ablageort (verbindlich):**

```
pages/Betrieb/Version-Policy-v1.x.md
```

Diese Policy definiert **verbindlich**, welche Änderungen innerhalb der
**v1.x‑Serie** erlaubt sind – und welche **einen neuen Major‑Release (v2.0)**
erfordern.

Ziel ist es, Stabilität, Nachvollziehbarkeit und Upgrade‑Disziplin
sicherzustellen.

---

## Zweck

Die v1.x‑Policy beantwortet:

* Was darf sich ändern, ohne einen neuen Major‑Release zu erzeugen?
* Welche Änderungen gelten als **architekturbrechend**?
* Wann ist ein neuer Release‑Tag zwingend erforderlich?

---

## Grundsatz (verbindlich)

> **v1.x bedeutet: Architektur stabil, Inhalte evolvieren.**

Alles, was die **Grundarchitektur**, **Control‑Plane‑Regeln** oder das
**Betriebsmodell** verändert, verlässt v1.x.

---

## Erlaubt innerhalb v1.x (Minor / Patch)

Folgende Änderungen sind **v1.x‑konform**:

### Dokumentation

* Ergänzungen und Präzisierungen bestehender Dokumente
* Korrekturen von Formulierungen
* Klarstellungen nach Restore‑ oder Betriebs‑Erkenntnissen
* Neue Services **innerhalb** bestehender Architekturregeln

### Services

* Hinzufügen neuer Services hinter bestehendem Reverse‑Proxy‑Modell
* Entfernen oder Ersetzen einzelner Services
* Änderungen an Service‑Details (Ports, Pfade, Storage)

### Betrieb

* Erweiterung von Checklisten
* Neue Restore‑Drills
* Backup‑Retention‑Anpassungen
* Git‑Workflow‑Verbesserungen

### NetBox

* Neue Objekte (VMs, Services, Rollen)
* Präzisere Kommentare
* Ergänzende Service‑Templates (wenn Muster bereits existieren)

➡️ **Kein neuer Release‑Tag nötig**, optional `v1.1`, `v1.2`, …

---

## Nicht erlaubt innerhalb v1.x (Major‑relevant)

Folgende Änderungen **brechen v1.x**:

### Architektur

* Aufhebung der Trennung von Control Plane und Service Plane
* Reverse Proxy vor Proxmox oder DNS
* TLS‑Terminierung außerhalb des Reverse Proxys
* Änderung der DNS‑Grundregel (Service vs. Plattform)

### Control Plane

* Änderung von Proxmox‑Identität (Hostname, Cluster, Zertifikate)
* Einführung zusätzlicher Control‑Plane‑Abhängigkeiten

### Betriebsmodell

* Wechsel des Backup‑Primärkonzepts
* Aufgabe der VM‑Restore‑Strategie zugunsten Container‑Restores
* Abschaffung oder Relativierung von Restore‑Drills

➡️ **Zwingend neuer Major‑Release (`v2.0`)**

---

## Versionsschema

```
v<MAJOR>.<MINOR>-homelab
```

Beispiele:

* `v1.0-homelab` – initiale konsolidierte Architektur
* `v1.1-homelab` – neue Services, erweiterte Doku
* `v2.0-homelab` – neue Architekturentscheidung

---

## Entscheidungsfrage (verbindlich)

Vor jeder größeren Änderung ist folgende Frage zu beantworten:

> **Würde ich einem zukünftigen Ich empfehlen, dafür neu zu taggen?**

* Ja → neuer Major‑Release
* Nein → v1.x fortführen

---

## Status

* Policy: definiert
* Gültigkeit: ab `v1.0-homelab`
* Verbindlichkeit: hoch

---

> **Versionen schützen nicht vor Änderungen – sie schützen vor Unklarheit.**
