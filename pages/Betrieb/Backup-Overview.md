# Backup – Overview

Diese Übersicht beschreibt das **verbindliche Backup‑Konzept** des Homelabs.
Sie legt fest, **was gesichert wird**, **wohin**, **wie oft** und **mit welchem Ziel**.

Backups sind Teil der **Control‑Plane‑nahen Betriebsabsicherung**, nicht der Service‑Implementierung.

---

## Zweck

Der Backup‑Bereich beantwortet folgende Fragen:

* Welche Systeme sind backup‑pflichtig?
* Welche Backups sind **kritisch**, welche optional?
* Wo liegen die Backups?
* Wie wird ein Restore reproduzierbar durchgeführt?

Backups dienen **ausschließlich** der Wiederherstellung – nicht der Archivierung oder Versionierung.

---

## Grundprinzipien (verbindlich)

* **Kein Backup → kein System**
* Restore‑Fähigkeit ist wichtiger als Backup‑Frequenz
* Backups werden **regelmäßig getestet** (Restore‑Drills)
* Backup‑Ziele sind **physisch oder logisch getrennt**

---

## Backup‑Pflichtige Ebenen

### 1. Virtualisierungsebene (kritisch)

* **Proxmox VMs**
* Fokus: vollständige VM‑Backups

Diese Ebene ermöglicht:

* schnellen Komplett‑Restore
* Rückkehr zu definiertem Zustand

---

### 2. Service‑Ebene (sekundär)

* Docker‑Volumes
* Konfigurationsverzeichnisse

Diese Backups sind **ergänzend**, nicht führend.

---

### 3. Datenebene (extern)

* Medien
* Dokumente
* Benutzerdateien

Diese liegen **außerhalb** der docker‑VM (z. B. QNAP) und folgen eigenen Backup‑Strategien.

---

## Aktive Backup‑Strategie

### Proxmox

* Methode: `vzdump`
* Ziel: externes Storage (QNAP)
* Modus: Snapshot / Stop (je nach VM)

**Retention (empfohlen):**

* `keep-last`: 3
* `keep-daily`: 7
* `keep-weekly`: 4

---

### Docker‑VM (VM 200)

* Backup erfolgt **auf VM‑Ebene**, nicht containerweise
* Docker‑Volumes sind Teil des VM‑Backups

**Begründung:**

* reduziert Komplexität
* Restore ist schneller und robuster

---

## Restore‑Prinzip

* Restore erfolgt **immer vollständig**
* Keine Teil‑Restores einzelner Container
* Keine Optimierungen während des Restores

Für die docker‑VM existieren:

* **Notfall‑Restore‑Checkliste**
* **Restore‑Drill‑Szenario**

Diese Dokumente sind verbindlich.

---

## Abgrenzung

* **Git** ersetzt kein Backup
* **Snapshots** ersetzen kein Backup
* **Cloud‑Sync** ersetzt kein Restore‑Szenario

---

## Dokumentationspflicht

Nach jedem Restore‑Drill:

* Erkenntnisse dokumentieren
* Doku anpassen
* Zeiten erfassen

Backups ohne Doku gelten als **nicht belastbar**.

---

## Status

* Backup‑Konzept: definiert
* Restore‑Pfad: getestet
* Verbindlichkeit: hoch

---

> **Ein Backup, das nie zurückgespielt wurde, existiert nur theoretisch.**
