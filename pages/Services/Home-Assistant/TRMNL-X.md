# TRMNL-X

**Golden Reference V1.2 (WAF Edition)**

Status: Produktiv · Freigegeben

---

## Zweck

TRMNL-X ist das produktive Dashboard für das **TRMNL X High Density ePaper Display** im Homelab.

### Referenzhardware

| Merkmal | Wert |
|---------|------|
| Display | TRMNL X High Density ePaper |
| Displaygröße | **10,3 Zoll** |
| Auflösung | **1872 × 1404 Pixel** |
| Farbtiefe | **16 Graustufen** |
| Vollständiger Refresh | **≤ 1,2 Sekunden** |
| Partieller Refresh | **≤ 200 Millisekunden** |

### Designziele

- maximale Lesbarkeit auf einem 16-Graustufen-ePaper-Display.
- hohe Informationsdichte ohne Überladung.
- klare Trennung zwischen Datenbereitstellung und Darstellung.
- identisches Layout (`card_mod`) auf allen Karten.
- optimiert für schnelle partielle Refreshes mit möglichst wenig Flackern.

---

# Architektur

TRMNL-X besteht aus vier klar getrennten Schichten.

| Ebene | Aufgabe |
|-------|----------|
| Templates | Erzeugen der darzustellenden Message-Sensoren. |
| Automation | Bereitet Kalender- und Jahrestage-Daten auf. |
| Dashboard Cards | Präsentation der Sensoren. Keine Geschäftslogik. |
| View | Anordnung der Karten auf dem Display. |

## Verzeichnisstruktur

```text
/config/
├── packages/
│   └── trmnl_calendar.yaml
│
├── templates/
│   ├── weather.yaml
│   ├── calendar.yaml
│   ├── anniversaries.yaml
│   └── holidays.yaml
│
├── trmnl/
│   ├── cards/
│   │   ├── weather.yaml
│   │   ├── calendar.yaml
│   │   ├── anniversaries.yaml
│   │   └── holidays.yaml
│   │
│   ├── views/
│   │   └── trmnl-x.yaml
│   │
│   └── golden-reference/
│       ├── trmnl-og/
│       └── trmnl-x/
│           ├── README.md
│           ├── weather.yaml
│           ├── calendar.yaml
│           ├── anniversaries.yaml
│           ├── holidays.yaml
│           └── view.yaml
```

---

# Dashboard

Die View besteht aus vier Karten.

| Position | Karte | Datenquelle |
|----------|-------|-------------|
| Links oben | Wetter | `templates/weather.yaml` |
| Rechts oben | Kalender | `packages/trmnl_calendar.yaml` + `templates/calendar.yaml` |
| Links unten | Jahrestage | `packages/trmnl_calendar.yaml` + `templates/anniversaries.yaml` |
| Rechts unten | FEIERTG. & FERIEN | `templates/holidays.yaml` |

Alle Karten besitzen identisches Layout und identische Typografie.

---

# Karte Wetter

**Dateien**

- `templates/weather.yaml`
- `cards/weather.yaml`

## Datenfluss

OpenWeatherMap, GW1100A und DWD-Warnsensoren werden in `templates/weather.yaml` zu Anzeige-Sensoren zusammengeführt.

## Sensoren

- `sensor.trmnl_weather_temperature`
- `sensor.trmnl_weather_message_1`
- `sensor.trmnl_weather_message_2`
- `sensor.trmnl_weather_message_3`
- `sensor.trmnl_weather_message_4`
- `sensor.trmnl_weather_message_5`
- `sensor.trmnl_weather_message_6`

## Darstellung

- große Temperatur links oben,
- Wetterzustand,
- DWD-Warnhinweis,
- sechs feste Message-Zeilen,
- gemeinsamer Footer.

---

# Karte Kalender

**Dateien**

- `packages/trmnl_calendar.yaml`
- `templates/calendar.yaml`
- `cards/calendar.yaml`

## Datenfluss

```text
calendar.christoph_schwaeppe_gmail_com
        │
        ▼
automation.trmnl_calendar_update
        │
        ▼
input_text.trmnl_x_events
        │
        ▼
templates/calendar.yaml
        │
        ▼
sensor.trmnl_calendar_message_1 ... 6
        │
        ▼
cards/calendar.yaml
```

## Automation

**Automation**

`automation.trmnl_calendar_update`

**Friendly Name**

`TRMNL Calendar Update`

## Aufgabe

Alle 15 Minuten werden die nächsten Termine aus dem Google-Kalender gelesen.

## Aufbereitungsregeln

- Zeitraum: 30 Tage.
- Ganztagstermine ohne Uhrzeit.
- Termine mit Uhrzeit als `DD.MM. HH:MM`.
- Lange Titel werden gekürzt.
- Häufige Bezeichnungen werden vereinheitlicht.

Die Karte enthält keinerlei Logik.

---

# Karte Jahrestage

**Dateien**

- `packages/trmnl_calendar.yaml`
- `templates/anniversaries.yaml`
- `cards/anniversaries.yaml`

## Datenfluss

```text
calendar.geburtstage_01
        │
        ▼
automation.trmnl_calendar_update
        │
        ▼
input_text.trmnl_x_birthdays
        │
        ▼
templates/anniversaries.yaml
        │
        ▼
sensor.trmnl_anniversaries_message_1
sensor.trmnl_anniversaries_message_2
sensor.trmnl_anniversaries_message_3
sensor.trmnl_anniversaries_message_4
sensor.trmnl_anniversaries_message_5
sensor.trmnl_anniversaries_message_6
sensor.trmnl_anniversaries_footer
        │
        ▼
cards/anniversaries.yaml
```

## Aufgabe der Automation

Die Automation liest den Kalender `calendar.geburtstage_01` und schreibt eine kompakte Darstellung nach `input_text.trmnl_x_birthdays`.

## Aufbereitungsregeln

Die Automation

- entfernt Zusätze wie *Birthday* oder *Geburtstag*,
- erkennt Geburtstage, Hochzeitstage und Gedenktage anhand des Kalendereintrags,
- schreibt die ersten sechs Einträge in den Helfer `input_text.trmnl_x_birthdays`.

## Darstellung

`templates/anniversaries.yaml` zerlegt den Inhalt des Helfers in sechs Message-Sensoren sowie einen Footer-Sensor.

| Sensor | Inhalt |
|--------|--------|
| `sensor.trmnl_anniversaries_message_1` | erster Jahrestag |
| `sensor.trmnl_anniversaries_message_2` | zweiter Jahrestag |
| `sensor.trmnl_anniversaries_message_3` | dritter Jahrestag |
| `sensor.trmnl_anniversaries_message_4` | vierter Jahrestag |
| `sensor.trmnl_anniversaries_message_5` | fünfter Jahrestag |
| `sensor.trmnl_anniversaries_message_6` | sechster Jahrestag |
| `sensor.trmnl_anniversaries_footer` | Wochentag, Datum und Uhrzeit |

Die Karte enthält keine eigene Logik zur Interpretation der Jahrestage.

---

# Karte FEIERTG. & FERIEN

**Dateien**

- `templates/holidays.yaml`
- `cards/holidays.yaml`

## Datenfluss

```text
sensor.feiertag_de_nw
sensor.schulferien_de_nw
        │
        ▼
templates/holidays.yaml
        │
        ▼
sensor.trmnl_holidays_message_1
sensor.trmnl_holidays_message_2
sensor.trmnl_holidays_message_3
sensor.trmnl_holidays_message_4
sensor.trmnl_holidays_message_5
sensor.trmnl_holidays_message_6
        │
        ▼
cards/holidays.yaml
```

## Datenquellen

Integration **Schulferien Deutschland** (Nordrhein-Westfalen).

Verwendete Sensoren:

- `sensor.feiertag_de_nw`
- `sensor.schulferien_de_nw`

## Logik

Die komplette Logik befindet sich ausschließlich in `templates/holidays.yaml`.

Das Template verwendet ausschließlich die beiden Sensoren der HACS-Integration und erzeugt sechs Message-Sensoren.

Es werden **keine Input-Text-Helfer** verwendet.

## Darstellung

| Sensor | Inhalt |
|--------|--------|
| `sensor.trmnl_holidays_message_1` | nächster gesetzlicher Feiertag (Datum + Name) |
| `sensor.trmnl_holidays_message_2` | Leerzeile (Abstand) |
| `sensor.trmnl_holidays_message_3` | Leerzeile (Abstand vor Ferien) |
| `sensor.trmnl_holidays_message_4` | Name der laufenden oder nächsten NRW-Schulferien |
| `sensor.trmnl_holidays_message_5` | Zeitraum der Ferien (`TT.MM.–TT.MM.`) |
| `sensor.trmnl_holidays_message_6` | Reserve (derzeit leer) |

Die Karte besitzt **keinen Footer**.

Das im gemeinsamen `card_mod` vorhandene `.footer`-CSS wird von dieser Karte derzeit nicht verwendet.

---

# Einheitliches Kartenlayout

Alle vier Karten besitzen identisches `card_mod`.

Gemeinsame Eigenschaften

- identische Kartenhöhe,
- identische Innenabstände,
- identische Typografie,
- identischer `card-body`,
- sechs Message-Zeilen als gemeinsames Layoutprinzip.

Besonderheit:

- Wetter, Kalender und Jahrestage verwenden einen Footer.
- FEIERTG. & FERIEN verwendet keinen Footer.

---

# Golden Reference

Referenzverzeichnis

`/config/trmnl/golden-reference/trmnl-x/`

Enthält den vollständigen Satz der freigegebenen produktiven Dashboard-Dateien.

## Aktualisierung der Golden Reference

```bash
cp -f /config/trmnl/cards/weather.yaml \
      /config/trmnl/golden-reference/trmnl-x/weather.yaml

cp -f /config/trmnl/cards/calendar.yaml \
      /config/trmnl/golden-reference/trmnl-x/calendar.yaml

cp -f /config/trmnl/cards/anniversaries.yaml \
      /config/trmnl/golden-reference/trmnl-x/anniversaries.yaml

cp -f /config/trmnl/cards/holidays.yaml \
      /config/trmnl/golden-reference/trmnl-x/holidays.yaml

cp -f /config/trmnl/views/trmnl-x.yaml \
      /config/trmnl/golden-reference/trmnl-x/view.yaml
```

---

# Betrieb

## Konfiguration prüfen

```bash
ha core check
```

## Home Assistant neu starten

```bash
ha core restart
```

---

# Wartung

## Neue Karte hinzufügen

1. Template erstellen.
2. Message-Sensoren erzeugen.
3. Karte unter `cards/` erstellen.
4. Karte in `views/trmnl-x.yaml` einbinden.
5. Golden Reference aktualisieren.

## Automation erweitern

Nur `packages/trmnl_calendar.yaml`.

Darstellung gehört ausschließlich in Templates und Karten.

---

# Home Assistant Betriebsregeln

## HA-BusyBox-01

Home Assistant OS SSH verwendet BusyBox.

GNU-Optionen wie `grep --include` stehen nicht zur Verfügung.

Verwendung:

```bash
find /config -name "*.yaml" -exec grep -Hn "SUCHTEXT" {} \;
```

## HA-Storage-01

Verwaiste Entitäten entfernen

1. Konfigurationsquelle entfernen.
2. `ha core stop`
3. `core.entity_registry` bereinigen.
4. `core.restore_state` bereinigen.
5. `ha core start`
6. Prüfung über die Supervisor API (`404 Not Found`).

---

# Migration V1.1 → V1.2

## Änderungen

- Wetter vollständig auf Message-Sensoren umgestellt.
- Kalender vollständig auf Message-Sensoren umgestellt.
- Jahrestage vollständig auf Message-Sensoren umgestellt.
- FEIERTG. & FERIEN ersetzt die bisherige Feiertagskarte.
- NRW-Schulferien über die HACS-Integration integriert.
- Einheitliches `card_mod` auf allen Karten.
- `TRMNL Calendar V3 Update` → `TRMNL Calendar Update`.
- Automation-ID auf `trmnl_calendar_update` bereinigt.
- `input_text.trmnl_x_holidays` entfernt.
- `input_text.trmnl_next_holidays` entfernt.

---

# Abnahme

**Golden Reference V1.2 (WAF Edition)**

Status: Freigegeben.

Abnahmekriterium: **100 % Wife Acceptance (WAF)**.
