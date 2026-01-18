page-name:: NetBox-Overview
# NetBox – Overview

## Zweck

Dieses Dokument ist der **Einstiegspunkt** für die Nutzung von NetBox im HomeLab.

Es beschreibt **die Rolle von NetBox im Gesamtsystem**, die Grenzen seiner Nutzung und das verbindliche Arbeitsmodell. NetBox dient der **Modellierung von Struktur und Architektur**, nicht der Abbildung jedes technischen Details.

---

## Geltungsbereich

Der NetBox-Ordner regelt:

* wie Infrastruktur und Services modelliert werden
* wann NetBox führend ist und wann bewusst nicht
* die Entscheidung zwischen **Service Templates** und **Custom Services**

Die hier beschriebenen Regeln gelten für **alle Einträge in NetBox**.

---

## Rolle von NetBox im HomeLab

NetBox ist die **Source of Truth für Struktur**:

* welche Systeme existieren
* welche Rollen sie haben
* wie Services logisch zueinander stehen
* welche Abhängigkeiten architektonisch relevant sind

NetBox ist **nicht**:

* ein Orchestrator
* ein Konfigurationsmanagement
* ein Logbuch
* ein Monitoring-System

---

## Verbindliches Arbeitsmodell

Die Nutzung von NetBox folgt einem festen Ablauf:

1. **Denken & Planen** – Struktur in NetBox modellieren
2. **Bauen** – Umsetzung in der Realität (Proxmox, Docker, Netzwerk)
3. **Abgleichen** – NetBox ergänzen, wo Struktur betroffen ist
4. **Dokumentieren** – Architektur nur bei Regeländerungen anpassen

Diese Reihenfolge ist verbindlich.

---

## Service-Modellierung

NetBox kennt zwei Arten von Services:

* **Service Templates**

  * für wiederkehrende technische Muster
  * stabil in Port, Protokoll und Rolle

* **Custom Services**

  * für einmalige, temporäre oder experimentelle Dienste

Die Entscheidung folgt klaren Kriterien und ist nicht optional.

---

## Dokumente in diesem Ordner

* **NetBox-Arbeitsmodell.md**
  Ausführliche Beschreibung der Pflege- und Entscheidungslogik.

---

## Änderungsregeln

* NetBox wird nicht bei jeder technischen Änderung angepasst
* Einträge werden nur geändert, wenn sich **Struktur oder Abhängigkeiten** ändern
* Notfälle werden **nicht** in NetBox gelöst, sondern danach reflektiert

NetBox bleibt bewusst ruhig und übersichtlich.

---

## Merksatz

> NetBox erklärt die Architektur – es betreibt sie nicht.

---

## Status

* gültig
* verbindlich
* architekturführend
