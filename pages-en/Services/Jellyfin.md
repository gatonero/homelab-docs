---
title: "Services - Jellyfin"
---

# Services - Jellyfin

← Zurueck zur [Services-Overview](Overview-Services.md)

Dokumentation des Media-Server-Services Jellyfin im Homelab.

## Zweck
Jellyfin dient als zentraler Media-Server zur Bereitstellung von Video-
und Audioinhalten innerhalb des internen Netzwerks.

Der Service ist auf private Nutzung ausgelegt und stellt Inhalte ueber
eine Weboberflaeche sowie kompatible Clients bereit.

## Einordnung
Jellyfin ist ein Anwendungs-Service mit folgenden Eigenschaften:

- Benutzerorientierter Zugriff
- Persistente Mediendaten
- Abhaengigkeit von Speicher- und Netzwerkdiensten
- Geringe externe Abhaengigkeiten

Der Service laeuft isoliert von anderen Anwendungen und wird klar als
eigenstaendige Einheit betrieben.

## Architektur
Jellyfin ist typischerweise wie folgt eingebettet:

- Betrieb in einer virtualisierten oder containerisierten Umgebung
- Zugriff auf persistente Mediendaten ueber Netzwerkspeicher
- Bereitstellung des Dienstes ueber HTTP(S)
- Integration in DNS- und Reverse-Proxy-Strukturen

Die Trennung von Anwendung, Daten und Zugriffspfad ist bewusst umgesetzt.

## Abhaengigkeiten
Der Service haengt unter anderem ab von:

- Stabiler Netzwerk- und Namensaufloesung
- Verfuegbarem und konsistentem Speicher
- Reverse Proxy und TLS (optional, aber empfohlen)
- Backup der Konfigurations- und Metadaten

Diese Abhaengigkeiten sind fuer Betrieb und Wiederherstellung relevant.

## Betrieb
Im Betrieb gelten fuer Jellyfin folgende Grundsaetze:

- Konfigurationsaenderungen erfolgen bewusst und dokumentiert
- Updates werden kontrolliert durchgefuehrt
- Logs und Status werden bei Stoerungen herangezogen
- Der Service ist nicht kritisch fuer den Gesamtbetrieb des Homelabs

## Backup und Restore
Zu sichern sind insbesondere:

- Konfigurationsdateien
- Metadaten und Datenbankinhalte
- Benutzer- und Bibliotheksinformationen

Mediendateien selbst werden separat betrachtet und unterliegen ggf.
eigenen Sicherungsstrategien.

## Abgrenzung
Diese Seite enthaelt keine:

- Installations- oder Update-Anleitungen
- Client-spezifischen Konfigurationen
- Performance-Tuning-Hinweise

Solche Inhalte werden auf spezialisierten Detailseiten behandelt.

## Weiterfuehrend
Weitere Seiten koennen beschreiben:

- Konkrete Deployment-Varianten
- Anbindung an Speicher
- Betrieb hinter einem Reverse Proxy
