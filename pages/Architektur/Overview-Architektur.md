page-name:: Architektur-Overview
# Architektur – Overview

## Zweck

Diese Übersicht dient als **Einstiegspunkt für alle architektonischen Dokumente** des Homelabs.

Sie beschreibt **keine Konfigurationen**, sondern:
- grundlegende Architekturentscheidungen
- verbindliche Leitprinzipien
- bewusste Abgrenzungen (Was wird getan – was nicht)

Die Architektur ist die **stabile Referenz**, an der sich Betrieb, Erweiterungen
und Notfallmaßnahmen orientieren.

---

## Inhalt dieses Bereichs

In diesem Ordner werden dokumentiert:

- Gesamtarchitektur (Control Plane vs. Service Plane)
- Systemrollen und Verantwortlichkeiten
- grundlegende Designentscheidungen
- langfristig gültige Prinzipien

Technische Schritt-für-Schritt-Anleitungen gehören **nicht** hierher.

---

## Abgrenzung

- ❌ keine Docker-Compose-Details
- ❌ keine Portlisten einzelner Services
- ❌ keine Betriebsanleitungen

Diese Informationen gehören in:
- `Services/`
- `Betrieb/`
- `Netzwerk-DNS-TLS/`

---

## Leitgedanke

> Architektur erklärt **Warum** – nicht **Wie**.

---

## Status

- Rolle: **architektonische Leitplanke**
- Änderungsfrequenz: **selten**
- Verbindlichkeit: **hoch**
