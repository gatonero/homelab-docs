# Betrieb – Overview

Diese Übersicht bündelt alle Dokumente zum **laufenden Betrieb**, zur **Wiederherstellung** und zur **Absicherung** des Homelabs.

Sie ist der Einstiegspunkt für alles, was im Alltag, im Fehlerfall oder bei Systemwechseln relevant ist.

---

## Zweck

Der Bereich **Betrieb** beantwortet insbesondere:

* Wie wird das System sicher betrieben?
* Wie wird dokumentations- und versionssicher gearbeitet?
* Wie läuft ein Restore strukturiert ab?
* Wie wird der Ernstfall geübt?

---

## Enthaltene Dokumente

### Versionskontrolle & Sicherung

* **GitHub-Setup & Workflow**
  Dokumentiert die verbindliche Nutzung von Git und GitHub zur externen Sicherung und Versionierung.

  → `pages/Betrieb/GitHub-Setup.md`

---

### Notfall & Wiederherstellung

* **Notfallrestore – Docker-VM**
  Checkliste für den reproduzierbaren Restore der zentralen Service-VM.

  → `pages/Betrieb/Notfallrestore-Docker-VM.md`

* **Restore-Drill – Docker-VM**
  Übungsszenario zur Überprüfung der Wiederherstellungsfähigkeit.

  → `pages/Betrieb/Restore-Drill-Docker-VM.md`

---

### Service-Betrieb

* **Service-Onboarding**
  Vorgehen für das strukturierte Hinzufügen neuer Services.

  → `pages/Betrieb/Service-Onboarding.md`

---

## Arbeitsprinzipien (verbindlich)

* Betrieb folgt dokumentierten Prozessen
* Wiederherstellung wird **geübt**, nicht angenommen
* Versionskontrolle ist Teil des Betriebs
* Dokumentation wird **nachgezogen**, nicht improvisiert

---

## Status

* Rolle: Operativer Einstiegspunkt
* Änderungsfrequenz: niedrig bis mittel
* Verbindlichkeit: hoch

---

> **Was nicht dokumentiert ist, gilt im Betrieb als nicht vorhanden.**
