---
title: "Betrieb - Metriken, Logs und Zustaende"
---

# Betrieb - Metriken, Logs und Zustaende

Konzeptionelle Beschreibung der verschiedenen Beobachtungsebenen im
Monitoring und ihres Zusammenspiels im Betrieb.

## Zweck
Diese Seite beschreibt, welche Arten von Signalen im Monitoring genutzt
werden und welche Rolle sie jeweils spielen.

Ziel ist es, die unterschiedlichen Informationsquellen gezielt und
bewusst einzusetzen, statt sie unstrukturiert zu sammeln.

## Metriken
Metriken sind zeitbasierte, numerische Messwerte:

- Auslastung von Ressourcen
- Antwortzeiten und Durchsatz
- Fehler- und Erfolgsraten

Sie eignen sich besonders fuer Trends, Vergleiche und Schwellen.

## Logs
Logs liefern ereignisbasierte Informationen:

- Fehler- und Warnmeldungen
- Statuswechsel
- Detailinformationen zu Abläufen

Logs sind detailliert, aber ohne Kontext oft schwer auswertbar.

## Zustaende
Zustaende fassen Informationen zusammen:

- Dienst erreichbar oder nicht
- System stabil oder degradiert
- Funktional oder gestoert

Zustaende sind abstrahiert und fuer Entscheidungen besonders geeignet.

## Zusammenspiel
Metriken, Logs und Zustaende ergaenzen sich:

- Zustaende geben schnellen Überblick
- Metriken zeigen Entwicklung und Trends
- Logs liefern Detailinformationen

Kein Signaltyp ersetzt die anderen.

## Auswahl relevanter Signale
Nicht jedes Signal ist gleich wichtig:

- Fokus auf betrieblich relevante Aspekte
- Vermeidung von Signalflut
- Klare Zuordnung zu Entscheidungen

Relevanz bestimmt die Auswahl.

## Abgrenzung
Diese Seite enthaelt keine:

- Konkreten Metrikenlisten
- Logformate oder Parser
- Technische Sammel- oder Speichermechanismen

Solche Details werden auf spezialisierten Detailseiten beschrieben.

## Weiterfuehrend
Weitere Seiten koennen beschreiben:

- Alarmierung auf Basis von Zustaenden
- Korrelation von Signalen
- Nutzung im Stoerungsfall
