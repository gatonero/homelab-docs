---
title: "Netzwerk - Reverse Proxy und Zugriffspfade"
---

# Netzwerk - Reverse Proxy und Zugriffspfade

← Zurueck zur [Overview-Netzwerk-DNS-TLS](Overview-Netzwerk-DNS-TLS.md)

Konzeptionelle Beschreibung, wie Zugriffspfade ueber Reverse Proxies
strukturiert und kontrolliert werden.

## Zweck
Diese Seite beschreibt das Zusammenspiel von DNS, TLS und Reverse Proxy
bei der Bereitstellung von Zugriffspfaden auf interne Services.

Ziel ist eine klare, nachvollziehbare und sichere Struktur fuer Zugriffe,
ohne direkte Exponierung interner Dienste.

## Begriffsabgrenzung: Ingress und Reverse Proxy
Der **Ingress** beschreibt die **Rolle und Funktion des Eintrittspunkts** für HTTP(S)-Traffic in das Homelab.
Er ist verantwortlich für:

- Annahme eingehender Verbindungen
- TLS-Terminierung
- Routing zu internen Zielsystemen
- Trennung interner und externer Zugriffspfade

Der **Reverse Proxy** ist **keine eigenständige Architekturkomponente**, sondern die **technische Funktion**, mit der der Ingress diese Aufgaben umsetzt.

Er übernimmt insbesondere:

- Weiterleitung von Anfragen an Backend-Services
- Durchsetzung von TLS- und Header-Regeln
- Protokoll- und Verbindungssteuerung

**Abgrenzung der Dokumentationsebenen:**

- **Architektur** beschreibt *warum* der Ingress so aufgebaut ist
- **Netzwerk, DNS und TLS** beschreiben *wie* Zugriff technisch umgesetzt wird
- **Betrieb** beschreibt *was zu tun ist*, wenn der Zugriff nicht wie erwartet funktioniert

## Zugriffspfade
Zugriff auf Services erfolgt grundsaetzlich ueber definierte Pfade:

- Clients greifen ueber sprechende Namen zu
- Der Reverse Proxy fungiert als zentraler Einstiegspunkt
- Backend-Services bleiben intern und abgeschirmt

Direkter Zugriff auf Services wird bewusst vermieden.

## Rolle des Reverse Proxy
Der Reverse Proxy uebernimmt mehrere zentrale Aufgaben:

- Terminierung von TLS
- Weiterleitung an interne Backend-Services
- Optionale Zugriffskontrolle oder Filterung
- Vereinheitlichung externer und interner Zugriffsmuster

Er entkoppelt Clients von der internen Struktur der Services.

## Zusammenspiel mit DNS und TLS
DNS, TLS und Reverse Proxy greifen eng ineinander:

- DNS stellt stabile Namen bereit
- TLS sichert die Verbindung und Identitaet
- Der Reverse Proxy verbindet Name, Sicherheit und Zielsystem

Aenderungen an einer Komponente wirken sich auf die Zugriffspfade aus
und werden daher bewusst geplant.

## Designprinzipien
Fuer Zugriffspfade gelten folgende Prinzipien:

- Zentralisierung statt verteilter Sonderloesungen
- Klare, dokumentierte Routen
- Minimierung direkter Exponierung
- Trennung von Zugriff und Service-Implementierung

Diese Prinzipien erhoehen Sicherheit und Wartbarkeit.

## Abgrenzung
Diese Seite enthaelt keine:

- Konkreten Proxy-Regeln oder Konfigurationen
- Authentifizierungs- oder Autorisierungsdetails
- Performance-Optimierungen

Solche Inhalte werden auf spezialisierten Detailseiten behandelt.

## Weiterfuehrend
Weitere Seiten koennen beschreiben:

- Konkrete Reverse-Proxy-Setups
- Zugriffskontrollen und Authentifizierung
- Betrieb und Fehlersuche bei Zugriffspfaden
