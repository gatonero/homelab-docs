# NetBox – Overview

Diese Übersicht beschreibt die Rolle von **NetBox** im Homelab sowie die verbindlichen Regeln für dessen Nutzung.

NetBox ist **Modellierungs- und Referenzsystem**, nicht Betriebswerkzeug.

---

## Zweck

Der NetBox-Bereich beantwortet:

* Welche Systeme und Services existieren?
* Welche Rollen und Abhängigkeiten sind architektonisch relevant?
* Wann ist NetBox führend – und wann bewusst nicht?

NetBox beschreibt den **Soll-Zustand** der Infrastruktur.

---

## Rolle von NetBox im Homelab

NetBox ist die **Source of Truth für Struktur und Architektur**:

* Devices und Virtual Machines
* Rollen und Verantwortlichkeiten
* Application Services
* Abhängigkeiten zwischen Infrastruktur und Applikationen

NetBox ist **kein**:

* Orchestrator
* Konfigurations-Repository
* Logbuch
* Monitoring-System

---

## Enthaltene Dokumente

* **NetBox – Arbeitsmodell**
  Beschreibt Pflegekonzept, Änderungsarten und Entscheidungslogik.

  → `pages/NetBox/NetBox-Arbeitsmodell.md`

---

## Arbeitsprinzipien (verbindlich)

* Struktur wird **zuerst** in NetBox gedacht
* Technik wird **zuerst** in der Realität umgesetzt
* NetBox wird **danach** abgeglichen
* Nicht jede technische Änderung gehört in NetBox

---

## Typische Anwendungsfälle

### NetBox zuerst

* neue VM oder neues Device
* neuer Service
* neue Rolle oder Kategorie
* neue Abhängigkeiten

### Realität zuerst

* Konfigurationsänderungen
* Performance-Tuning
* Zertifikatserneuerung
* temporäre Anpassungen

---

## Abgrenzung zu anderen Bereichen

* **Architektur** definiert Grundregeln und Prinzipien
* **NetBox** modelliert konkrete Instanzen innerhalb dieser Regeln
* **Betrieb** beschreibt Wiederherstellung und Alltag
* **Services** dokumentieren Implementierungsdetails

---

## Status

* Rolle: Strukturelle Referenz
* Änderungsfrequenz: niedrig
* Verbindlichkeit: hoch

---

> **NetBox hilft beim Denken – nicht beim Tippen von Konfigurationen.**
