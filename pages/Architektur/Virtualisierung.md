---
title: "Architektur - Virtualisierung"
---

# Architektur - Virtualisierung

← Zurueck zur [Architektur-Overview](Overview-Architektur.md)

Konzeptionelle Beschreibung der Virtualisierung als zentrale Abstraktion
zwischen physischer Plattform und betriebenen Systemen.

## Zweck
Diese Seite beschreibt die Rolle der Virtualisierung im Homelab und
ordnet sie als grundlegende Abstraktionsschicht ein.

Ziel ist es, physische Ressourcen von logischen Systemen zu entkoppeln
und einen flexiblen, kontrollierbaren Betrieb zu ermoeglichen.

## Rolle der Virtualisierung
Virtualisierung erfuellt mehrere zentrale Aufgaben:

- Abstraktion von Hardware
- Isolation von Systemen
- Flexible Zuweisung von Ressourcen
- Vereinfachung von Backup, Restore und Migration

Sie bildet die Basis fuer den Betrieb vieler Services und Plattformen.

## Virtuelle Systeme
Virtuelle Systeme werden als eigenstaendige Einheiten betrachtet:

- Klare Verantwortung pro System
- Definierter Zweck und Lebenszyklus
- Eigene Konfiguration und Dokumentation

Virtuelle Maschinen repraesentieren stabile, langlebige Systemrollen.

## Abgrenzung zu Containern
Virtualisierung und Containerisierung werden bewusst unterschieden:

- Virtuelle Maschinen kapseln komplette Betriebssysteme
- Container teilen sich einen gemeinsamen Kernel
- Virtualisierung ist schwergewichtiger, aber robuster
- Container sind leichter und schneller veraenderbar

Beide Konzepte ergaenzen sich und werden gezielt kombiniert.

## Betriebsaspekte
Fuer virtualisierte Systeme gelten besondere Betriebsaspekte:

- Ressourcenplanung und -begrenzung
- Klare Namens- und Rollenmodelle
- Kontrollierte Aenderungen an Sys
