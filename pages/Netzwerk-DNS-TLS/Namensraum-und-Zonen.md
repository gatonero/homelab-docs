---
title: "Netzwerk - Namensraum und DNS-Zonen"
---

# Netzwerk - Namensraum und DNS-Zonen

Konzeptionelle Beschreibung der internen Namensraeume und DNS-Zonen im
Homelab.

## Zweck
Diese Seite beschreibt, wie Namensraeume und DNS-Zonen strukturiert
werden, um eine konsistente, stabile und nachvollziehbare Erreichbarkeit
von Systemen und Services zu ermoeglichen.

Der Fokus liegt auf der logischen Struktur und den Designentscheidungen,
nicht auf konkreten DNS-Records.

## Interner Namensraum
Das Homelab verwendet einen klar definierten internen Namensraum:

- Trennung von internen und externen Namen
- Keine Abhaengigkeit von oeffentlichen DNS-Zonen
- Klare Erkennbarkeit interner Services

Der interne Namensraum bildet die Grundlage fuer Service-Kommunikation
und Automatisierung.

## DNS-Zonen
DNS-Zonen sind logisch gegliedert, um Verantwortlichkeiten und
Strukturen abzubilden:

- Zonen fuer zentrale Services
- Optionale Subzonen fuer bestimmte Bereiche oder Rollen
- Klare Zuordnung von Namen zu Systemen oder Services

Zonen spiegeln die Architektur wider und sind nicht zufaellig gewachsen.

## Namenskonventionen
Fuer DNS-Namen gelten verbindliche Konventionen:

- Sprechende, beschreibende Namen
- Konsistente Struktur ueber alle Services hinweg
- Keine Kodierung technischer Details im Namen
- Stabilitaet von Namen trotz Aenderungen an IP-Adressen

Namenskonventionen sind Teil der Architektur-Governance.

## Abgrenzung
Diese Seite enthaelt keine:

- Konkreten Zonendateien oder Record-Listen
- Tool-spezifischen DNS-Konfigurationen
- DNS-Rewrite-Regeln im Detail

Solche Inhalte werden auf spezialisierten Detailseiten beschrieben.

## Weiterfuehrend
Weitere Seiten vertiefen unter anderem:

- DNS-Rewrite-Strategien
- Zusammenspiel mit Reverse Proxy und TLS
- Governance und Aenderungsprozesse fuer DNS
