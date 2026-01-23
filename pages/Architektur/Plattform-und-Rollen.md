---
title: "Architektur - Plattform und Rollen"
---

# Architektur - Plattform und Rollen

← Zurueck zur [Architektur-Overview](Overview-Architektur.md)

Konzeptionelle Beschreibung der Plattformebene und der darauf definierten
Rollen im Homelab.

## Zweck
Diese Seite beschreibt, wie physische und logische Plattformen im Homelab
eingeordnet werden und welche Rollen sie im Gesamtsystem einnehmen.

Ziel ist eine klare Trennung zwischen Hardware, Plattformdiensten und
darauf betriebenen Workloads.

## Plattformbegriff
Eine Plattform stellt Ressourcen und Grundfunktionen bereit, auf denen
Systeme und Services betrieben werden koennen.

Dazu gehoeren insbesondere:

- Rechenleistung
- Speicher
- Netzwerk
- Basisdienste fuer Betrieb und Verwaltung

Plattformen sind Mittel zum Zweck und nicht selbst der fachliche Fokus.

## Rollen von Plattformen
Plattformen uebernehmen klar definierte Rollen, zum Beispiel:

- Hosting von virtuellen Maschinen
- Bereitstellung von Container-Laufzeitumgebungen
- Trennung von produktiven und experimentellen Workloads
- Isolation unterschiedlicher Betriebszonen

Eine Plattform kann mehrere Rollen einnehmen, bleibt aber logisch klar
abgegrenzt.

## Abgrenzung zu Workloads
Plattformen unterscheiden sich bewusst von Workloads:

- Plattformen stellen Infrastruktur bereit
- Workloads nutzen diese Infrastruktur
- Plattformen aendern sich seltener als Workloads
- Stabilitaet der Plattform hat hohe Prioritaet

Diese Trennung vereinfacht Betrieb, Wartung und Fehleranalyse.

## Lebenszyklus
Plattformen unterliegen einem eigenen Lebenszyklus:

- Planung und Aufbau
- Stabiler Betrieb
- Geplante Aenderungen und Erweiterungen
- Rueckbau oder Ablösung

Aenderungen an Plattformen erfolgen kontrollierter als an einzelnen
Workloads.

## Abgrenzung
Diese Seite enthaelt keine:

- Hardware-Listen oder Spezifikationen
- Tool- oder Produktentscheidungen
- Konkreten Installationsschritte

Solche Details werden auf spezialisierten Detailseiten beschrieben.

## Weiterfuehrend

Die folgenden Seiten vertiefen die technische Umsetzung der Plattform-Ebene:

- [Virtualisierung](Virtualisierung.md)
- [Container und Workloads](Container-und-Workloads.md)
- [LAN-Konfiguration](LAN-Konfiguration.md)
