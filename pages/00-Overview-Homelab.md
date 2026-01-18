# Homelab – Gesamtübersicht

Diese Seite ist der **zentrale Einstiegspunkt** für die gesamte Homelab-Dokumentation.

Sie dient als **Orientierung**, nicht als Detailreferenz, und verlinkt auf die thematischen Hauptbereiche.

---

## Zweck

Diese Übersicht beantwortet auf einen Blick:

* Welche Themenbereiche existieren?
* Wo finde ich Architektur‑Entscheidungen?
* Wo ist Betriebs‑ und Restore‑Wissen dokumentiert?
* Wo liegen Service‑spezifische Details?

Sie ersetzt **keine** Detaildokumentation.

---

## Struktur der Dokumentation

Die Dokumentation ist in **klar getrennte Themenbereiche** gegliedert:

### Architektur

Grundlegende, langfristig gültige Entscheidungen.

* Trennung von Control Plane und Service Plane
* Systemrollen und Verantwortlichkeiten
* Bewusste Ausschlüsse ("Was wird nicht getan?")

→ `pages/Architektur/`

---

### Netzwerk · DNS · TLS

Alles, was Namensauflösung, Erreichbarkeit und Sicherheit betrifft.

* DNS‑Konzept (`home.arpa`)
* Reverse Proxy
* TLS‑Terminierung
* Control‑Plane‑Policy

→ `pages/Netzwerk-DNS-TLS/`

---

### NetBox

Modellierung und Pflege der Infrastruktur‑Struktur.

* Wann ist NetBox führend?
* Templates vs. Custom Services
* Arbeits‑ und Pflegekonzept

→ `pages/NetBox/`

---

### Services

Service‑spezifische Dokumentation.

* Aufbau
* Besonderheiten
* Abweichungen von Standards

→ `pages/Services/`

---

### Betrieb

Alles für den **laufenden Betrieb** und den **Ernstfall**.

* Restore‑Checklisten
* Drill‑Szenarien
* Onboarding neuer Services

→ `pages/Betrieb/`

---

## Arbeitsprinzipien (Kurzfassung)

* Architektur wird **bewusst entschieden**
* Betrieb ist **reproduzierbar**
* Dokumentation ist **verbindlich**
* Git ist die **Source of Truth**
* Logseq ist **Editor und Graph**, nicht Quelle

---

## Einstiegsempfehlung

Neu oder länger nicht hier gewesen?

1. Architektur‑Gesamtüberblick lesen
2. Control‑Plane‑Policy prüfen
3. Aktuelle Betriebs‑Checklisten sichten

---

## Status

* Rolle: Einstiegspunkt
* Änderungsfrequenz: gering
* Verbindlichkeit: hoch

---

> **Diese Seite erklärt, wo Wissen liegt – nicht das Wissen selbst.**
