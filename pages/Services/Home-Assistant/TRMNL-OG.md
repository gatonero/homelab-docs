# TRMNL Dashboard – Golden Reference

Stand: 26.08.2026

---

## Zweck

Dieses Dokument beschreibt die produktive TRMNL-Integration des Homelabs.

Schwerpunkte:

- Home Assistant Dashboard für TRMNL OG.
- INFRA- und HOMELAB-Statuslogik.
- HBS3-Integration von der QNAP TS-464.
- Testbench für reproduzierbare Abnahmetests.
- Wartungsregeln.

---

# Architektur

## Datenfluss

QNAP TS-464 (HBS3)
        │
        │ hbs3-status.json
        ▼
HTTP-Server Port 18080
        │
        ▼
REST Sensor sensor.hbs3_backup_raw
        │
        ▼
Template Sensoren
        │
        ├── sensor.hbs3_backup_age_hours
        ├── sensor.hbs3_backup_status
        └── sensor.hbs3_backup_message
        │
        ▼
INFRA Message Sensoren
        │
        ▼
TRMNL Dashboard

---

# Dashboard-Struktur

## TRMNL OG View

Verzeichnis:

/config/trmnl/views/trmnl-og.yaml

Enthält folgende Karten:

1. homelab-og.yaml
2. infra-og.yaml
3. weather-og.yaml
4. calendar-og.yaml
5. renault-og.yaml
6. updates-og.yaml

Alle Karten liegen unter:

/config/trmnl/cards/

---

# INFRA Card

## Priorität

1. Netzwerk ERROR
2. HBS3 Backup ERROR
3. Speicher ERROR
4. HBS3 Backup WARN
5. Speicher WARN
6. Infrastruktur betriebsbereit

## Sensoren

- sensor.network_status
- sensor.storage_status
- sensor.storage_free_percent
- sensor.hbs3_backup_status
- sensor.hbs3_backup_age_hours

## Ausgabe

sensor.infra_message_1
sensor.infra_message_2
sensor.infra_message_3
sensor.infra_message_4

---

# HOMELAB Card

## Priorität

1. HA Backup ERROR
2. HA Health ERROR
3. Zigbee2MQTT offline
4. HA Backup WARN
5. HA Health WARN
6. Home Assistant betriebsbereit

## Sensoren

- sensor.ha_backup_status
- sensor.ha_backup_age_hours
- sensor.ha_health_status
- sensor.ha_health_percent
- sensor.ha_services_status

## Ausgabe

sensor.homelab_message_1
sensor.homelab_message_2
sensor.homelab_message_3
sensor.homelab_message_4

---

# HBS3 Integration (TS-464)

## Produktive Dateien

/share/CACHEDEV1_DATA/Public/hbs3-status-update.sh

/share/CACHEDEV1_DATA/Public/hbs3-status.json

/share/CACHEDEV1_DATA/Public/hbs3-webserver.sh

## HTTP-Endpunkt

http://TS464:18080/hbs3-status.json

## JSON-Format

{
  "job_id": "...",
  "timestamp": 1787702521.594933,
  "human_time": "2026-08-26T00:02:01.594933Z",
  "status": "success"
}

---

# Cronjob (Golden Reference)

0 */4 * * * /share/CACHEDEV1_DATA/Public/hbs3-status-update.sh >/dev/null 2>&1

Eigenschaften:

- idempotent
- geringe Last
- unabhängig vom exakten Backup-Ende
- maximale Aktualisierungsverzögerung vier Stunden

---

# Testbench

## INFRA Testbench

Package:

/config/packages/infra_testbench.yaml

Hilfsentitäten:

- input_boolean.infra_test_mode
- input_text.infra_test_network_status
- input_text.infra_test_hbs3_status
- input_number.infra_test_hbs3_age_hours
- input_text.infra_test_storage_status
- input_number.infra_test_storage_free_percent

## HOMELAB Testbench

Package:

/config/packages/homelab_test.yaml

Hilfsentitäten:

- input_boolean.homelab_test_mode
- input_text.homelab_test_backup_status
- input_number.homelab_test_backup_age_hours
- input_text.homelab_test_health_status
- input_number.homelab_test_health_percent
- input_text.homelab_test_services_status

Produktiv- und Testbetrieb verwenden identische Template-Logik.

---

# Abnahmetests

## INFRA

01 Backup WARN
02 Backup ERROR
03 Storage WARN
04 Storage ERROR
05 Internet ERROR
06 Internet + Backup
07 Internet + Storage + Backup

Ergebnis: bestanden.

## HOMELAB

01 Backup WARN
02 Backup ERROR
03 Health WARN
04 Health ERROR
05 Zigbee offline
06 Backup WARN + Health WARN
07 Backup ERROR + Health ERROR + Zigbee offline
08 Rückkehr Produktivbetrieb

Ergebnis: bestanden.

---

# Wartung

## Änderungen an Karten

Dateien liegen unter:

/config/trmnl/cards/

Vor Änderungen Backup erstellen.

## Änderungen an Template Sensoren

Datei:

/config/template_sensors.yaml

Danach:

template.reload

## Änderungen an Packages

Dateien unter:

/config/packages/

Danach:

ha core check

anschließend Home Assistant Neustart.

Wartezeit nach Neustart:

API-Verfügbarkeit allein reicht nicht aus.
Erst nach vollständiger Initialisierung der Template-Entitäten weiterarbeiten.

---

# Bekannte Besonderheiten

## TS-464

Nur POSIX-Shell verwenden.

Dateien ausschließlich mit

cat <<'EOF'

erzeugen.

## Home Assistant

- Packages verwenden ausschließlich gültige Slugs.
- Testmodus muss nach jedem Test deaktiviert werden.
- hbs3-status.json existiert ausschließlich im Public-Verzeichnis.
- Web-Verzeichnis enthält keine produktive JSON-Datei mehr.

## Externe Komponente: TRMNL Home Assistant Add-on

TRMNL-X verwendet das TRMNL Home Assistant Add-on ausschließlich als Rendering- und Übertragungsdienst.

### Aufgabe des Add-ons

- Öffnet die Lovelace-View im Kiosk-Modus.
- Erstellt einen Screenshot des Dashboards.
- Optimiert das Bild für ePaper (Dithering).
- Überträgt das Bild per Webhook an das TRMNL X Display.

### Nicht Bestandteil dieser Dokumentation

Installation, Konfiguration, Web UI, Zeitpläne, Webhooks und Troubleshooting werden nicht dokumentiert, sondern in der offiziellen Projektdokumentation gepflegt.

**Offizielle Dokumentation:** https://github.com/usetrmnl/trmnl-home-assistant
