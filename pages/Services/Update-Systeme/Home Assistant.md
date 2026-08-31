# Home Assistant

**Betriebsreferenz V1.0**

Standardisierter Wartungs- und Update-Workflow der Home-Assistant-VM des Homelabs.

---

## Zweck

Diese Betriebsreferenz beschreibt den produktiven Wartungsprozess der Home-Assistant-VM innerhalb des Homelabs.

Die Referenz beantwortet ausschließlich die Frage:

> Wie wird Home Assistant sicher aktualisiert, verifiziert und bei Bedarf zurückgesetzt?

Die Update-Erkennung erfolgt bereits durch den bestehenden Home-Assistant-Collector. Diese Referenz beschreibt ausschließlich die Durchführung eines Updates.

---

## Auslöser (TRMNL-Update-Instanz)

Der Wartungsprozess beginnt, wenn die TRMNL-Update-Seite oder das Homelab-Dashboard offene Home-Assistant-Updates meldet.

Verwendete Sensoren:

| Sensor | Bedeutung |
|--------|-----------|
| `sensor.ha_update_count` | Anzahl verfügbarer Home-Assistant-Updates. |
| `sensor.ha_update_summary` | Zusammenfassung der verfügbaren Updates. |

Regel:

- `sensor.ha_update_count = 0` → kein Wartungsbedarf.
- `sensor.ha_update_count > 0` → Wartungsworkflow starten.

Es werden keine weiteren Scanner oder REST-Abfragen verwendet.

---

## Datenquelle (Collector)

Die Update-Informationen stammen ausschließlich vom bestehenden Home-Assistant-Collector.

Verwendete Entitäten:

| Entität | Verwendung |
|---------|------------|
| `sensor.ha_update_count` | Wartungsentscheidung. |
| `sensor.ha_update_summary` | Anzeige der verfügbaren Updates auf Dashboard und TRMNL. |

Die Sensoren werden ausschließlich gelesen.

Es werden keine neuen Sensoren, Template-Sensoren oder REST-Collector erstellt.

---

## Vorbedingungen

Vor jedem produktiven Update sind folgende Bedingungen verpflichtend.

### Backup

Vor Beginn muss ein aktuelles Home-Assistant-Backup vorhanden sein.

Voraussetzungen:

- Backup Manager erfolgreich ausgeführt.
- Backup auf NAS verfügbar.
- Proxmox-Backup der VM erfolgreich vorhanden.

Es wird kein Update ohne aktuelles Backup durchgeführt.

### Wartungsfenster

Das Update erfolgt ausschließlich innerhalb eines geplanten Wartungsfensters.

Empfehlungen:

- Keine laufenden Automationen mit kritischen Auswirkungen.
- Keine aktive Wartung weiterer Homelab-Systeme.
- TRMNL kann während des Neustarts kurzfristig veraltete Daten anzeigen.

### Integrationen prüfen

Vor Beginn werden Integrationen mit Reparaturbedarf kontrolliert.

Prüfung:

- Einstellungen → System → Reparaturen.
- Keine offenen Reparaturen mit Einfluss auf Core oder Supervisor.

### Systemgesundheit prüfen

Vor jedem Update muss die Konfiguration gültig sein.

SSH-/BusyBox:

```sh
ha core check
```

Erwartung:

- `Command completed successfully.`

Nur bei erfolgreicher Prüfung wird der Update-Prozess begonnen.

---

## Durchführung

Die Update-Reihenfolge ist verbindlich.

### Reihenfolge

1. Home Assistant Core
2. Supervisor
3. Add-ons
4. Home Assistant Operating System

Diese Reihenfolge minimiert Versionskonflikte.

### Schritt 1 — Home Assistant Core

Core über die Home-Assistant-Oberfläche aktualisieren.

Während des Updates startet Home Assistant automatisch neu.

Keine manuellen Neustarts durchführen.

### Schritt 2 — Supervisor

Nach erfolgreichem Core-Update Supervisor aktualisieren.

Anschließend warten, bis Supervisor vollständig gestartet ist.

### Schritt 3 — Add-ons

Alle verfügbaren Add-on-Updates installieren.

Besonders relevante Add-ons des Homelabs:

- Zigbee2MQTT
- Backup Manager
- TRMNL Add-on
- Music Assistant (falls installiert)
- Weitere produktive Add-ons

Nach jedem Add-on warten, bis der Status **Gestartet** erreicht ist.

### Schritt 4 — Home Assistant Operating System

Falls verfügbar, anschließend das Betriebssystem aktualisieren.

Nach Abschluss erfolgt der notwendige Neustart automatisch.

Keine zusätzlichen Neustarts auslösen.

---

## Verifikation

Nach Abschluss aller Updates wird das System vollständig geprüft.

### 1. Konfiguration prüfen

SSH-/BusyBox:

```sh
ha core check
```

Erwartung:

- Erfolgreiche Prüfung ohne Fehler.

### 2. Erreichbarkeit

Prüfen:

- Home Assistant Weboberfläche erreichbar.
- Anmeldung möglich.
- Dashboard lädt vollständig.

### 3. Add-ons

Prüfen:

- Alle produktiven Add-ons laufen.
- Keine Add-ons im Fehlerzustand.

Besonders prüfen:

- Zigbee2MQTT
- Backup Manager
- TRMNL Add-on

### 4. Update-Collector

Entwicklerwerkzeuge → Template.

Prüfen:

- `sensor.ha_update_count`
- `sensor.ha_update_summary`

Erwartung:

- `sensor.ha_update_count = 0`
- `sensor.ha_update_summary` enthält keine offenen Updates.

### 5. Dashboard und TRMNL

Prüfen:

- Dashboard „Homelab Status“ wird korrekt dargestellt.
- Screenshot-Rendering funktioniert.
- TRMNL aktualisiert die Seite erfolgreich.
- Homelab-Karte zeigt aktuelle Werte.

### 6. Kritische Integrationen

Folgende Integrationen werden geprüft.

| Integration | Erwartung |
|-------------|-----------|
| Zigbee2MQTT | Geräte erreichbar. |
| FRITZ!Box | Verbindung aktiv. |
| Backup Manager | Integration geladen. |
| Kalender | Kalenderdaten vorhanden. |
| TRMNL | Dashboard aktualisiert. |
| Wetter | Sensoren aktualisiert. |
| AdGuard | DNS-Daten vorhanden. |

### 7. Systemzustand

Prüfen:

- Keine offenen Reparaturen.
- Keine Fehlermeldungen im Systemprotokoll.
- Systemstatus normal.

---

## Rollback

Rollback wird ausschließlich durchgeführt, wenn die Verifikation fehlschlägt oder ein produktiver Fehler auftritt.

### Variante 1 — Home-Assistant-Backup

Voraussetzungen:

- Aktuelles Backup vorhanden.
- Backup wurde vor Beginn erstellt.

Ablauf:

1. Wiederherstellung über Backup Manager.
2. Backup auswählen.
3. Vollständige Wiederherstellung durchführen.
4. Neustart von Home Assistant.

Diese Variante stellt Konfiguration, Integrationen und Daten wieder her.

### Variante 2 — Proxmox-Backup

Verwendung:

- Home Assistant startet nicht.
- Supervisor nicht funktionsfähig.
- Betriebssystem beschädigt.

Ablauf:

1. VM in Proxmox stoppen.
2. Letztes erfolgreiches Backup auswählen.
3. Wiederherstellen.
4. VM starten.

Diese Variante stellt die vollständige VM wieder her.

### Variante 3 — Proxmox-Snapshot

Snapshots können vor einem größeren Versionssprung verwendet werden.

Hinweise:

- Nur kurzfristig verwenden.
- Snapshot nach erfolgreicher Verifikation wieder entfernen.
- Snapshots ersetzen kein Backup.

### Grenzen eines Rollbacks

Rollback kann folgende Daten verlieren:

- Änderungen seit Erstellung des Backups.
- Neue Automationen.
- Neue Geräte.
- Historische Daten seit Backup-Zeitpunkt.

Deshalb immer Backup unmittelbar vor dem Update erstellen.

---

## Besonderheiten

### Home Assistant OS auf Proxmox

Die produktive Instanz läuft als virtuelle Maschine auf Proxmox.

Backups erfolgen zusätzlich über die Proxmox-Backup-Strategie des Homelabs.

### Packages-Architektur

Die Konfiguration verwendet Packages unter:

`/config/packages/`

Updates dürfen die Package-Struktur nicht verändern.

Nach jedem Update muss die Konfiguration weiterhin erfolgreich geprüft werden.

### Template-Sensoren

Template-Sensoren werden ausschließlich über Entwicklerwerkzeuge → Template geprüft.

Keine Statusprüfung über Supervisor-CLI.

### Dashboard-Rendering

Das Dashboard „Homelab Status“ dient als Quelle für:

- Browser-Dashboard.
- TRMNL-Screenshot.
- Statusdarstellung der Homelab-Karte.

Nach jedem Update muss das Rendering vollständig funktionieren.

### TRMNL-Integration

TRMNL verwendet die bestehenden Dashboard-Daten.

Zu prüfen:

- Screenshot aktuell.
- Webhook erfolgreich.
- Anzeige vollständig.

### Backup-Strategie

Die Home-Assistant-VM ist Bestandteil der Homelab-Backup-Strategie.

Sicherungsebenen:

| Ebene | Zweck |
|-------|------|
| Backup Manager | Home-Assistant-Wiederherstellung. |
| NAS | Zentrale Speicherung. |
| Proxmox Backup | Vollständige VM-Wiederherstellung. |
| Snapshot | Kurzfristige Absicherung vor größeren Updates. |

Ein Update gilt erst als abgeschlossen, wenn Backup, Verifikation und Integrationsprüfung erfolgreich abgeschlossen wurden.

---

## Abschlusskriterien

Ein Home-Assistant-Update ist erfolgreich abgeschlossen, wenn alle folgenden Bedingungen erfüllt sind:

- `ha core check` erfolgreich.
- Home Assistant erreichbar.
- Alle produktiven Add-ons gestartet.
- `sensor.ha_update_count = 0`.
- Dashboard funktioniert.
- TRMNL zeigt aktuelle Daten.
- Kritische Integrationen arbeiten fehlerfrei.
- Keine offenen Reparaturen mit Bezug zum Update.

Erst danach gilt der Wartungsworkflow als abgeschlossen.
