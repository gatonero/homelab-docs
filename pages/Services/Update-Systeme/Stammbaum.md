# UPSYS-006 — Stammbaum Update-Workflow (Betriebsreferenz)

**Projekt:** Update-Systeme

**Teilprojekt:** UPSYS-006 — Stammbaum Update-Workflow

**Status:** 🟡 Zur Abnahme

**Version:** 1.0

---

## Zweck

Die Betriebsreferenz beschreibt den standardisierten Wartungs- und Update-Workflow der produktiven Stammbaum-Anwendung **webtrees** innerhalb des Homelabs.

Ziel ist eine reproduzierbare Wartung mit vollständiger Verifikation und dokumentierter Rollback-Strategie.

Die Referenz dokumentiert ausschließlich den produktiven Istzustand des Homelabs und dient als verbindliche Arbeitsanweisung für Wartungsfenster der Stammbaum-Anwendung.

---

## Geltungsbereich

Diese Betriebsreferenz gilt ausschließlich für die Wartung und Aktualisierung der produktiven Stammbaum-Anwendung innerhalb des Homelabs.

### Bestandteil dieser Referenz

- Stammbaum-Anwendung **webtrees**.
- Docker-Compose-Stack der Anwendung.
- Docker VM auf **Proxmox Node `pve-02`**.
- Reverse-Proxy-Anbindung über **nginx-base** auf **Proxmox Node `pve-01`**.
- Home-Assistant-Collector des Update-Systems.

### Nicht Bestandteil dieser Referenz

- Wartung der Docker VM selbst (UPSYS-001).
- Wartung des Proxmox-Clusters (UPSYS-004).
- Wartung des Reverse-Proxys nginx-base.
- Wartung der QNAP TS-464.
- Wartung des Update-Aggregators oder der Collector.

---

## Ziel der Wartungsstrategie

Die Wartungsstrategie verfolgt folgende Ziele:

- Aktualisierung auf unterstützte webtrees-Versionen.
- Aktualisierung der MariaDB-Version innerhalb der Docker-Strategie.
- Erhalt sämtlicher Stammbaumdaten.
- Minimierung der Ausfallzeit während des Wartungsfensters.
- Vollständige Verifikation nach jedem Update.
- Dokumentierte Wiederherstellung im Fehlerfall.
- Keine Änderungen an Collector, Sensoren oder Update-Aggregator.

---

## Auslöser (TRMNL-Update-Instanz)

Die Wartung wird durch eine Update-Instanz des Homelab-Update-Systems ausgelöst.

TRMNL zeigt die Stammbaum-Anwendung als eigenständige Update-Kategorie an.

**Beispielanzeige**

| Dienst | Updates |
|--------|---------|
| Stammbaum | 2 |

Die Zahl entspricht der Anzahl aktualisierbarer Container innerhalb des produktiven Docker-Compose-Stacks.

TRMNL dient ausschließlich als Einstiegspunkt des Wartungsprozesses. Die eigentliche Durchführung erfolgt innerhalb der Docker VM.

---

## Datenquelle (Collector)

Für die Stammbaum-Anwendung werden ausschließlich vorhandene Home-Assistant-Collector verwendet.

| Sensor | Bedeutung |
|--------|-----------|
| `sensor.stammbaum_update_count` | Anzahl verfügbarer Container-Updates. |
| `sensor.stammbaum_update_summary` | Zusammenfassung der verfügbaren Updates. |

Es werden keine zusätzlichen REST-Abfragen, Scanner oder Update-Erkennungen implementiert.

Die Betriebsreferenz beschreibt ausschließlich die Verwendung dieser Sensoren während Wartung und Verifikation.

---

## Vorbedingungen

Vor Beginn jeder Wartung werden sämtliche Voraussetzungen dokumentiert.

Die Wartung beginnt erst, wenn alle Vorbedingungen erfüllt sind.

### Vorbedingung — Wartungsfenster festlegen

Vor Beginn der Wartung muss ein Wartungsfenster definiert werden.

Zu dokumentieren sind:

- Wartungszeitpunkt.
- Erwartete Dauer.
- Kurzzeitige Nichtverfügbarkeit akzeptiert.
- Benutzer informiert (falls erforderlich).

### Vorbedingung — Docker VM erreichbar

Vor Beginn muss die Docker VM betriebsbereit sein.

Zu prüfen sind:

- Docker VM läuft.
- SSH-Verbindung möglich.
- Docker-Dienst aktiv.

### Vorbedingung — Docker Compose vorhanden

Vor Beginn wird der produktive Docker-Compose-Stack geprüft.

Zu dokumentieren sind:

- Compose-Verzeichnis vorhanden.
- `docker-compose.yml` vorhanden.
- Aktueller Containerstatus bekannt.

### Vorbedingung — Backup der Docker VM

Vor jedem Update muss ein aktuelles Backup der Docker VM vorhanden sein.

Zu dokumentieren sind:

- Zeitpunkt des Backups.
- Erfolgreicher Abschluss.
- Backup entspricht dem produktiven Stand.

### Vorbedingung — Backup der MariaDB-Datenbank

Vor jedem Update wird ein Backup der produktiven MariaDB-Datenbank erstellt.

Zu dokumentieren sind:

- Datenbankname.
- Speicherort des Backups.
- Zeitpunkt der Sicherung.
- Erfolgreicher Abschluss der Sicherung.

### Vorbedingung — Backup der webtrees-Daten

Vor jedem Update werden die persistenten Anwendungsdaten gesichert.

Zu sichern sind:

- `./data`
- `./themes` (sofern vorhanden)

Zu dokumentieren sind:

- Speicherort der Sicherung.
- Zeitpunkt der Sicherung.
- Erfolgreicher Abschluss der Sicherung.

### Vorbedingung — Backup der Docker-Compose-Konfiguration

Vor jedem Update wird die Konfiguration des Docker-Compose-Stacks gesichert.

Zu sichern sind:

- `docker-compose.yml`
- `.env` (falls vorhanden)
- Weitere produktive Konfigurationsdateien des Stacks.

Zu dokumentieren sind:

- Speicherort der Sicherung.
- Zeitpunkt der Sicherung.
- Erfolgreicher Abschluss der Sicherung.

### Vorbedingung — Home Assistant Collector prüfen

Vor Beginn der Wartung wird der Status der vorhandenen Collector dokumentiert.

Zu prüfen sind ausschließlich in Home Assistant:

- `sensor.stammbaum_update_count`
- `sensor.stammbaum_update_summary`

Die Sensorwerte dienen als Ausgangszustand für die spätere Verifikation.

### Vorbedingung — Uptime Kuma prüfen

Vor Beginn der Wartung muss Uptime Kuma den Dienst als erreichbar melden.

Zu dokumentieren sind:

- HTTP-Monitor erreichbar.
- HTTPS-Monitor erreichbar.
- Keine SSL-Warnungen.
- Dienststatus **UP**.

### Vorbedingung — HTTPS-Verfügbarkeit prüfen

Vor Beginn der Wartung wird die öffentliche Erreichbarkeit dokumentiert.

Zu prüfen sind:

- `https://stammbaum.home.arpa`
- Gültiges TLS-Zertifikat.
- Keine Browserwarnungen.
- Erfolgreiche HTTPS-Termination über nginx-base.

---

## Durchführung

Der Wartungsprozess erfolgt vollständig innerhalb der Docker VM.

Alle Änderungen werden ausschließlich über den produktiven Docker-Compose-Stack durchgeführt.

### Standardisierte Reihenfolge

1. Backups erstellen.
2. Docker-Images aktualisieren.
3. Docker-Compose-Stack aktualisieren.
4. Nicht mehr benötigte Images bereinigen.
5. Vollständige Verifikation durchführen.

### Durchführung — Compose-Verzeichnis öffnen

Vor Beginn wird das produktive Compose-Verzeichnis geöffnet.

Zu dokumentieren sind:

- Pfad des Compose-Verzeichnisses.
- Vorhandensein der `docker-compose.yml`.
- Vorhandensein weiterer Konfigurationsdateien (`.env`, falls vorhanden).

### Durchführung — Aktuellen Containerstatus dokumentieren

Vor jeder Änderung wird der Ausgangszustand dokumentiert.

Zu dokumentieren sind:

- Laufende Container.
- Zugehörige Images.
- Containerstatus.
- Uptime beider Container.

### Durchführung — Docker-Images aktualisieren

Die Aktualisierung erfolgt ausschließlich mit dem Docker-Compose-Standardverfahren.

Ziel:

- Aktuelle Images herunterladen.
- Keine manuellen Image-Manipulationen.
- Keine Änderungen außerhalb des Compose-Stacks.

### Durchführung — Container aktualisieren

Nach dem Download der Images wird der Docker-Compose-Stack aktualisiert.

Grundsätze:

- Beide Container werden gemeinsam aktualisiert.
- Keine manuelle Neuerstellung einzelner Container außerhalb von Docker Compose.
- Persistente Volumes bleiben unverändert erhalten.

### Durchführung — Nicht verwendete Images bereinigen

Nach erfolgreicher Aktualisierung werden nicht mehr benötigte Docker-Images entfernt.

Grundsätze:

- Nur nicht verwendete Images werden entfernt.
- Persistente Volumes bleiben erhalten.
- Laufende Container werden nicht beeinflusst.

Ziel ist die Bereinigung veralteter Images nach erfolgreichem Container-Neustart.

### Durchführung — Containerstatus erneut dokumentieren

Nach Abschluss der Aktualisierung wird der neue Containerzustand dokumentiert.

Zu dokumentieren sind:

- `webtrees-app` läuft.
- `webtrees-db` läuft.
- Beide Container besitzen den Status **running**.
- Keine Neustartschleifen.
- Keine Docker-Compose-Fehler.

Damit ist die Durchführung abgeschlossen und die Verifikation beginnt.

---

## Verifikation

Die Verifikation erfolgt unmittelbar nach Abschluss des Updates und vor dem Ende des Wartungsfensters.

### Ziel der Verifikation

Nach jedem Update muss nachgewiesen werden, dass:

- der Docker-Compose-Stack fehlerfrei läuft,
- die Anwendung vollständig erreichbar ist,
- die Datenbank funktioniert,
- HTTPS korrekt terminiert wird,
- Home Assistant keine offenen Updates mehr meldet,
- Uptime Kuma den Dienst wieder als erreichbar meldet,
- TRMNL keine Update-Instanz mehr anzeigt.

### Verifikation — Docker-Compose-Stack

Zu prüfen sind:

- `webtrees-app` läuft.
- `webtrees-db` läuft.
- Beide Container besitzen den Status **running**.
- Keine Neustartschleifen.
- Docker Compose meldet keine Fehler.

Zu dokumentieren sind:

- Containerstatus.
- Verwendete Image-Versionen.
- Uptime beider Container.

### Verifikation — Anwendung

Die produktive Anwendung wird vollständig geprüft.

Zu prüfen sind:

- `https://stammbaum.home.arpa` erreichbar.
- HTTP-Status 200.
- Startseite vollständig geladen.
- Anmeldung in webtrees funktioniert.
- Navigation funktioniert.
- Stammbaumdaten werden angezeigt.

Zusätzlich werden geprüft:

- Personenansicht.
- Familienansicht.
- Medien.
- Suche.

### Verifikation — Datenbank

Zu prüfen sind:

- MariaDB läuft.
- Verbindung zwischen `webtrees-app` und `webtrees-db` erfolgreich.
- Keine Datenbankfehler im Anwendungslog.
- Keine Datenbankfehler im MariaDB-Log.

### Verifikation — HTTPS

Zu prüfen sind:

- HTTPS erreichbar.
- TLS-Zertifikat gültig.
- Zertifikatskette vollständig.
- Keine Browserwarnungen.

Zu dokumentieren sind:

- Zertifikat gültig.
- Hostname korrekt.
- HTTPS-Termination über nginx-base funktioniert.

### Verifikation — Reverse-Proxy

Zu prüfen sind:

- nginx-base liefert `stammbaum.home.arpa`.
- Weiterleitung an Port **40260** der Docker VM funktioniert.
- Keine HTTP-Fehler.
- Keine TLS-Fehler.

### Verifikation — Home Assistant

Die Prüfung erfolgt ausschließlich über die Home-Assistant-Oberfläche.

Zu dokumentieren sind:

- `sensor.stammbaum_update_count = 0`
- `sensor.stammbaum_update_summary` ist leer.

BusyBox- oder Supervisor-Abfragen der Sensoren sind nicht Bestandteil der Verifikation.

### Verifikation — TRMNL

Zu prüfen sind:

- TRMNL zeigt keine Stammbaum-Updates mehr.
- Der Update-Aggregator meldet keine offenen Container-Updates für die Stammbaum-Anwendung.

### Verifikation — Uptime Kuma

Zu prüfen sind:

- HTTP-Monitor grün.
- HTTPS-Monitor grün.
- Keine SSL-Warnungen.
- Keine Ausfälle während der Abschlussprüfung.

### Verifikation — Container-Logs

Zu dokumentieren sind:

- Keine Fatal Errors.
- Keine PHP-Warnungen.
- Keine Datenbankfehler.
- Keine Neustartschleifen.

### Abschluss der Verifikation

Die Wartung gilt erst als erfolgreich abgeschlossen, wenn alle Prüfpunkte erfolgreich dokumentiert wurden und sämtliche Monitoring-Systeme den Dienst wieder als fehlerfrei melden.

---

## Rollback

Rollback wird ausschließlich durchgeführt, wenn die Verifikation fehlschlägt oder der produktive Betrieb nach dem Update nicht wiederhergestellt werden kann.

### Ziel des Rollbacks

Das Ziel des Rollbacks ist die vollständige Wiederherstellung des zuletzt funktionierenden Produktionszustands der Stammbaum-Anwendung einschließlich Datenbank, Anwendungsdaten und Docker-Compose-Konfiguration.

### Rollback-Stufe 1 — Docker-Compose-Konfiguration

Wiederherzustellen sind:

- `docker-compose.yml`
- `.env` (falls vorhanden)
- Weitere produktive Konfigurationsdateien des Stacks.

Anschließend wird der Docker-Compose-Stack erneut gestartet und der Containerstatus überprüft.

Zu dokumentieren sind:

- Erfolgreiche Wiederherstellung der Konfiguration.
- Containerstatus nach dem Neustart.
- Erreichbarkeit der Anwendung.

### Rollback-Stufe 2 — MariaDB-Datenbank

Falls die Datenbank nach dem Update fehlerhaft ist, erfolgt die Wiederherstellung aus dem zuvor erstellten Datenbank-Backup.

Zu prüfen sind:

- MariaDB startet erfolgreich.
- Verbindung zwischen `webtrees-app` und `webtrees-db` funktioniert.
- Datenbestand vollständig vorhanden.
- Keine Datenbankfehler in den Logs.

### Rollback-Stufe 3 — webtrees-Daten

Falls Anwendungsdaten beschädigt oder unvollständig sind, werden die persistenten Daten zurückgesichert.

Wiederherzustellen sind:

- `./data`
- `./themes` (sofern vorhanden)

Nach der Wiederherstellung werden geprüft:

- Medien vorhanden.
- Benutzerkonten vorhanden.
- Einstellungen vorhanden.
- Stammbaumdaten vollständig.

### Rollback-Stufe 4 — Docker VM

Falls die vorherigen Rollback-Stufen den produktiven Zustand nicht wiederherstellen, erfolgt die Wiederherstellung der gesamten Docker VM.

Zulässige Wiederherstellungsquellen:

- Proxmox Backup.
- Proxmox Snapshot (nur kurzfristig).

Zu dokumentieren sind:

- Verwendete Wiederherstellungsquelle.
- Zeitpunkt der Wiederherstellung.
- Erfolgreiche Wiederherstellung der VM.

### Abschluss des Rollbacks

Nach jedem Rollback wird die vollständige Verifikation dieser Betriebsreferenz erneut durchgeführt.

Die Wartung gilt erst als abgeschlossen, wenn die Verifikation wieder erfolgreich ist.

---

## Besonderheiten

Die Stammbaum-Anwendung besitzt innerhalb des Homelabs eine eigene Architektur, die bei Wartung und Verifikation berücksichtigt werden muss.

### Architektur des Homelabs

#### Docker VM

- Docker Compose läuft ausschließlich auf der Docker VM.
- Die Docker VM läuft als virtuelle Maschine auf **Proxmox Node `pve-02`**.
- Wartungsarbeiten erfolgen ausschließlich innerhalb dieser VM.

#### webtrees

- Anwendung: **webtrees**
- Produktive Version zum Zeitpunkt dieser Referenz: **2.1.21**
- Docker-Container: `webtrees-app`
- Persistente Anwendungsdaten befinden sich im Verzeichnis `./data`.

#### MariaDB

- Docker-Container: `webtrees-db`
- Datenbank: **MariaDB 11**
- Persistente Datenbankdaten befinden sich im Verzeichnis `./mariadb`.

#### Netzwerkarchitektur

Die Anwendung stellt ausschließlich HTTP innerhalb des Docker-Netzwerks bereit.

Docker veröffentlicht:

- Port **40260 → 80**

Die öffentliche Adresse lautet:

- `https://stammbaum.home.arpa`

#### HTTPS-Termination

Die HTTPS-Terminierung erfolgt zentral über den Reverse-Proxy **nginx-base** auf **Proxmox Node `pve-01`**.

Die Anwendung verwendet:

- `BASE_URL=https://stammbaum.home.arpa`
- `HTTPS=0`
- `HTTPS_REDIRECT=0`

Änderungen an nginx-base sind **nicht Bestandteil** dieses Wartungsworkflows.

### Infrastruktur-Abhängigkeiten

Die Stammbaum-Anwendung ist produktiv abhängig von:

- Proxmox Cluster.
- Proxmox Node `pve-02`.
- Docker VM.
- Docker Compose.
- nginx-base auf `pve-01`.
- Home Assistant.
- TRMNL Update-System.
- Uptime Kuma.
- QNAP TS-464 als Backup-Ziel.

### Backup-Strategie

Vor jedem Update muss die mehrstufige Backup-Strategie vollständig erfüllt sein.

#### Anwendung

Zu sichern sind:

- `./data`
- `./themes` (sofern vorhanden)

#### Datenbank

Vor jedem Update wird ein Backup der MariaDB-Datenbank erstellt.

#### Docker-Compose-Konfiguration

Zu sichern sind:

- `docker-compose.yml`
- `.env` (falls vorhanden)
- Weitere produktive Konfigurationsdateien.

#### Virtuelle Maschine

Vor jedem Update muss ein aktuelles Backup der Docker VM vorhanden sein.

#### Zentrales Backup-Ziel

Das zentrale Backup-Ziel ist die **QNAP TS-464**.

Die Wartung der QNAP ist Bestandteil von **UPSYS-003** und gehört nicht zu dieser Betriebsreferenz.

### Monitoring

Nach jeder Wartung erfolgt die Abschlusskontrolle über die produktiven Monitoring-Systeme.

#### Home Assistant

Zu prüfen sind ausschließlich:

- `sensor.stammbaum_update_count`
- `sensor.stammbaum_update_summary`

#### TRMNL

Zu prüfen sind:

- Keine offene Stammbaum-Update-Instanz.
- Update-Aggregator meldet keine offenen Container-Updates.

#### Uptime Kuma

Zu prüfen sind:

- HTTP-Monitor erreichbar.
- HTTPS-Monitor erreichbar.
- SSL gültig.
- Keine Fehlalarme.

### Wartungsgrenzen

Diese Betriebsreferenz umfasst ausschließlich:

- Docker-Compose-Wartung.
- webtrees-Anwendung.
- MariaDB.
- Verifikation.
- Rollback.

Nicht Bestandteil sind:

- UPSYS-001 — Docker VM.
- UPSYS-002 — Home Assistant.
- UPSYS-003 — QNAP TS-464.
- UPSYS-004 — Proxmox Cluster.
- Wartung von nginx-base.
- Netzwerk-, DNS- oder Zertifikatswartung außerhalb der Anwendung.

### Dokumentationsgrundsätze

Diese Betriebsreferenz dokumentiert ausschließlich den produktiven Istzustand des Homelabs.

Es gelten folgende Grundsätze:

- Keine Platzhalter.
- Keine Testumgebungen.
- Keine temporären Inhalte.
- Keine Änderungen an Collector oder Update-Aggregator.
- Keine Änderungen an der Homelab-Architektur.
- Jede Wartung endet mit vollständiger Verifikation oder Rollback.

