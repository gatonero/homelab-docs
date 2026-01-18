page-name:: Betrieb-Overview
# Betrieb – Overview

## Zweck

Dieses Dokument ist der **Einstiegspunkt** für alle betrieblichen Themen des HomeLabs.

Es beschreibt, **wie das System im laufenden Betrieb stabil gehalten wird**, wie auf Störungen reagiert wird und welche Dokumente **unter Zeitdruck** relevant sind.

Der Fokus liegt auf **Wiederherstellbarkeit, Klarheit und Stressresistenz**.

---

## Geltungsbereich

Der Ordner *Betrieb* umfasst:

* Restore- und Wiederherstellungsszenarien
* Notfall- und Drill-Dokumente
* Onboarding-Prozesse mit Betriebsrelevanz

Er behandelt **nicht**:

* Architekturentscheidungen
* Detailkonfiguration einzelner Services
* experimentelle Änderungen

---

## Betriebliche Leitprinzipien

* Betrieb priorisiert **Stabilität vor Optimierung**
* Unter Stress zählt **Dokumentation**, nicht Erinnerung
* Restore ist ein **definierter Prozess**, keine Reparaturarbeit
* Änderungen am Betrieb folgen festen Checklisten

Improvisation ist kein Betriebsmodell.

---

## Kritische Betriebsszenarien

Der Betrieb fokussiert sich auf wenige, realistische Szenarien:

* Ausfall der Docker-VM
* Nicht erreichbare Services hinter dem Reverse Proxy
* DNS- oder TLS-bezogene Erreichbarkeitsprobleme

Für jedes dieser Szenarien existieren **konkrete, getestete Dokumente**.

---

## Dokumente in diesem Ordner

* **Notfallrestore-Docker-VM.md**
  Schritt-für-Schritt-Checkliste für den Restore der zentralen Service-VM.

* **Restore-Drill-Docker-VM.md**
  Übungsszenario zur regelmäßigen Überprüfung der Restore-Fähigkeit.

* **Service-Onboarding.md**
  Betriebsrelevante Aspekte beim Hinzufügen neuer Services.

---

## Nutzung im Ernstfall

* Dokumente in diesem Ordner sind so geschrieben, dass sie:

  * ohne Kontextwissen verständlich sind
  * klare Reihenfolgen vorgeben
  * Entscheidungen abnehmen

Im Notfall wird **nicht interpretiert**, sondern abgearbeitet.

---

## Änderungsregeln

* Betriebsdokumente dürfen angepasst werden, wenn:

  * ein Drill Lücken aufdeckt
  * ein realer Vorfall neue Erkenntnisse liefert

Jede Anpassung dient der **Reduktion von Unsicherheit**.

---

## Merksatz

> Betrieb bedeutet, vorbereitet zu sein – nicht, schnell zu sein.

---

## Status

* gültig
* verbindlich
* notfallrelevant
