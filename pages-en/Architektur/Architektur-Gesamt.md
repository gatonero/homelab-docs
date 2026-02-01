---
title: "Architektur - Gesamtueberblick"
---

# Konzeptionelles Architekturmodell des Homelabs

← Zurueck zur [Architektur-Overview](Overview-Architektur.md)

---
## Zweck
Vermittelt das Architekturmodell und die zentralen Ziele – unabhaengig von konkreten Implementierungen.

---
## Architekturziele
- Stabiler, nachvollziehbarer Betrieb
- Kontrollierte Komplexitaet
- Wart- und Wiederherstellbarkeit
- Erweiterbarkeit ohne Strukturbrueche

---
## Systemebenen
- Physische Ebene (Hardware, Verkabelung)
- Plattform-Ebene (Virtualisierung, Container)
- Service-Ebene (Dienste, Anwendungen)
- Management-Ebene (Steuerung, Dokumentation, Betrieb)

---
## Abgrenzung
Keine Meta-Rueckkopplungen zu Betrieb oder Governance.
