# ElseLevy7

**Betriebsreferenz V1.4**

Standardisierter Wartungs- und Update-Workflow der produktiven WordPress-Instanz ElseLevy7 innerhalb des Homelabs.

---

## Zweck

Diese Betriebsreferenz beschreibt den vollständigen produktiven Wartungsprozess der WordPress-Instanz **ElseLevy7**. Ziel ist eine reproduzierbare, sichere und nachvollziehbare Durchführung von WordPress-Updates einschließlich Backup, Verifikation und Rollback.

Die Dokumentation beantwortet ausschließlich die Frage:

> Wie wird ElseLevy7 sicher aktualisiert, verifiziert und bei Bedarf zurückgesetzt?

Die Referenz ist Bestandteil des Homelab-Projekts **Update-Systeme** und dient als operative Produktionsdokumentation.

---

## Geltungsbereich

Diese Betriebsreferenz gilt ausschließlich für die produktive WordPress-Instanz **ElseLevy7** innerhalb des Homelabs.

### Infrastruktur

| Komponente | Beschreibung |
|------------|--------------|
| Anwendung | WordPress |
| Container-Orchestrierung | Docker Compose |
| Laufzeitumgebung | Docker innerhalb eines LXC-Containers |
| Proxmox-Host | `pve-01` |
| Reverse Proxy | `nginx-base` |
| TLS | `mkcert` Wildcard-Zertifikat (`*.home.arpa`) |
| PHP | Eigener Docker-Container |
| Datenbank | MariaDB-Docker-Container |
| Monitoring | Home Assistant, TRMNL, Uptime Kuma |
| Backup-Ziel | QNAP TS-464 |

Nicht Bestandteil dieser Referenz sind:

- Update-Erkennung.
- Collector oder Sensoren.
- TRMNL-Plugin-Implementierungen.
- Home-Assistant-Automationen zur Update-Ermittlung.

---

## Ziel der Wartungsstrategie

Die Wartungsstrategie verfolgt folgende Ziele:

- sichere Aktualisierung der produktiven WordPress-Instanz,
- Minimierung des Ausfallrisikos,
- vollständige Wiederherstellbarkeit,
- einheitlicher Ablauf für alle zukünftigen WordPress-Wartungen.

### Grundsätze

- Updates erfolgen ausschließlich innerhalb eines geplanten Wartungsfensters.
- Vor jedem Update existiert eine vollständige Sicherung aller relevanten Daten.
- Änderungen erfolgen ausschließlich auf dem produktiven LXC-Container auf `pve-01`.
- Es werden keine Infrastrukturänderungen parallel zu WordPress-Updates durchgeführt.
- Plugins werden möglichst einzeln aktualisiert.
- Nach jedem größeren Update erfolgt unmittelbar eine Funktionsprüfung.

---

## Auslöser (TRMNL-Update-Instanz)

Die Wartung beginnt ausschließlich aufgrund einer erkannten WordPress-Aktualisierung.

### Auslöser

Die TRMNL-Update-Instanz meldet verfügbare WordPress-Updates.

Folgende Ereignisse lösen den Wartungsworkflow aus:

- WordPress-Core-Update verfügbar.
- Plugin-Update verfügbar.
- Theme-Update verfügbar.
- Sprachdatei-Update verfügbar.

### Anzeige im Homelab

Die Information wird angezeigt über:

- Home Assistant.
- TRMNL Homelab Dashboard.
- Uptime Kuma bleibt ausschließlich Monitoring-System und löst keine Updates aus.

---

## Datenquelle (Collector)

Die Betriebsreferenz verwendet ausschließlich die vorhandenen Home-Assistant-Collector.

### Verwendete Sensoren

| Sensor | Bedeutung |
|--------|-----------|
| `sensor.elselevy7_update_count` | Anzahl verfügbarer Updates. |
| `sensor.elselevy7_update_summary` | Zusammenfassung der verfügbaren Updates. |

### Verwendung

Die Sensoren dienen ausschließlich:

- zum Auslösen eines Wartungsfensters,
- zur Kontrolle des Wartungserfolgs,
- zur Anzeige im TRMNL-Dashboard.

### Nicht Bestandteil dieser Referenz

Es werden keine zusätzlichen Scanner, REST-Aufrufe oder Collector implementiert.

---

## Vorbedingungen

Vor Beginn eines produktiven WordPress-Updates müssen sämtliche Vorbedingungen erfüllt sein.

Ein Update beginnt erst, wenn alle Prüfpunkte erfolgreich abgeschlossen wurden.

### Wartungsfenster

- Wartungsfenster definiert.
- Benutzer über kurze Nichtverfügbarkeit informiert.
- Kurzzeitige Downtime der Website ist zulässig.

### Backup-Status

Vor jedem Update müssen folgende Sicherungen vorhanden sein.

| Sicherung | Status |
|-----------|--------|
| Vollständiges WordPress-Datei-Backup | Erforderlich |
| Vollständiges Upload-Verzeichnis | Erforderlich |
| `wp-config.php` gesichert | Erforderlich |
| Docker-Compose-Konfiguration gesichert | Erforderlich |
| MariaDB-Datenbank-Dump vorhanden | Erforderlich |
| LXC-Backup oder Snapshot vorhanden | Erforderlich |
| Backup erfolgreich abgeschlossen | Erforderlich |

### Infrastruktur prüfen

Vor Beginn müssen folgende Systeme fehlerfrei laufen.

| Komponente | Erwarteter Zustand |
|------------|-------------------|
| Proxmox `pve-01` | erreichbar |
| LXC-Container | läuft |
| Docker-Dienst | aktiv |
| WordPress-Container | läuft |
| PHP-Container | läuft |
| MariaDB-Container | läuft |
| nginx-base | erreichbar |

### Website prüfen

Vor Beginn muss die Website fehlerfrei erreichbar sein.

Pflichtprüfungen:

- HTTPS erreichbar.
- HTTP-Status 200.
- Startseite vollständig geladen.
- WordPress-Backend erreichbar.
- Anmeldung im Backend möglich.

### TLS prüfen

Vor Beginn muss das Zertifikat gültig sein.

Pflichtprüfungen:

- Zertifikat gültig.
- Keine Browserwarnung.
- Zertifikatskette vollständig.

### Monitoring prüfen

Vor Beginn müssen alle Monitoring-Systeme einen fehlerfreien Zustand melden.

| Monitoring | Erwartung |
|------------|-----------|
| Home Assistant | Website erreichbar |
| TRMNL | Update wird angezeigt |
| Uptime Kuma | Status „Up“ |

### Update-Umfang dokumentieren

Vor Beginn wird dokumentiert:

- Anzahl verfügbarer Updates.
- Art der Updates (Core, Plugins, Themes, Sprache).
- Besonderheiten oder bekannte Inkompatibilitäten.
- Geplantes Wartungsfenster.

---

## Durchführung

Die Durchführung beschreibt den standardisierten Wartungsablauf der produktiven WordPress-Instanz ElseLevy7.

### Wartungsgrundsätze

Der Update-Prozess erfolgt immer in derselben Reihenfolge.

1. Datenbank sichern.
2. WordPress-Dateien sichern.
3. Docker-Compose-Konfiguration sichern.
4. WordPress-Core aktualisieren.
5. Plugins einzeln aktualisieren.
6. Themes aktualisieren.
7. Sprachdateien aktualisieren.
8. Betroffene Docker-Container neu starten, falls erforderlich.
9. Vollständige Funktionsprüfung durchführen.

Während eines Wartungsfensters werden keine weiteren Infrastrukturänderungen vorgenommen.

---

### 1. MariaDB-Datenbank sichern

Vor jedem WordPress-Update wird eine vollständige Sicherung der Datenbank erstellt.

#### Ziel

- Vollständige Wiederherstellung aller Inhalte.
- Wiederherstellung der WordPress-Konfiguration.
- Wiederherstellung von Benutzern, Plugins und Einstellungen.

#### Sicherungsumfang

- gesamte WordPress-Datenbank,
- Tabellenstruktur,
- Inhalte,
- Benutzerkonten,
- Plugin-Konfigurationen.

#### Ergebnis

Es existiert ein vollständiger MariaDB-Dump vor Beginn weiterer Arbeiten.

---

### 2. WordPress-Dateien sichern

Nach erfolgreicher Datenbanksicherung werden sämtliche WordPress-Dateien gesichert.

#### Sicherungsumfang

- WordPress-Core-Dateien,
- `wp-content`,
- Upload-Verzeichnis,
- Plugins,
- Themes,
- Medien,
- Sprachdateien,
- Konfigurationsdateien.

#### Besonders zu sichern

- `wp-config.php`
- `.htaccess` (falls vorhanden)
- benutzerdefinierte Konfigurationen innerhalb von `wp-content`.

#### Ergebnis

Alle produktiven Dateien liegen als vollständiges Backup vor.

---

### 3. Docker-Compose-Konfiguration sichern

Vor Änderungen an Containern wird die vollständige Docker-Konfiguration gesichert.

#### Sicherungsumfang

- `docker-compose.yml`
- `.env`
- zusätzliche Compose-Dateien,
- benutzerdefinierte Konfigurationen,
- Container-spezifische Konfigurationsdateien.

#### Ziel

Die WordPress-Umgebung kann vollständig reproduziert werden.

---

### 4. WordPress-Core aktualisieren

Der WordPress-Core wird vor Plugins und Themes aktualisiert.

#### Reihenfolge

1. Verfügbarkeit prüfen.
2. Core aktualisieren.
3. Abschlussmeldung prüfen.

#### Nach Abschluss prüfen

- Core-Version erfolgreich aktualisiert.
- Keine Fehlermeldungen.
- Administrationsbereich erreichbar.

#### Hinweis

Während des Core-Updates kann die Website kurzzeitig in den Wartungsmodus wechseln.

---

### 5. Plugins einzeln aktualisieren

Plugins werden grundsätzlich einzeln aktualisiert.

#### Reihenfolge

- Sicherheitsrelevante Plugins zuerst.
- Infrastruktur-Plugins anschließend.
- Funktions-Plugins zuletzt.

#### Nach jedem Plugin

Es erfolgt unmittelbar eine Funktionsprüfung.

Geprüft werden insbesondere:

- Frontend erreichbar.
- Backend erreichbar.
- Plugin aktiviert.
- Keine PHP-Warnungen.
- Keine Fatal Errors.

#### Grundsatz

Keine Sammelaktualisierung aller Plugins ohne Zwischentests.

---

### 6. Themes aktualisieren

Nach erfolgreicher Plugin-Aktualisierung erfolgt das Theme-Update.

#### Prüfpunkte

- aktives Theme bleibt aktiv,
- Child-Theme unverändert,
- Layout vollständig geladen,
- Navigation vorhanden,
- Widgets vorhanden.

#### Nach Abschluss

Startseite vollständig prüfen.

---

### 7. Sprachdateien aktualisieren

Nach Core, Plugins und Themes werden Sprachdateien aktualisiert.

#### Umfang

- WordPress-Core,
- Plugins,
- Themes.

#### Ziel

Alle Übersetzungen entsprechen der installierten Version.

---

### 8. Docker-Container neu starten (falls erforderlich)

Container werden ausschließlich neu gestartet, wenn dies für die Übernahme eines Updates erforderlich ist.

#### Betroffene Container

| Container | Zweck |
|----------|------|
| WordPress | Webanwendung |
| PHP | PHP-FPM |
| MariaDB | Datenbank |

#### Grundsätze

- Nur betroffene Container neu starten.
- Keine Änderungen an Volumes.
- Keine Änderungen an Netzwerken.

#### Erwarteter Zustand

Alle Container starten fehlerfrei.

---

### 9. Docker-Compose-Status prüfen

Nach Container-Neustarts wird der Docker-Compose-Stack überprüft.

#### Erwarteter Zustand

| Komponente | Erwartung |
|------------|-----------|
| WordPress | running |
| PHP | running |
| MariaDB | running |

Es dürfen keine Container im Status:

- exited,
- restarting,
- unhealthy

verbleiben.

---

### 10. Funktionsprüfung nach jedem größeren Update

Nach jedem Core-, Plugin- oder Theme-Update erfolgt eine unmittelbare Funktionsprüfung.

#### Frontend

- Startseite lädt vollständig.
- Navigation funktioniert.
- Bilder werden angezeigt.
- Formulare funktionieren.

#### Backend

- Anmeldung möglich.
- Dashboard vollständig.
- Plugins erreichbar.
- Theme-Einstellungen erreichbar.

#### Inhalte

- Beiträge sichtbar.
- Seiten sichtbar.
- Medienbibliothek erreichbar.

---

### Wartungsprotokoll

Jedes Update wird dokumentiert.

#### Dokumentiert werden

| Eintrag | Beschreibung |
|---------|--------------|
| Datum | Wartungszeitpunkt |
| Wartungsfenster | Beginn und Ende |
| Core-Version | Vorher/Nachher |
| Aktualisierte Plugins | Liste |
| Aktualisierte Themes | Liste |
| Sprachdateien | Aktualisiert |
| Besonderheiten | Auffälligkeiten |
| Rollback erforderlich | Ja/Nein |

Das Wartungsprotokoll dient der Nachvollziehbarkeit produktiver Änderungen.


---

## Verifikation

Nach Abschluss aller Updates wird eine vollständige technische Verifikation durchgeführt.

Die Wartung gilt erst dann als erfolgreich abgeschlossen, wenn sämtliche Prüfpunkte erfolgreich sind.

### Verifikationsreihenfolge

Die Prüfungen erfolgen in folgender Reihenfolge:

1. Website
2. WordPress
3. Docker
4. LXC
5. TLS
6. Home Assistant
7. Monitoring

---

### Website

Die Website muss vollständig funktionsfähig sein.

#### Pflichtprüfungen

| Prüfung | Erwartung |
|---------|-----------|
| HTTPS erreichbar | Ja |
| HTTP-Status | 200 OK |
| Startseite | vollständig geladen |
| Navigation | funktionsfähig |
| Bilder | sichtbar |
| CSS/JavaScript | korrekt geladen |
| Kontaktformulare | funktionsfähig (falls vorhanden) |

#### Ergebnis

Die Website ist ohne Browserwarnungen erreichbar.

---

### WordPress

Der WordPress-Administrationsbereich wird vollständig geprüft.

#### Pflichtprüfungen

| Prüfung | Erwartung |
|---------|-----------|
| Anmeldung möglich | Ja |
| Dashboard erreichbar | Ja |
| Core-Version aktuell | Ja |
| Plugins aktiv | Ja |
| Theme aktiv | Ja |
| Sprachdateien aktuell | Ja |
| Update-Hinweise vorhanden | Nein |

#### Zusätzliche Kontrolle

- Keine deaktivierten Plugins durch das Update.
- Keine unerwarteten neuen Plugins.
- Keine fehlenden Themes.

---

### PHP-Prüfung

Die PHP-Laufzeit wird geprüft.

#### Erwarteter Zustand

- Keine PHP-Warnings.
- Keine PHP-Notices.
- Keine Deprecated-Meldungen.
- Keine Fatal Errors.

#### Ziel

Die Website arbeitet ohne Laufzeitfehler.

---

### Docker

Der Docker-Stack muss vollständig aktiv sein.

#### Pflichtprüfungen

| Container | Erwartung |
|-----------|-----------|
| WordPress | running |
| PHP | running |
| MariaDB | running |

#### Docker Compose

Der Compose-Stack meldet:

- alle Container aktiv,
- keine Neustart-Schleifen,
- keine fehlerhaften Container.

---

### Persistente Volumes

Nach dem Update werden die Volumes geprüft.

#### Erwarteter Zustand

- WordPress-Daten vorhanden.
- Upload-Verzeichnis vorhanden.
- Plugins vorhanden.
- Themes vorhanden.
- MariaDB-Daten vorhanden.

Es dürfen keine Volumes neu erstellt worden sein.

---

### LXC-Container

Der LXC-Container wird geprüft.

#### Pflichtprüfungen

| Prüfung | Erwartung |
|---------|-----------|
| Container läuft | Ja |
| Docker-Dienst aktiv | Ja |
| Netzwerk aktiv | Ja |
| Dateisystem beschreibbar | Ja |

#### Neustarts

Falls Container neu gestartet wurden:

- erfolgreicher Start,
- keine Fehler im Startprozess.

---

### Proxmox-Ebene

Die Wartung darf keine Auswirkungen auf den Cluster haben.

#### Erwarteter Zustand

- `pve-01` arbeitet normal.
- Keine Migration durchgeführt.
- Keine Snapshot-Probleme.
- Keine Storage-Fehler.

---

### TLS

Die HTTPS-Konfiguration wird geprüft.

#### Pflichtprüfungen

| Prüfung | Erwartung |
|---------|-----------|
| Zertifikat gültig | Ja |
| Wildcard-Zertifikat aktiv | Ja |
| Zertifikatskette vollständig | Ja |
| HTTPS ohne Warnung | Ja |

#### Ziel

Der Reverse Proxy liefert ein gültiges Zertifikat aus.

---

### Reverse Proxy

Die Kommunikation über `nginx-base` wird geprüft.

#### Erwarteter Zustand

- Weiterleitung funktioniert.
- Backend erreichbar.
- Keine HTTP-502.
- Keine HTTP-503.
- Keine HTTP-504.

---

### Home Assistant

Nach erfolgreichem Update werden die Collector-Sensoren geprüft.

#### Erwarteter Zustand

| Sensor | Erwartung |
|--------|-----------|
| `sensor.elselevy7_update_count` | `0` |
| `sensor.elselevy7_update_summary` | leer |

#### Bedeutung

Home Assistant erkennt keine ausstehenden Updates mehr.

---

### TRMNL

Das Homelab-Dashboard wird geprüft.

#### Erwarteter Zustand

- ElseLevy7 erscheint nicht mehr als Update-Kandidat.
- Keine offenen WordPress-Updates.
- Dashboard aktualisiert.

---

### Uptime Kuma

Das Monitoring bestätigt die erfolgreiche Wartung.

#### Erwarteter Zustand

| Prüfung | Erwartung |
|---------|-----------|
| Website Status | Up |
| HTTPS Monitor | Erfolgreich |
| Keine Ausfälle | Nach Wartungsende |

#### Ziel

Die Website wird wieder als vollständig verfügbar überwacht.

---

### Abschlusskriterien

Die Wartung gilt als erfolgreich abgeschlossen, wenn alle folgenden Kriterien erfüllt sind.

| Bereich | Erfolgreich |
|---------|-------------|
| Website | Ja |
| WordPress | Ja |
| Docker | Ja |
| LXC | Ja |
| TLS | Ja |
| Home Assistant | Ja |
| TRMNL | Ja |
| Uptime Kuma | Ja |

Erst danach endet das Wartungsfenster.


---

## Rollback

Kann die Verifikation nach einem Update nicht erfolgreich abgeschlossen werden, wird ElseLevy7 vollständig auf den Zustand vor Beginn des Wartungsfensters zurückgesetzt.

Rollback-Maßnahmen erfolgen in der Reihenfolge WordPress → Datenbank → Docker → LXC.

### Rollback-Auslöser

Ein Rollback wird durchgeführt bei:

- Website nicht erreichbar.
- WordPress-Backend nicht erreichbar.
- PHP Fatal Error.
- Plugin verursacht Ausfall.
- Theme verursacht Darstellungsfehler.
- Datenbankfehler.
- Docker-Container starten nicht erfolgreich.

---

### Wiederherstellung der WordPress-Dateien

#### Wiederherzustellende Bereiche

- WordPress-Core.
- `wp-content`.
- Plugins.
- Themes.
- Upload-Verzeichnis.
- Sprachdateien.
- `wp-config.php`.
- weitere Konfigurationsdateien.

#### Ziel

Die Dateistruktur entspricht vollständig dem Stand vor dem Update.

---

### Wiederherstellung des Upload-Verzeichnisses

Das Upload-Verzeichnis wird vollständig zurückgespielt.

#### Enthalten

- Bilder.
- Dokumente.
- Medien.
- Benutzer-Uploads.

#### Ergebnis

Alle Medien stehen wieder vollständig zur Verfügung.

---

### Wiederherstellung der Konfiguration

Folgende Dateien werden wiederhergestellt:

| Datei | Zweck |
|-------|-------|
| `wp-config.php` | Datenbank und WordPress-Konfiguration |
| `.env` | Docker-Konfiguration |
| `.htaccess` | Webserver-Konfiguration (falls verwendet) |

---

### Wiederherstellung der MariaDB-Datenbank

Die Datenbank wird aus dem vor dem Update erstellten Dump wiederhergestellt.

#### Wiederhergestellt werden

- Tabellenstruktur.
- Inhalte.
- Benutzer.
- Optionen.
- Plugin-Konfigurationen.
- Theme-Konfigurationen.

#### Pflichtprüfung

Nach der Wiederherstellung muss WordPress wieder eine erfolgreiche Datenbankverbindung herstellen.

---

### Docker-Compose-Stack wiederherstellen

Nach der Dateiwiederherstellung wird der Docker-Compose-Stack auf den gesicherten Zustand zurückgesetzt.

#### Wiederhergestellt werden

- Compose-Dateien.
- `.env`.
- Container-Konfiguration.
- Netzwerke.
- Volumes.

#### Ziel

Der Stack entspricht exakt dem Zustand vor dem Wartungsfenster.

---

### Docker-Container neu starten

Nach erfolgreicher Wiederherstellung werden die betroffenen Container neu gestartet.

#### Reihenfolge

1. MariaDB.
2. PHP.
3. WordPress.

#### Erwarteter Zustand

Alle Container befinden sich anschließend im Status **running**.

---

### Volumes prüfen

Nach dem Rollback werden die persistenten Volumes geprüft.

#### Erwarteter Zustand

- Daten unverändert vorhanden.
- Uploads vorhanden.
- Datenbankdaten vorhanden.
- Keine leeren Volumes.

---

### Wiederherstellung des LXC-Containers

Falls WordPress oder Docker nicht wiederhergestellt werden können, erfolgt die Wiederherstellung des gesamten LXC-Containers.

#### Wiederherstellungsmöglichkeiten

| Verfahren | Einsatz |
|-----------|---------|
| Proxmox Backup | Vollständige Wiederherstellung |
| LXC Snapshot | Schnelle Rückkehr zum Wartungsbeginn |

#### Voraussetzungen

- Backup erfolgreich vorhanden.
- Snapshot vor Wartungsbeginn erstellt.

#### Grenzen

Ein Snapshot ersetzt keine langfristige Backup-Strategie.

---

### Abschluss nach Rollback

Nach erfolgreichem Rollback erfolgt erneut die vollständige Verifikation.

Pflichtprüfungen:

- Website erreichbar.
- WordPress-Backend erreichbar.
- Docker läuft.
- TLS gültig.
- Home Assistant meldet korrekten Status.
- Uptime Kuma meldet „Up“.

Erst danach gilt der Rollback als abgeschlossen.

---

## Besonderheiten

Dieses Kapitel dokumentiert Homelab-spezifische Eigenschaften der ElseLevy7-Infrastruktur.

### Architektur

ElseLevy7 ist Bestandteil der Docker-Infrastruktur des Homelabs.

#### Aufbau

| Ebene | Komponente |
|-------|------------|
| Proxmox | `pve-01` |
| Virtualisierung | LXC-Container |
| Containerisierung | Docker Compose |
| Anwendung | WordPress |
| PHP | separater Docker-Container |
| Datenbank | MariaDB-Docker-Container |
| Reverse Proxy | `nginx-base` |
| TLS | `mkcert` |

#### Architekturgrundsatz

WordPress läuft vollständig innerhalb eines Docker-Compose-Stacks in einem LXC-Container auf `pve-01`.

Es erfolgt keine Migration des Containers während Wartungsarbeiten.

---

### Infrastruktur-Abhängigkeiten

Für ElseLevy7 sind folgende Komponenten betriebsrelevant:

| Komponente | Funktion |
|------------|----------|
| `pve-01` | LXC-Host |
| Docker im LXC | Laufzeitumgebung |
| nginx-base | Reverse Proxy |
| MariaDB | WordPress-Datenbank |
| PHP | PHP-FPM |
| QNAP TS-464 | Backup-Ziel |
| Home Assistant | Update-Monitoring |
| TRMNL | Anzeige offener Updates |
| Uptime Kuma | Verfügbarkeitsüberwachung |

---

### Backup-Strategie

ElseLevy7 verwendet eine mehrstufige Backup-Strategie.

#### Ebene 1 – WordPress

- WordPress-Dateien.
- Upload-Verzeichnis.
- Plugins.
- Themes.
- Konfiguration.

#### Ebene 2 – Datenbank

- vollständiger MariaDB-Dump,
- Wiederherstellung einzelner Tabellen möglich.

#### Ebene 3 – Docker

- Docker-Compose-Dateien.
- `.env`.
- Container-Konfiguration.

#### Ebene 4 – LXC

- vollständiges Proxmox-LXC-Backup,
- Snapshot unmittelbar vor Wartungsbeginn möglich.

#### Ebene 5 – Zentrales Backup

Alle produktiven Sicherungen werden entsprechend der Homelab-Backup-Strategie auf der **QNAP TS-464** abgelegt.

---

### Verfügbarkeitsstrategie

Für ElseLevy7 gelten folgende Betriebsgrundsätze.

#### Wartungsfenster

Updates erfolgen ausschließlich innerhalb eines geplanten Wartungsfensters.

#### Downtime

Eine kurze Nichtverfügbarkeit während des Updates ist zulässig.

#### Keine Migration

Der LXC-Container verbleibt während der Wartung auf `pve-01`.

Es erfolgt keine Live-Migration innerhalb des Proxmox-Clusters.

---

### Monitoring

Nach Abschluss jeder Wartung erfolgt die Kontrolle über die Monitoring-Systeme.

#### Home Assistant

Kontrolle der Collector-Sensoren:

- `sensor.elselevy7_update_count`
- `sensor.elselevy7_update_summary`

#### TRMNL

Das Homelab-Dashboard darf ElseLevy7 nicht mehr als Update-Kandidat anzeigen.

#### Uptime Kuma

Die Website muss nach Ende des Wartungsfensters wieder den Status **Up** besitzen.

---

### Betriebsgrundsatz

Diese Betriebsreferenz beschreibt ausschließlich den produktiven Wartungs- und Rollback-Prozess der WordPress-Instanz ElseLevy7.

Update-Erkennung, Collector-Logik, TRMNL-Darstellung und Home-Assistant-Automationen werden in separaten Betriebsreferenzen dokumentiert.

