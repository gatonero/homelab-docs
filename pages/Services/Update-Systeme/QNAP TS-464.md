# QNAP TS-464

**Betriebsreferenz V1.2**

Standardisierter Wartungs- und Update-Workflow der produktiven QNAP TS-464 NAS des Homelabs.

---

## Zweck

Diese Betriebsreferenz beschreibt den vollständigen Wartungsprozess der QNAP TS-464 innerhalb des Homelabs.

Sie dokumentiert den produktiven Ablauf für Firmware- und App-Updates sowie alle notwendigen Vorbereitungs-, Verifikations- und Wiederherstellungsschritte.

Die Referenz beantwortet ausschließlich die Frage:

> Wie wird die QNAP TS-464 sicher aktualisiert, verifiziert und bei Bedarf zurückgesetzt?

Nicht Bestandteil dieser Referenz sind:

- Entwicklung oder Änderung des QNAP-Collectors.
- Implementierung neuer Home-Assistant-Sensoren.
- Änderungen am Update-Aggregator.
- Entwicklung neuer Monitoring-Komponenten.

---

## Systemrolle im Homelab

| Eigenschaft | Wert |
|-------------|------|
| Gerät | QNAP TS-464 |
| Betriebssystem | QTS |
| Rolle | Zentraler Storage-Server |
| Datenbasis | RAID10 |
| Dateidienste | NFS und SMB/Samba |
| Snapshot-Unterstützung | Ja |
| Konfigurationsbackup | Ja |
| Home-Assistant-Integration | QNAP Update Collector |

Die QNAP TS-464 stellt produktive Speicher für nahezu alle Homelab-Dienste bereit und besitzt dadurch zentrale Bedeutung für die Infrastruktur.

---

## Auslöser (TRMNL-Update-Instanz)

Die Wartung wird ausschließlich ausgelöst, wenn der zentrale Update-Aggregator der Home-Assistant-Installation neue QNAP-Updates meldet.

### Primäre Anzeige

TRMNL → Homelab → Updates

### Collector-Sensoren

- sensor.qnap_update_count
- sensor.qnap_update_summary

### Auslöserbedingungen

Ein Wartungsfenster wird eröffnet, wenn mindestens eine der folgenden Bedingungen erfüllt ist.

| Bedingung | Bedeutung |
|-----------|-----------|
| qnap_update_count größer 0 | Mindestens ein Update verfügbar. |
| qnap_update_summary nicht leer | Firmware oder App-Updates vorhanden. |
| Manuelle Wartung geplant | Geplantes Wartungsfenster. |

### Kein Auslöser

Folgende Situationen führen nicht automatisch zu einer Wartung.

- Snapshot-Erstellung.
- SMART-Test.
- RAID-Scrubbing.
- Storage-Scrubbing.
- Snapshot-Replikation.
- Backup-Läufe.

Diese Jobs werden vor einer Wartung lediglich berücksichtigt.

---

## Datenquelle (Collector)

### Home Assistant

Die Betriebsreferenz verwendet ausschließlich die vorhandenen Collector-Sensoren.

| Sensor | Verwendung |
|--------|------------|
| sensor.qnap_update_count | Anzahl verfügbarer Updates. |
| sensor.qnap_update_summary | Zusammenfassung der verfügbaren Updates. |

### Verantwortlichkeit

Der Collector übernimmt ausschließlich die Erkennung.

Die Durchführung der Wartung erfolgt vollständig in QTS.

### Verifikation in Home Assistant

Die Sensoren werden ausschließlich über die Entwicklerwerkzeuge geprüft.

Erwarteter Zustand vor Beginn:

- qnap_update_count größer 0.
- qnap_update_summary enthält mindestens einen Eintrag.

---

## Vorbedingungen

Vor jedem Firmware- oder App-Update müssen sämtliche Vorbedingungen erfüllt sein.

Ein Update beginnt erst nach erfolgreicher Prüfung aller Punkte.

---

### 1. Wartungsfenster

Ein Wartungsfenster wird geplant.

Zu dokumentieren sind:

- Datum.
- Uhrzeit.
- Erwartete Dauer.
- Betroffene Dienste.
- Geplante Neustarts.

Empfehlung:

- Keine parallelen Infrastrukturarbeiten.
- Keine laufenden Backups.
- Keine VM-Migrationen.

---

### 2. Konfigurationsbackup erstellen

Vor jedem Firmware-Update wird ein aktuelles QTS-Konfigurationsbackup erstellt.

Pfad:

Systemsteuerung → Sicherung/Wiederherstellung → Systemeinstellungen sichern

Das Backup wird außerhalb der NAS archiviert.

Empfohlene Ablage:

- Dokumentensicherung.
- Administrationsbackup.
- Versioniert.

Zu dokumentieren:

| Prüfschritt | Erwartung |
|-------------|-----------|
| Backup erstellt | Ja |
| Backup erfolgreich exportiert | Ja |
| Sicher gespeichert | Ja |

---

### 3. RAID prüfen

Vor jedem Update wird der RAID-Zustand geprüft.

Speicher & Snapshots → Speicher/Snapshots

Erwarteter Zustand:

| Prüfschritt | Erwartung |
|-------------|-----------|
| RAID10 | Healthy |
| Alle Datenträger | Online |
| Keine Warnungen | Ja |
| Keine Degradierung | Ja |

Ein Firmware-Update wird niemals während eines degradieren RAID durchgeführt.

---

### 4. Speicherpool prüfen

Der Speicherpool muss vollständig verfügbar sein.

Zu prüfen:

- Speicherpool online.
- Volume online.
- Keine Inkonsistenzen.
- Keine Warnungen.

Erwartung:

Storage Pool = Healthy.

---

### 5. SMART-Status aller Festplatten

Alle Festplatten erhalten eine SMART-Prüfung.

Zu kontrollieren:

- Gesundheitsstatus.
- Temperatur.
- Fehler.
- Warnungen.

Erwartung:

Alle Datenträger melden Good.

Ein Update wird nicht begonnen, wenn SMART Warnungen oder Fehler vorliegen.

---

### 6. Laufende Hintergrundjobs prüfen

Vor Beginn dürfen keine Storage-Jobs aktiv sein.

Zu prüfen:

- RAID Scrubbing.
- Speicherpool Scrubbing.
- Rebuild.
- Snapshot-Erstellung.
- Snapshot-Replikation.
- Volume-Prüfung.

Erwartung:

Keine laufenden Jobs.

---

### 7. Snapshot-Situation prüfen

Vor Firmware-Updates wird die Snapshot-Situation dokumentiert.

Zu prüfen:

- Letzte Snapshots vorhanden.
- Snapshot-Speicher ausreichend.
- Replikationen abgeschlossen.

Hinweis:

Snapshots ersetzen kein Konfigurationsbackup.

---

### 8. Abhängige Dienste identifizieren

Die NAS stellt zentrale Infrastruktur bereit.

Vor der Wartung werden alle produktiven Verbraucher identifiziert.

#### NFS-Abhängigkeiten

- Proxmox Storage.
- Docker VM.
- Backup-Ziele.

#### SMB-Abhängigkeiten

- Jellyfin Medienbibliothek.
- Administrationsfreigaben.
- Dokumentenfreigaben.

#### Home Assistant

- Backup-Ziel.
- QNAP Collector.
- Monitoring.

Während des Neustarts sind diese Dienste nicht verfügbar.

---

### 9. Kritische Anwendungen prüfen

Vor Firmware-Updates werden produktive QNAP-Anwendungen identifiziert.

Beispiele:

- Hybrid Backup Sync.
- Snapshot Replica.
- Multimedia Console.
- Container Station.
- QVPN.
- File Station.

App-Updates werden nach erfolgreichem Firmware-Update durchgeführt.

---

### 10. Produktive Zugriffe beenden

Vor dem Neustart werden produktive Schreibzugriffe beendet.

Zu prüfen:

- Keine laufenden Dateiübertragungen.
- Keine SMB-Kopiervorgänge.
- Keine NFS-Schreibvorgänge.
- Keine laufenden Sicherungen.
### 11. Wartungsmodus vorbereiten

Vor dem Firmware-Update werden alle administrativen Voraussetzungen geschaffen.

Empfehlung:

- Administrationszugang testen.
- Zweiten Browser oder SSH-Zugang bereithalten.
- Stromversorgung der NAS sicherstellen (USV empfohlen).
- Keine geplanten Neustarts anderer Infrastrukturkomponenten während der Wartung.

---

## Durchführung

Die Durchführung erfolgt ausschließlich über die produktive QTS-Weboberfläche.

Es wird zuerst die Firmware aktualisiert und anschließend die installierten QNAP-Anwendungen.

---

### Ablaufübersicht

| Reihenfolge | Aktion |
|-------------|--------|
| 1 | Firmware-Kompatibilität prüfen |
| 2 | Firmware installieren |
| 3 | NAS-Neustart abwarten |
| 4 | Systemdienste prüfen |
| 5 | App-Updates installieren |
| 6 | Optional zweiten Neustart durchführen |
| 7 | Vollständige Verifikation durchführen |

---

### 1. Firmware-Kompatibilität prüfen

Vor der Installation wird geprüft:

- Aktuelle QTS-Version.
- Zielversion.
- Veröffentlichungsinformationen.
- Bekannte Einschränkungen.
- Unterstützte Hardware.

Zu dokumentieren:

| Prüfschritt | Erwartung |
|-------------|-----------|
| TS-464 unterstützt Firmware | Ja |
| Keine bekannte Inkompatibilität | Ja |
| RAID kompatibel | Ja |

Firmware wird ausschließlich aus der offiziellen QTS-Aktualisierung installiert.

---

### 2. Firmware installieren

Pfad:

Systemsteuerung → Firmware-Aktualisierung

Durchführung:

1. Nach Updates suchen.
2. Zielversion auswählen.
3. Versionshinweise prüfen.
4. Installation starten.

Während der Installation:

- Browser nicht schließen.
- NAS nicht ausschalten.
- Netzwerkverbindung nicht unterbrechen.

---

### 3. Neustart der NAS

Nach erfolgreicher Installation startet die NAS automatisch neu.

Währenddessen sind nicht verfügbar:

- Weboberfläche.
- SMB.
- NFS.
- AFP (falls aktiviert).
- SSH (vorübergehend).

Erwarteter Zustand:

Die NAS startet vollständig ohne Benutzereingriff.

---

### 4. Ersten Systemstart abwarten

Nach dem Neustart wird gewartet bis:

- Login möglich.
- CPU-Auslastung normalisiert.
- Hintergrunddienste gestartet.
- Speicherpool eingebunden.

Empfehlung:

Einige Minuten warten, bevor weitere Prüfungen beginnen.

---

### 5. Systemdienste prüfen

Nach dem Neustart werden die Kernkomponenten geprüft.

Zu prüfen:

- Speicher & Snapshots.
- Netzwerk & virtuelle Switches.
- Dateidienste.
- Benutzerfreigaben.
- Freigabeordner.

Erwartung:

Alle Dienste aktiv.

---

### 6. QNAP-App-Updates durchführen

Nach erfolgreicher Firmware werden App-Updates installiert.

Pfad:

App Center

Empfohlene Reihenfolge:

1. Systemnahe Anwendungen.
2. Backup-Anwendungen.
3. Multimedia-Anwendungen.
4. Sonstige Anwendungen.

Zwischen einzelnen Updates werden Fehlermeldungen kontrolliert.

---

### 7. Optional erforderlicher zweiter Neustart

Einige App-Updates verlangen einen weiteren Neustart.

Beispiele:

- Kernel-nahe Komponenten.
- Netzwerkdienste.
- Dateidienste.
- Virtualization-Komponenten.

Erwartung:

Nur durchführen, wenn QTS dies ausdrücklich verlangt.

---

### 8. Abschluss der Wartung

Nach Installation aller Updates:

- Keine offenen Updates.
- Keine Neustartaufforderung.
- Keine Warnungen im Benachrichtigungszentrum.

Die Wartung geht anschließend in die Verifikation über.

---

## Verifikation

Die Verifikation ist verpflichtender Bestandteil jeder Wartung.

Erst wenn alle Prüfpunkte erfolgreich sind, gilt das Update als abgeschlossen.

### Übersicht

| Bereich | Muss geprüft werden |
|--------|----------------------|
| NAS | Ja |
| RAID | Ja |
| Speicherpool | Ja |
| SMART | Ja |
| NFS | Ja |
| SMB | Ja |
| Proxmox | Ja |
| Docker VM | Ja |
| Jellyfin | Ja |
| Home Assistant | Ja |
| Uptime Kuma | Ja |

---

### 1. NAS erreichbar

Zu prüfen:

- Weboberfläche erreichbar.
- Anmeldung möglich.
- Systeminformationen sichtbar.

Erwartung:

NAS vollständig betriebsbereit.

---

### 2. RAID erneut prüfen

Kontrolle:

Speicher & Snapshots

Erwartung:

| Prüfschritt | Erwartung |
|-------------|-----------|
| RAID10 | Healthy |
| Datenträger | Online |
| Keine Warnungen | Ja |
| Kein Rebuild | Ja |

---

### 3. Speicherpool prüfen

Kontrolle:

- Pool online.
- Volume online.
- Freier Speicher plausibel.
- Snapshot-Bereich verfügbar.

Erwartung:

Keine Inkonsistenzen.

---

### 4. SMART erneut prüfen

Alle Datenträger erneut kontrollieren.

Erwartung:

- Status Good.
- Keine neuen Fehler.
- Temperaturen plausibel.

---

### 5. NFS-Dienste prüfen

Die NFS-Freigaben müssen wieder verfügbar sein.

Zu prüfen:

- Exportierte Freigaben vorhanden.
- Freigaben aktiv.
- Berechtigungen unverändert.

Erwartung:

Alle produktiven NFS-Dienste verfügbar.### 6. SMB-/Samba-Dienste prüfen

Die SMB-Freigaben müssen nach dem Neustart vollständig verfügbar sein.

Zu prüfen:

- Microsoft-Netzwerkdienst aktiv.
- Freigaben sichtbar.
- Benutzerberechtigungen unverändert.
- Freigaben schreib- und lesbar.

Erwartung:

Alle produktiven SMB-Freigaben sind wieder erreichbar.

---

### 7. Proxmox-NFS-Verbindungen prüfen

Die QNAP TS-464 stellt den produktiven NFS-Storage für die Proxmox-Hosts bereit.

Zu prüfen:

- Storage **TS-464-nfs** ist online.
- Keine Storage-Warnungen in Proxmox.
- Alle Datastores erreichbar.
- VM-Backups sichtbar.

Erwartung:

Alle Proxmox-Hosts können den NFS-Storage wieder nutzen.

---

### 8. Docker-VM-NFS-Verbindungen prüfen

Die Docker-VM verwendet produktive NFS-Freigaben der NAS.

Zu prüfen:

- Alle NFS-Mounts vorhanden.
- Freigaben lesbar.
- Freigaben beschreibbar.
- Container mit NFS-Volumes funktionieren.

Erwartung:

Keine Mount-Fehler.

---

### 9. Jellyfin-SMB-Medienbibliothek prüfen

Jellyfin verwendet eine SMB-/Samba-Freigabe der QNAP TS-464 als Medienbibliothek.

Während des NAS-Neustarts ist diese Bibliothek nicht erreichbar.

Nach Abschluss der Wartung wird geprüft:

| Prüfschritt | Erwartung |
|-------------|-----------|
| SMB-Freigabe erreichbar | Ja |
| Jellyfin startet ohne Fehler | Ja |
| Medienbibliothek eingebunden | Ja |
| Bibliotheken sichtbar | Ja |
| Medien abspielbar | Ja |

Besonderheit:

Falls Jellyfin vor der NAS startet, kann der SMB-Mount kurzfristig fehlen.

In diesem Fall wird geprüft, ob der Mount automatisch wiederhergestellt wurde.

---

### 10. Home Assistant prüfen

Nach Abschluss der Wartung werden die Collector-Sensoren kontrolliert.

Erwarteter Zustand:

| Sensor | Erwartung |
|--------|-----------|
| sensor.qnap_update_count | 0 |
| sensor.qnap_update_summary | Keine Updates |

TRMNL zeigt anschließend keine offenen QNAP-Updates mehr.

---

### 11. Monitoring prüfen

Uptime Kuma ist die zentrale Monitoring-Instanz.

Zu prüfen:

- NAS erreichbar.
- SMB-Monitor grün.
- NFS-Monitor grün.
- Backup-Dienste grün.
- Keine dauerhaften Ausfälle.

Erwartung:

Alle produktiven Monitore melden **UP**.

---

### 12. Abschlusskontrolle

Die Wartung gilt als erfolgreich abgeschlossen, wenn alle Prüfpunkte erfüllt sind.

Checkliste:

- Firmware aktuell.
- Apps aktuell.
- RAID Healthy.
- Speicherpool Healthy.
- SMART unverändert.
- NFS verfügbar.
- SMB verfügbar.
- Jellyfin funktioniert.
- Home Assistant meldet keine Updates.
- Uptime Kuma ohne Fehler.

---

## Rollback

Ein Rollback wird nur durchgeführt, wenn die Wartung zu einem produktiven Fehler führt.

Vor jedem Rollback wird die Ursache dokumentiert.

---

### Rollback-Strategie

| Fehlerbild | Maßnahme |
|------------|----------|
| Firmwarefehler | Firmware-Rollback, sofern unterstützt |
| Konfigurationsfehler | Konfigurationsbackup wiederherstellen |
| Dateifreigaben fehlen | Dienste wiederherstellen |
| Datenfehler | Snapshot wiederherstellen |
| Volumefehler | Storage wiederherstellen |

---

### 1. Firmware-Rollback

QNAP unterstützt Firmware-Rollbacks nur eingeschränkt.

Voraussetzungen:

- Passende ältere Firmware verfügbar.
- Hardware unterstützt Downgrade.
- Versionshinweise erlauben Rückkehr.

Grenzen:

Nicht jede Firmware kann auf eine ältere Version zurückgesetzt werden.

Vor einem Rollback wird geprüft:

- Kompatibilität.
- Downgrade-Hinweise.
- Datenmigrationen.

---

### 2. Wiederherstellung des QTS-Konfigurationsbackups

Falls Konfigurationen beschädigt wurden:

Pfad:

Systemsteuerung → Sicherung/Wiederherstellung → Systemeinstellungen wiederherstellen

Wiederhergestellt werden beispielsweise:

- Benutzer.
- Gruppen.
- Netzwerk.
- Freigaben.
- Dienste.
- Systemoptionen.

Nicht ersetzt werden Benutzerdaten auf den Volumes.

---

### 3. Snapshot-Wiederherstellung

Snapshots dienen der Wiederherstellung von Dateisystemzuständen.

Einsatzfälle:

- Fehlgeschlagenes App-Update.
- Gelöschte Dateien.
- Beschädigte Freigaben.
- Fehlerhafte Konfiguration innerhalb eines Volumes.

Grenzen:

Snapshots ersetzen keine Firmware.

---

### 4. Speicherpool-Wiederherstellung

Bei Problemen mit dem Storage:

- Speicherpool prüfen.
- Volume aktivieren.
- Dateisystem prüfen.
- Snapshot-Metadaten prüfen.

Erwartung:

Volumes bleiben unverändert.

---

### 5. Wiederherstellung der NFS-Dienste

Falls NFS nicht verfügbar ist:

Zu prüfen:

- NFS-Dienst aktiv.
- Exportierte Freigaben vorhanden.
- Berechtigungen korrekt.
- Netzwerkfreigaben aktiv.

Anschließend werden die abhängigen Systeme erneut geprüft.

---

### 6. Wiederherstellung der SMB-Dienste

Falls SMB nicht verfügbar ist:

Zu prüfen:

- SMB aktiviert.
- Arbeitsgruppe unverändert.
- Freigaben vorhanden.
- Berechtigungen vorhanden.

Danach erfolgt die Prüfung der SMB-Clients.

---

### 7. Wiederherstellung der Jellyfin-Medienbibliothek

Nach SMB-Problemen wird Jellyfin geprüft.

Kontrollpunkte:

- SMB-Mount vorhanden.
- Medienpfade vorhanden.
- Bibliotheken erreichbar.
- Bibliotheksscan erfolgreich.

Falls erforderlich:

- SMB-Mount erneut verbinden.
- Jellyfin-Dienst neu starten.
- Bibliothek erneut scannen.

Ziel:

Keine fehlenden Medienordner.## Besonderheiten

Die QNAP TS-464 ist der zentrale Storage-Server des Homelabs.

Ein Firmware-Neustart betrifft mehrere produktive Systeme gleichzeitig.

---

### Homelab-Rolle der NAS

Die NAS stellt folgende produktive Funktionen bereit.

| Funktion | Bedeutung |
|----------|-----------|
| RAID10 | Produktive Datenbasis |
| NFS | Storage für Proxmox und Docker VM |
| SMB/Samba | Medienbibliothek und Freigaben |
| Backup-Ziel | Home Assistant Backups |
| Snapshots | Wiederherstellung von Datenständen |

Dadurch besitzt die NAS eine zentrale Infrastrukturrolle.

---

### RAID10 als produktive Datenbasis

Das RAID10 stellt die Datensicherheit während des normalen Betriebs sicher.

Wichtige Hinweise:

- RAID ersetzt kein Backup.
- RAID ersetzt keine Snapshots.
- Firmware-Updates erfolgen ausschließlich bei Healthy-Status.

---

### NFS-Abhängigkeiten

Von NFS abhängig sind:

- Proxmox-Hosts.
- Docker-VM.
- VM-Backups.
- Container mit NFS-Volumes.

Während eines NAS-Neustarts stehen diese Freigaben nicht zur Verfügung.

---

### SMB-Abhängigkeiten

SMB wird produktiv verwendet durch:

- Jellyfin.
- Administrationsfreigaben.
- Dokumentenspeicher.
- Weitere SMB-Clients.

Während des Neustarts sind SMB-Freigaben vollständig nicht erreichbar.

---

### Besonderheit Jellyfin

Jellyfin verwendet eine SMB-Freigabe der NAS als Medienbibliothek.

Auswirkungen eines NAS-Neustarts:

| Zustand | Auswirkung |
|---------|------------|
| NAS startet neu | Medienbibliothek nicht erreichbar |
| SMB beendet | Bibliotheken kurzfristig offline |
| NAS wieder online | SMB-Mount wird erneut verfügbar |

Nach jedem NAS-Update wird Jellyfin ausdrücklich geprüft.

---

### Home Assistant als Backup-Ziel

Home Assistant speichert produktive Backups auf der NAS.

Während eines NAS-Neustarts:

- Backup-Ziel kurzfristig nicht erreichbar.
- Laufende Backups dürfen nicht aktiv sein.
- Nach Abschluss wird die Backup-Erreichbarkeit geprüft.

---

### Snapshot-Strategie

Snapshots dienen ausschließlich der Wiederherstellung innerhalb der NAS.

Empfehlungen:

- Snapshots regelmäßig erstellen.
- Snapshots vor größeren Firmware-Updates prüfen.
- Snapshot-Replikationen vor Wartungen abschließen.

---

### Auswirkungen eines NAS-Neustarts

#### Proxmox

Während des Neustarts:

- NFS-Storage offline.
- Keine Backups.
- Keine neuen VM-Starts auf NFS-Storage.

#### Docker VM

Während des Neustarts:

- NFS-Mounts kurzfristig nicht verfügbar.
- Container mit NFS-Volumes können Fehler melden.

#### Home Assistant

Während des Neustarts:

- Backup-Ziel offline.
- Collector kurzfristig ohne Verbindung.

Nach Wiederanlauf:

- Sensoren aktualisieren sich automatisch.

#### Jellyfin

Während des Neustarts:

- SMB-Bibliothek offline.
- Medien können nicht abgespielt werden.

Nach Wiederanlauf:

- SMB-Verbindung prüfen.
- Medienbibliothek verifizieren.

---

### Empfohlene Wiederanlaufreihenfolge

Nach erfolgreichem NAS-Update wird die Infrastruktur in folgender Reihenfolge geprüft.

| Reihenfolge | System |
|-------------|--------|
| 1 | QNAP vollständig gestartet |
| 2 | RAID und Speicherpool Healthy |
| 3 | NFS-Dienste aktiv |
| 4 | SMB-Dienste aktiv |
| 5 | Proxmox-Storage erreichbar |
| 6 | Docker-VM-Mounts erreichbar |
| 7 | Jellyfin-Medienbibliothek erreichbar |
| 8 | Home Assistant Backup-Ziel erreichbar |
| 9 | Home Assistant Collector meldet keine Updates |
| 10 | Uptime Kuma meldet alle Dienste UP |

Diese Reihenfolge minimiert Folgefehler durch nicht verfügbare Speicherfreigaben.

---

## Abschluss der Wartung

Die Wartung gilt als erfolgreich abgeschlossen, wenn:

- Firmware erfolgreich installiert wurde.
- Alle App-Updates installiert wurden.
- Keine Neustarts mehr ausstehen.
- Alle Verifikationsprüfungen erfolgreich waren.
- Home Assistant keine offenen QNAP-Updates mehr meldet.
- TRMNL keine offenen QNAP-Updates mehr anzeigt.
- Uptime Kuma alle produktiven Dienste als erreichbar meldet.

Damit ist der standardisierte Wartungs- und Update-Workflow der QNAP TS-464 abgeschlossen.

