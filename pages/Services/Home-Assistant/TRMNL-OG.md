# TRMNL-OG

**Stand:** 27.08.2026

**Status:** Golden Reference V1.0 (abgenommen)

---

# Zweck

Dieses Dokument beschreibt die produktive TRMNL-OG-Integration des Homelabs.

Die Dokumentation bildet die technische Referenz für das produktive Dashboard des TRMNL-X Displays.

## Ziele

- Einheitliche Architektur aller TRMNL-Karten.
- Reproduzierbare Darstellung auf dem TRMNL-X ePaper-Display.
- Trennung zwischen Datenlogik und Kartenlayout.
- Reproduzierbare Testumgebung für Abnahmetests.
- Golden References für Karten und Dokumentation.

---

# Systemübersicht

TRMNL-OG ist eine Lovelace-View innerhalb von Home Assistant, die durch das TRMNL Home Assistant Add-on gerendert und an das TRMNL-X Display übertragen wird.

## Komponenten

| Komponente | Aufgabe |
|------------|----------|
| Home Assistant | Datenaggregation und Rendering der Lovelace View. |
| Template Sensoren | Erzeugen aller Anzeige-Strings (`*_message_*`, `*_footer`). |
| Lovelace Dashboard | Präsentationsschicht. |
| TRMNL Home Assistant Add-on | Screenshot, Dithering und Webhook an TRMNL. |
| TRMNL-X Display | Darstellung auf dem ePaper-Display. |

---

# Architektur

## Datenfluss

    QNAP TS-464 (HBS3)
            │
            │ hbs3-status.json
            ▼
    REST Sensoren
            │
            ▼
    Template Sensoren (/config/templates)
            │
            ├── HOMELAB
            ├── INFRA
            ├── RENAULT
            ├── UPDATES
            └── weitere TRMNL Sensoren
            │
            ▼
    Message Sensoren
            │
            ▼
    Lovelace Dashboard (TRMNL OG)
            │
            ▼
    TRMNL Home Assistant Add-on
            │
            ▼
    TRMNL-X ePaper Display

### Architekturprinzipien

1. Sensoren enthalten ausschließlich Datenlogik.
2. Karten enthalten ausschließlich Darstellung.
3. Jede Karte verwendet dieselbe Layoutstruktur.
4. Testbetrieb nutzt dieselbe Template-Logik wie Produktivbetrieb.

---

# Verzeichnisstruktur

## Home Assistant

    /config/
    ├── configuration.yaml
    ├── templates/
    │   ├── homelab.yaml
    │   ├── infra.yaml
    │   ├── renault.yaml
    │   ├── updates.yaml
    │   └── ...
    ├── packages/
    │   ├── homelab_test.yaml
    │   ├── infra_testbench.yaml
    │   ├── trmnl-updates-test.yaml
    │   └── ...
    └── trmnl/
        ├── cards/
        ├── views/
        └── golden-reference/


---

# Einheitliche Kartenarchitektur (Golden Reference V1.0)

Seit dem 27.08.2026 verwenden alle produktiven TRMNL-OG-Karten dieselbe Layout-Architektur.

Diese Architektur ist die **Golden Reference V1.0**.

## Grundprinzip

Jede Karte besteht aus drei logischen Bereichen:

1. Titel
2. Vier feste Message-Zeilen
3. Optionaler Footer

Die Karten enthalten **keine Geschäftslogik**. Alle Texte werden ausschließlich von Template-Sensoren geliefert.

---

## Standardaufbau einer Karte

    type: grid

    cards:
      - type: markdown
        text_only: true
        content: |-
          # KARTENNAME

          MESSAGE_1
          MESSAGE_2
          MESSAGE_3
          MESSAGE_4

          FOOTER (optional)

Die Message-Zeilen werden durch die Sensoren `*_message_1` bis `*_message_4` erzeugt.

---

## CSS Golden Reference

Alle Karten verwenden dieselben card_mod-Regeln.

Eigenschaften:

| Eigenschaft | Wert |
|-------------|------|
| Kartenhöhe | 220 px |
| Innenabstand | 14 / 14 / 8 / 14 px |
| Titelgröße | 50 px |
| Message-Schrift | 24 px |
| Zeilenhöhe | 1.18 |
| Vier feste Message-Zeilen | Ja |
| Footer-Schrift | 15 px |
| Footer-Abstand | 14 px |

Die CSS-Regeln befinden sich produktiv in jeder Karten-Datei unter
`/config/trmnl/cards/`.

---

## Message-Architektur

Jede Karte besitzt genau vier Message-Sensoren.

### Benennung

| Karte | Sensoren |
|--------|----------|
| HOMELAB | sensor.homelab_message_1 … sensor.homelab_message_4 |
| INFRA | sensor.infra_message_1 … sensor.infra_message_4 |
| RENAULT | sensor.renault_message_1 … sensor.renault_message_4 |
| UPDATES | sensor.updates_message_1 … sensor.updates_message_4 |

### Architekturregel

- Karten greifen ausschließlich auf Message-Sensoren zu.
- Direkte Zugriffe auf Fachsensoren innerhalb der Karten sind nicht zulässig.
- Die gesamte Geschäftslogik befindet sich in `/config/templates/`.

---

## Leere Message-Zeilen

Alle Karten besitzen immer vier reservierte Zeilen.

Ist keine Meldung vorhanden, liefert der Template-Sensor das Unicode-Braille-Leerzeichen.

Zweck:

- konstante Kartenhöhe,
- konstante Footer-Position,
- identisches Layout unabhängig von der Anzahl der Meldungen.

---

## Footer-Architektur

Der Footer ist optional.

### Karten mit Footer

| Karte | Footer-Sensor |
|--------|---------------|
| RENAULT | sensor.renault_footer |
| UPDATES | sensor.updates_footer |

### Karten ohne Footer

| Karte | Status |
|--------|--------|
| HOMELAB | kein Footer |
| INFRA | kein Footer |

Die Karten besitzen trotzdem dieselbe card-body-Struktur und dieselbe Höhe.

---

# HOMELAB-Karte

## Aufgabe

Anzeige des Betriebszustands von Home Assistant.

### Prioritäten

1. Backup ERROR
2. Health ERROR
3. Zigbee2MQTT offline
4. Backup WARN
5. Health WARN
6. Home Assistant betriebsbereit

### Ausgabe

| Message | Inhalt |
|----------|--------|
| Message 1 | höchste Priorität |
| Message 2 | zweite Priorität |
| Message 3 | dritte Priorität |
| Message 4 | vierte Priorität oder Leerzeile |

---

# INFRA-Karte

## Aufgabe

Anzeige des Infrastrukturzustands.

### Prioritäten

1. Netzwerk ERROR
2. HBS3 Backup ERROR
3. Speicher ERROR
4. Backup WARN
5. Speicher WARN
6. Infrastruktur betriebsbereit

### Ausgabe

Vier feste Message-Sensoren analog HOMELAB.

---

# RENAULT-Karte

Die RENAULT-Karte ist die Referenzimplementierung für Karten mit Footer.

### Message-Sensoren

1. Batterie
2. Reichweite
3. Standort
4. Kilometerstand

### Footer

Zeitstempel der Kartenaktualisierung.

---

# UPDATES-Karte

## Datenquelle

sensor.system_ha_global_health_score_clean

Attribut:

pending_updates

### Namensabbildung

| Interner Name | Anzeige auf TRMNL |
|-------------------------------|-------------------------|
| Music Assistant Update | Music Assistant Update |
| 192.168.1.32 Uptime Kuma-Version | Docker-VM: Uptime Kuma |
| TRMNL HA Update | TRMNL HA |
| Paperless Update | Paperless-ngx Update |

### Darstellungsregeln

| Anzahl Updates | Anzeige |
|----------------|---------|
| 0 | Keine Updates |
| 1 | Erstes Update |
| 2 | Erstes und zweites Update |
| 3 | Drei Updates |
| 4 oder mehr | Erste zwei Updates + „und n weitere Updates“ |

Die Footer-Zeile bleibt unabhängig von der Anzahl der Updates an derselben Position.


---

# Template-Architektur

Die gesamte Geschäftslogik des TRMNL-Dashboards befindet sich ausschließlich in
`/config/templates/`.

Jede Karte besitzt eine eigene Template-Datei.

## Dateien

| Datei | Aufgabe |
|-------|---------|
| homelab.yaml | HOMELAB Message-Sensoren |
| infra.yaml | INFRA Message-Sensoren |
| renault.yaml | RENAULT Message- und Footer-Sensoren |
| updates.yaml | UPDATES Message-, Footer- und TestSuite-Logik |
| hbs3.yaml | HBS3 Backup-Sensoren |

## Architekturregel

- Karten lesen ausschließlich Message-Sensoren.
- Template-Dateien lesen Fachsensoren.
- Änderungen an der Geschäftslogik erfolgen ausschließlich unter `/config/templates/`.

---

# HBS3-Integration (QNAP TS-464)

Die INFRA-Karte verwendet die HBS3-Sicherungen der QNAP TS-464 als Datenquelle.

## Produktive Dateien auf der TS-464

    /share/CACHEDEV1_DATA/Public/hbs3-status-update.sh
    /share/CACHEDEV1_DATA/Public/hbs3-status.json
    /share/CACHEDEV1_DATA/Public/hbs3-webserver.sh

## HTTP-Endpunkt

    http://TS464:18080/hbs3-status.json

## JSON-Struktur

| Feld | Bedeutung |
|------|-----------|
| job_id | Backup-Job |
| timestamp | Unix-Zeit |
| human_time | ISO-Zeitstempel |
| status | success / warning / error |

## Cronjob (Golden Reference)

    0 */4 * * * /share/CACHEDEV1_DATA/Public/hbs3-status-update.sh >/dev/null 2>&1

### Eigenschaften

- POSIX-Shell.
- Idempotent.
- Aktualisierung alle vier Stunden.
- Unabhängig vom Ende eines Backup-Jobs.

---

# HOMELAB Sensorarchitektur

Die HOMELAB-Karte bewertet ausschließlich den Zustand von Home Assistant.

## Eingänge

| Sensor | Bedeutung |
|--------|-----------|
| sensor.ha_backup_status | Backup OK / WARN / ERROR |
| sensor.ha_backup_age_hours | Alter des letzten Backups |
| sensor.ha_health_status | Health OK / WARN / ERROR |
| sensor.ha_health_percent | Health Score |
| sensor.ha_services_status | Dienste (z. B. Zigbee2MQTT) |

## Ausgänge

    sensor.homelab_message_1
    sensor.homelab_message_2
    sensor.homelab_message_3
    sensor.homelab_message_4

---

# INFRA Sensorarchitektur

Die INFRA-Karte bewertet Infrastrukturkomponenten außerhalb von Home Assistant.

## Eingänge

| Sensor | Bedeutung |
|--------|-----------|
| sensor.network_status | Internet / Netzwerk |
| sensor.hbs3_backup_status | HBS3 Backup |
| sensor.hbs3_backup_age_hours | Backup-Alter |
| sensor.storage_status | Speicherzustand |
| sensor.storage_free_percent | Freier Speicher |

## Ausgänge

    sensor.infra_message_1
    sensor.infra_message_2
    sensor.infra_message_3
    sensor.infra_message_4

---

# RENAULT Sensorarchitektur

Die RENAULT-Karte verwendet ausschließlich vorbereitete Message-Sensoren.

## Eingänge

| Fachsensor | Ausgabe |
|------------|---------|
| sensor.megane_e_tech_batterie_megane | Batterie |
| sensor.megane_e_tech_reichweite | Reichweite |
| device_tracker.megane_e_tech_standort | Standort |
| sensor.megane_e_tech_kilometerstand | Kilometerstand |
| now() | Footer-Zeitstempel |

## Ausgänge

    sensor.renault_message_1
    sensor.renault_message_2
    sensor.renault_message_3
    sensor.renault_message_4
    sensor.renault_footer

---

# UPDATES Sensorarchitektur

Die UPDATES-Karte erzeugt alle Anzeigezeilen aus einer einzigen Update-Liste.

## Datenquelle

    sensor.system_ha_global_health_score_clean

Attribut:

    pending_updates

## Interne Verarbeitung

1. Anzahl der Updates bestimmen.
2. Interne Namen in TRMNL-Namen übersetzen.
3. Maximal vier Message-Zeilen erzeugen.
4. Footer-Zeitstempel erzeugen.

## Namensabbildung

| Interner Eintrag | Anzeige |
|------------------|---------|
| Music Assistant Update | Music Assistant Update |
| 192.168.1.32 Uptime Kuma-Version | Docker-VM: Uptime Kuma |
| TRMNL HA Update | TRMNL HA |
| Paperless Update | Paperless-ngx Update |

## Darstellungsregel

| Anzahl Updates | Message-Ausgabe |
|----------------|-----------------|
| 0 | Keine Updates |
| 1 | Update 1 |
| 2 | Update 1, Update 2 |
| 3 | Update 1, Update 2, Update 3 |
| 4 oder mehr | Update 1, Update 2, "und n weitere Updates" |

Der Footer bleibt unabhängig von der Anzahl der Updates an derselben Position.


---

# Testarchitektur

Produktivbetrieb und Testbetrieb verwenden dieselbe Template-Logik.

Die Testmodi überschreiben ausschließlich die Eingabewerte. Das Kartenlayout und die Message-Sensoren bleiben unverändert.

## Übersicht

| Karte | Testsystem | Status |
|--------|------------|--------|
| HOMELAB | Testbench | Produktiv |
| INFRA | Testbench | Produktiv |
| UPDATES | TestSuite V1.1 | Produktiv |
| RENAULT | derzeit kein Testmodus | Produktiv |

---

# HOMELAB Testbench

## Package

    /config/packages/homelab_test.yaml

## Hilfsentitäten

| Entität | Zweck |
|---------|-------|
| input_boolean.homelab_test_mode | Testmodus EIN/AUS |
| input_text.homelab_test_backup_status | Backupstatus |
| input_number.homelab_test_backup_age_hours | Backupalter |
| input_text.homelab_test_health_status | Healthstatus |
| input_number.homelab_test_health_percent | Health Score |
| input_text.homelab_test_services_status | Dienstestatus |

## Abnahmetests

| Test | Erwartung |
|------|-----------|
| Backup WARN | Warnmeldung |
| Backup ERROR | Fehlermeldung |
| Health WARN | Warnmeldung |
| Health ERROR | Fehlermeldung |
| Zigbee2MQTT offline | Servicemeldung |
| Backup WARN + Health WARN | Priorisierung korrekt |
| Backup ERROR + Health ERROR + Zigbee offline | Priorisierung korrekt |
| Rückkehr Produktivbetrieb | Betriebsbereit |

**Status:** Bestanden.

---

# INFRA Testbench

## Package

    /config/packages/infra_testbench.yaml

## Hilfsentitäten

| Entität | Zweck |
|---------|-------|
| input_boolean.infra_test_mode | Testmodus EIN/AUS |
| input_text.infra_test_network_status | Netzwerkstatus |
| input_text.infra_test_hbs3_status | Backupstatus |
| input_number.infra_test_hbs3_age_hours | Backupalter |
| input_text.infra_test_storage_status | Speicherstatus |
| input_number.infra_test_storage_free_percent | Freier Speicher |

## Abnahmetests

| Test | Erwartung |
|------|-----------|
| Backup WARN | Warnmeldung |
| Backup ERROR | Fehlermeldung |
| Storage WARN | Warnmeldung |
| Storage ERROR | Fehlermeldung |
| Internet ERROR | Netzwerkfehler |
| Internet + Backup | Priorisierung korrekt |
| Internet + Storage + Backup | Priorisierung korrekt |

**Status:** Bestanden.

---

# UPDATES TestSuite V1.1

## Package

    /config/packages/trmnl-updates-test.yaml

## Hilfsentitäten

| Entität | Zweck |
|---------|-------|
| input_boolean.updates_test_mode | Testmodus EIN/AUS |
| input_select.updates_test_case | Auswahl des Testfalls |

## Testfälle

| Testfall | Erwartete Anzeige |
|----------|-------------------|
| LIVE | Produktive Updates |
| KEINE_UPDATES | "Keine Updates" |
| DREI_UPDATES | Drei Updates werden einzeln angezeigt |
| VIER_ODER_MEHR | Erste zwei Updates + "und n weitere Updates" |

## Abnahmekriterien

### LIVE

- Anzahl entspricht `pending_updates`.
- Interne Namen werden übersetzt.
- Footer zeigt aktuellen Zeitstempel.

### KEINE_UPDATES

- `0 Update(s)`
- `Keine Updates`
- Zwei reservierte Leerzeilen.

### DREI_UPDATES

- `3 Update(s)`
- Drei einzelne Updatezeilen.
- Footer auf konstanter Position.

### VIER_ODER_MEHR

- Zähler zeigt Gesamtzahl.
- Anzeige zeigt nur die ersten beiden Updates.
- Letzte Message lautet `• und n weitere Updates`.

**Status:** Bestanden (27.08.2026).

---

# Testbetrieb aktivieren

## HOMELAB

- Testmodus einschalten.
- Testwerte setzen.
- Ergebnis auf der TRMNL-Karte prüfen.

## INFRA

- Testmodus einschalten.
- Testwerte setzen.
- Priorisierung prüfen.

## UPDATES

- Testmodus einschalten.
- Testfall auswählen.
- Karte aktualisiert sich automatisch.

---

# Rückkehr in den Produktivbetrieb

Nach jedem Test:

1. Testmodus ausschalten.
2. Testfall auf `LIVE` stellen.
3. Prüfen, dass wieder Produktivdaten angezeigt werden.

Diese Regel gilt für alle Testbenches und Testsuiten.


---

# Wartung

Dieses Kapitel beschreibt die verbindlichen Betriebs- und Änderungsregeln für TRMNL-OG.

## Änderungen an Karten

Verzeichnis:

    /config/trmnl/cards/

### Vorgehen

1. Karten-Datei ändern.
2. `ha core check` ausführen.
3. Nur bei erfolgreicher Prüfung `ha core restart`.
4. Funktion prüfen.
5. Golden Reference aktualisieren.

### Golden Reference aktualisieren

Verzeichnis:

    /config/trmnl/golden-reference/trmnl-og/

Die produktiven Karten werden nach erfolgreicher Abnahme 1:1 in dieses Verzeichnis kopiert und überschreiben den bisherigen Referenzstand.

---

## Änderungen an Template-Sensoren

Verzeichnis:

    /config/templates/

### Vorgehen

1. Template-Datei ändern.
2. `ha core check`.
3. `ha core restart`.

### Architekturregel

- Keine produktiven TRMNL-Sensoren außerhalb von `/config/templates/`.
- Eine Datei pro funktionaler Einheit.

---

## Änderungen an Packages

Verzeichnis:

    /config/packages/

### Vorgehen

1. Package ändern oder neu anlegen.
2. `ha core check`.
3. `ha core restart`.

### Benennungsregel

Packages verwenden ausschließlich gültige Slugs.

Beispiele:

- homelab_test.yaml
- infra_testbench.yaml
- trmnl-updates-test.yaml

---

# Betriebsregeln

## Message-Architektur

Verbindliche Regeln:

- Jede Karte besitzt genau vier Message-Sensoren.
- Karten greifen ausschließlich auf Message-Sensoren zu.
- Geschäftslogik befindet sich ausschließlich in Template-Sensoren.
- Leere Zeilen werden durch das Braille-Leerzeichen (`⠀`) erzeugt.

## Footer-Regeln

| Karte | Footer |
|--------|--------|
| HOMELAB | keiner |
| INFRA | keiner |
| RENAULT | sensor.renault_footer |
| UPDATES | sensor.updates_footer |

Der Footer wird immer am unteren Kartenrand positioniert.

---

## Neustart-Regeln

### Home Assistant

Nach Änderungen an Templates oder Packages grundsätzlich:

    ha core check

Nur wenn erfolgreich:

    ha core restart

### Akzeptiertes Verhalten

Während eines Core-Neustarts können Message-Sensoren kurzfristig `unknown` liefern.

Eigenschaften:

- ausschließlich während der Initialisierung,
- Message-Zeilen bleiben untereinander,
- keine Sonderbehandlung vorgesehen.

Status: **Akzeptiert.**

---

# Bekannte Besonderheiten

## TS-464 (QNAP)

Verbindliche Regeln:

- Nur POSIX-Shell.
- Keine Bash-spezifischen Erweiterungen.
- Dateien ausschließlich mit

    cat <<'EOF'

erzeugen.

---

## Supervisor API

Verbindlicher Diagnoseablauf:

1. `curl -i` (HTTP-Status und Rohantwort prüfen).
2. Nur bei HTTP 200 die JSON-Antwort mit `jq` auswerten.

Diese Reihenfolge verhindert, dass HTTP-Fehler verborgen werden.

---

## Testbetrieb

Nach jedem Test:

1. Testmodus deaktivieren.
2. Testfall auf LIVE zurücksetzen.
3. Produktivdaten prüfen.

Dies gilt für HOMELAB, INFRA und UPDATES.

---

# Dokumentationsregeln (Golden Reference)

## Golden Reference Karten

Referenzstand:

    /config/trmnl/golden-reference/trmnl-og/

Diese Dateien werden ausschließlich nach erfolgreicher Abnahme aktualisiert.

## Dokumentation

Git-Repository:

    /home/cs/Dokumente/Logseq-Graphs/Homelab/

Dokumentationspfad:

    pages/Services/Home-Assistant/TRMNL-OG.md

## Arbeitsregeln

- Ausführbare `cat <<'EOF'`-Blöcke enthalten immer vollständigen Inhalt.
- Keine Platzhalter in ausführbaren Blöcken.
- Größere Dokumente werden kapitelweise aufgebaut.
- Git-Commit erfolgt erst nach Fertigstellung der gesamten Dokumentation.

---

# Externe Komponente: TRMNL Home Assistant Add-on

TRMNL-OG verwendet das TRMNL Home Assistant Add-on ausschließlich als Rendering- und Übertragungsdienst.

## Aufgaben

- Lovelace View im Kiosk-Modus öffnen.
- Screenshot erzeugen.
- Dithering für ePaper anwenden.
- Screenshot per Webhook an das TRMNL-X Display übertragen.

## Nicht Bestandteil dieser Dokumentation

- Installation.
- Konfiguration.
- Zeitpläne.
- Webhooks.
- Fehleranalyse des Add-ons.

Diese Themen werden ausschließlich in der offiziellen Projektdokumentation gepflegt.

## Referenzprojekt

GitHub:

    usetrmnl/trmnl-home-assistant

---

# Freigabestand

**Version:** Golden Reference V1.0

**Abnahmedatum:** 27.08.2026

## Bestandteil der Freigabe

- Einheitliche Kartenarchitektur.
- Template-Architektur `/config/templates/`.
- Golden References der Karten.
- HOMELAB Testbench.
- INFRA Testbench.
- UPDATES TestSuite V1.1.
- HBS3-Integration TS-464.
- Wartungs- und Betriebsregeln.

Diese Dokumentation beschreibt den freigegebenen produktiven Stand von TRMNL-OG.

