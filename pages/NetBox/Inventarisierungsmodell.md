---
title: "NetBox - Inventarisierungsmodell"
---

# NetBox - Inventarisierungsmodell

← Zurueck zur [NetBox-Overview](Overview-NetBox.md)

Konzeptionelle Beschreibung des Inventarisierungsmodells im Homelab
und der Rolle von NetBox als zentrales Inventarsystem.

## Zweck
Diese Seite beschreibt, wie Objekte im Homelab inventarisiert werden und
nach welchen Prinzipien sie in NetBox abgebildet sind.

Ziel ist eine konsistente, nachvollziehbare und erweiterbare Abbildung
der realen Infrastruktur.

## Grundidee der Inventarisierung
Inventarisierung bedeutet mehr als eine Liste von Geraeten:

- Abbildung realer Objekte und ihrer Eigenschaften
- Dokumentation von Rollen und Zweck
- Grundlage fuer Abhaengigkeiten und Beziehungen
- Referenz fuer Betrieb und Dokumentation

Inventarisierung schafft Ordnung und Transparenz.

## Objektklassen
Das Inventarisierungsmodell unterscheidet mehrere Objektklassen:

- Physische Geraete (Hosts, Netzwerkkomponenten)
- Virtuelle Systeme (VMs)
- Dienste und Plattformkomponenten
- Logische Strukturen (Netze, Standorte, Rollen)

Jede Objektklasse hat einen klaren Zweck und definierte Attribute.

## Granularitaet
Die Granularitaet der Inventarisierung ist bewusst gewaehlt:

- So detailliert wie noetig
- So einfach wie moeglich
- Keine Doppelpflege von Informationen

Nicht jedes Detail wird inventarisiert, sondern nur relevante Aspekte.

## Stabilitaet und Aenderungen
Inventardaten sind vergleichsweise stabil:

- Aenderungen erfolgen kontrolliert
- Temporäre Zustaende werden vermieden
- Historie ergibt sich aus Versionierung der Dokumentation

Inventar bildet den Soll-Zustand ab, nicht jeden Momentzustand.

## Abgrenzung
Diese Seite enthaelt keine:

- Feldlisten oder Attributdefinitionen
- Tool-spezifischen Eingabemasken
- Bedienungsanleitungen

Solche Inhalte werden auf spezialisierten Detailseiten beschrieben.

## Weiterfuehrend
Weitere Seiten vertiefen unter anderem:

- Rollen- und Beziehungsmodelle
- NetBox als Source of Truth
- Zusammenspiel mit Betrieb und Dokumentation
