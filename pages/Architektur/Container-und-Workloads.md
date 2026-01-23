---
title: "Architektur - Container und Workloads"
---

# Architektur - Container und Workloads

← Zurueck zur [Architektur-Overview](Overview-Architektur.md)

Konzeptionelle Beschreibung von Containern und Workloads als flexible
Ausfuehrungseinheiten auf der Plattform.

## Zweck
Diese Seite beschreibt, wie Container und andere Workloads im Homelab
eingeordnet werden und welche Rolle sie im Gesamtsystem spielen.

Ziel ist es, kurzlebige, leicht aenderbare Komponenten klar von stabilen
Plattform- und Systemebenen zu trennen.

## Workload-Begriff
Ein Workload ist eine ausfuehrbare Einheit mit einem klaren Zweck:

- Bereitstellung eines Services
- Verarbeitung von Daten
- Unterstuetzung betrieblicher Aufgaben

Workloads sind funktional fokussiert und austauschbar.

## Container als Workloads
Container sind eine zentrale Form von Workloads:

- Geringe Start- und Aenderungskosten
- Klare Abgrenzung von Abhaengigkeiten
- Gute Automatisierbarkeit
- Enge Kopplung an die darunterliegende Plattform

Container eignen sich besonders fuer Anwendungs- und Hilfsdienste.

## Abgrenzung zu virtuellen Systemen
Container unterscheiden sich bewusst von virtuellen Systemen:

- Keine eigenen Betriebssysteme
- Kürzere Lebenszyklen
- Hoehere Aenderungsfrequenz
- Geringere Isolationstiefe

Virtuelle Systeme bleiben die stabilere Basis fuer langlebige Rollen.

## Betriebsprinzipien
Fuer Container und Workloads gelten folgende Prinzipien:

- Reproduzierbarkeit statt manueller Pflege
- Klare Trennung von Code, Konfiguration und Daten
- Schnelle Wiederherstellbarkei

## Weiterfuehrend

Weitere Seiten zu strukturellen und organisatorischen Aspekten von Workloads:

- [Virtualisierung](Virtualisierung.md)
- [Plattform und Rollen](Plattform-und-Rollen.md)
- [Integrationsprinzipien](Integrationsprinzipien.md)
