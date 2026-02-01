---
title: "NetBox - Als Source of Truth"
---

# NetBox - Als Source of Truth

← Zurueck zur [NetBox-Overview](Overview-NetBox.md)

Konzeptionelle Beschreibung der Rolle von NetBox als zentrale
Wahrheitsquelle (Source of Truth) im Homelab.

## Zweck
Diese Seite beschreibt, warum NetBox als zentrale Referenz fuer
Inventarisierung, Rollen und Beziehungen dient und wie diese Rolle im
Gesamtsystem verstanden wird.

Ziel ist es, widerspruechliche oder verteilte Informationsquellen zu
vermeiden und einen klaren Referenzpunkt zu etablieren.

## Bedeutung einer Source of Truth
Eine Source of Truth ist die autoritative Quelle fuer bestimmte
Informationen:

- Eindeutige, konsistente Daten
- Klare Verantwortlichkeit
- Vermeidung von Doppelpflege
- Verlaessliche Entscheidungsgrundlage

Ohne eine Source of Truth entstehen Inkonsistenzen und Unsicherheiten.

## Abgrenzung von anderen Quellen
Nicht alle Informationen muessen in NetBox liegen:

- Betriebslogs und Momentaufnahmen gehoeren nicht ins Inventar
- Detailkonfigurationen verbleiben bei den jeweiligen Systemen
- Dokumentation erklaert Konzepte, nicht den Ist-Zustand jedes Details

NetBox bildet den **Soll-Zustand** der Infrastruktur ab.

## Zusammenspiel mit Dokumentation
NetBox und Dokumentation ergaenzen sich:

- NetBox liefert strukturierte Fakten
- Dokumentation liefert Kontext, Begruendungen und Konzepte
- Beide muessen konsistent gehalten werden

Widersprueche zwischen beiden sind ein Signal fuer Pflegebedarf.

## Aenderungen und Pflege
Aenderungen am Soll-Zustand erfolgen kontrolliert:

- Aenderungen werden bewusst vorgenommen
- NetBox wird zeitnah aktualisiert
- Dokumentation wird bei Bedarf angepasst

Die Source of Truth bleibt aktuell und vertrauensw

## Weiterfuehrend
- [Inventarisierungsmodell](Inventarisierungsmodell.md)
- [Rollen und Beziehungen](Rollen-und-Beziehungen.md)
