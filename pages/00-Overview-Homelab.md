# Homelab – Gesamtübersicht

## Zweck

Dieses Dokument ist der **Einstiegspunkt** für alle architekturbezogenen Inhalte des HomeLabs.

Es beschreibt **keine technischen Schritte**, sondern legt die **architektonischen Leitplanken** fest, innerhalb derer Betrieb, Erweiterungen und Entscheidungen stattfinden.

Die Architektur-Dokumente beantworten nicht die Frage *wie* etwas gebaut wird, sondern *warum* es so gebaut ist.

---

## Geltungsbereich

Dieser Ordner beschreibt:

* die Gesamtarchitektur des HomeLabs
* grundlegende Strukturentscheidungen
* bewusste Abgrenzungen und Nicht-Ziele

Die hier beschriebenen Prinzipien sind **verbindlich** für:

* Netzwerk- und DNS-Design
* Service-Onboarding
* NetBox-Modellierung
* Betriebs- und Restore-Konzepte

---

## Inhaltliche Schwerpunkte

Die Architektur-Dokumentation fokussiert sich auf:

* Trennung von Control Plane und Service Plane
* Stabilität vor Komfort
* klare Verantwortlichkeiten von Komponenten
* Vermeidung unnötiger Kopplungen

Details zur konkreten Umsetzung (Docker, Compose, CLI-Befehle) gehören **nicht** in diesen Ordner.

---

## Dokumente in diesem Ordner

* **Architektur-Gesamt.md**
  Gesamtüberblick über das HomeLab, zentrale Entscheidungen und Merksätze.

* **Hardware.md**
  Überblick über eingesetzte Hardware und deren Rolle im Gesamtsystem.

* **LAN-Konfiguration.md**
  Beschreibung der logischen Netzstruktur und Segmentierung.

---

## Änderungsregeln

* Änderungen an Architektur-Dokumenten sind selten
* jede Änderung ist **bewusst** und begründet
* Architektur wird nur angepasst, wenn sich **Prinzipien** ändern

Reine Betriebs- oder Implementierungsdetails führen **nicht** zu Architekturänderungen.

---

## Merksatz

> Architektur ist das, was auch dann noch gilt, wenn alles andere kaputt ist.

---

## Status

* gültig
* verbindlich
* Grundlage für alle weiteren Dokumente
