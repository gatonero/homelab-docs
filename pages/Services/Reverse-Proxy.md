---
title: "Services - Reverse Proxy"
---

# Services - Reverse Proxy

Dokumentation des Reverse-Proxy-Services als zentraler Zugriffspunkt
auf interne Dienste im Homelab.

## Zweck
Der Reverse Proxy dient als kontrollierter Einstiegspunkt fuer den Zugriff
auf Web-basierte Services im Homelab. Er entkoppelt externe und interne
Zugriffspfade von den eigentlichen Diensten.

Ziel ist eine zentrale Steuerung von Zugriff, Namensaufloesung und
Verschluesselung.

## Einordnung
Der Reverse Proxy ist ein Infrastruktur-naher Service mit folgenden
Eigenschaften:

- Zentrale Rolle im Zugriffspfad
- Abhaengigkeit von DNS und TLS
- Vermittlung zwischen Clients und internen Services
- Hohe Relevanz fuer Sicherheit und Betrieb

Der Service ist logisch zentral, aber technisch klar abgegrenzt.

## Architektur
Der Reverse Proxy ist typischerweise wie folgt eingebettet:

- Betrieb in einer dedizierten Umgebung (VM oder Container)
- Entgegennahme eingehender HTTP(S)-Anfragen
- Weiterleitung an interne Backend-Services
- Optionale Terminierung von TLS

Die Backend-Services bleiben dabei vom direkten Zugriff entkoppelt.

## Abhaengigkeiten
Der Service haengt unter anderem ab von:

- Konsistenter DNS-Namensaufloesung
- Gueltigen Zertifikaten (intern oder extern)
- Stabiler Netzwerkverbindung zu Backend-Services

Umgekehrt haengen viele Services funktional vom Reverse Proxy ab.

## Betrieb
Im Betrieb gelten fuer den Reverse Proxy folgende Grundsaetze:

- Konfigurationsaenderungen erfolgen kontrolliert
- Zugriffspfade sind dokumentiert
- Fehler wirken sich potenziell auf mehrere Services aus
- Monitoring und Logs sind besonders wichtig

## Backup und Restore
Zu sichern sind insbesondere:

- Konfigurationsdateien
- Zertifikats- und Schluesselmaterial (falls lokal gespeichert)
- Metadaten zu Hosts und Routen

Ein Restore muss priorisiert erfolgen, da der Service zentral ist.

## Abgrenzung
Diese Seite enthaelt keine:

- Tool-spezifischen Konfigurationen
- Regelwerke oder Routing-Details
- Sicherheitsrichtlinien im Detail

Solche Inhalte werden auf spezialisierten Detailseiten behandelt.

## Weiterfuehrend
Weitere Seiten koennen beschreiben:

- Konkrete Reverse-Proxy-Implementierungen
- TLS- und Zertifikatskonzepte
- Zusammenspiel mit DNS und Services
