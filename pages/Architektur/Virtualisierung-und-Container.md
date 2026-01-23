---
title: "Architektur - Virtualisierung und Container"
---

# Architektur - Virtualisierung und Container

← Zurueck zur [Architektur-Overview](Overview-Architektur.md)

Beschreibung der Rolle von Virtualisierung und Containerisierung innerhalb
der Gesamtarchitektur des Homelabs.

## Zweck
Diese Seite beschreibt, wie Virtualisierung und Containerisierung genutzt
werden, um Workloads zu trennen, Systeme zu strukturieren und den Betrieb
zu vereinfachen.

Der Fokus liegt auf der konzeptionellen Einordnung dieser Technologien
innerhalb der Architektur, nicht auf konkreten Implementierungsdetails.

## Rolle der Virtualisierung
Virtualisierung bildet die grundlegende Plattform des Homelabs:

- Trennung unterschiedlicher Systemrollen
- Isolierung von Workloads
- Flexible Ressourcenzuweisung
- Vereinfachte Wiederherstellung und Migration

Virtuelle Maschinen dienen als stabile, klar abgegrenzte Einheiten fuer
Systeme mit eigenstaendiger Verantwortung.

## Rolle der Containerisierung
Containerisierung wird fuer leichtgewichtige, klar umrissene Dienste
eingesetzt:

- Schnelle Bereitstellung und Aktualisierung von Services
- Klare Abhaengigkeiten und reproduzierbare Setups
- Trennung von Anwendung und Plattform

Container laufen in der Regel innerhalb virtualisierter Umgebungen und
ergaenzen diese, statt sie zu ersetzen.

## Abgrenzung der Einsatzbereiche
Virtualisierung und Containerisierung haben klar getrennte Einsatzgebiete:

- Virtualisierung: Plattformen, Infrastruktur, langlebige Systeme
- Container: Anwendungen, Services, kurzlebige oder skalierbare Komponenten

Diese Trennung verhindert unnoetige Komplexitaet und erleichtert Betrieb
und Fehlersuche.

## Betriebsrelevante Aspekte
Bei der Nutzung beider Technologien werden insbesondere beruecksichtigt:

- Backup- und Restore-Faehigkeit
- Monitoring und Logging
- Dokumentation und Nachvollziehbarkeit
- Klare Verantwortlichkeiten pro Systemebene

## Abgrenzung
Diese Seite enthaelt keine:

- Tool- oder Produktvergleiche
- Konkreten Installationsanleitungen
- Plattform-spezifischen Konfigurationen

Solche Details werden auf nachgelagerten Detailseiten behandelt.

## Weiterfuehrend

Weitere Seiten beleuchten angrenzende Aspekte der Virtualisierungsstrategie:

- [Virtualisierung und Container](Virtualisierung-und-Container.md)
- [Container und Workloads](Container-und-Workloads.md)
- [Plattform und Rollen](Plattform-und-Rollen.md)
