# TRMNL-X

## Home Assistant Dashboard für das TRMNL X Display

---

## Zweck

TRMNL-X ist ein eigenständiges Lovelace-Dashboard für das TRMNL X ePaper-Display. Es stellt ausgewählte Informationen aus Home Assistant in einer für das Display optimierten Darstellung bereit.

Das Dashboard ist bewusst schlank aufgebaut:

- vier spezialisierte Karten
- zentrale Datenaufbereitung in einem Package
- keine Geschäftslogik innerhalb der Karten
- optimiert für den Screenshot-Workflow des TRMNL Home Assistant Add-ons

TRMNL-X ist unabhängig vom übrigen Home-Assistant-Dashboard.

---

## Architektur

```text
                    Home Assistant
                           │
        ┌──────────────────┴──────────────────┐
        │                                     │
 Wetterintegration                     Google Kalender
        │                                     │
        └──────────────────┬──────────────────┘
                           │
              Package: trmnl_calendar.yaml
                           │
      ┌────────────────────┼────────────────────┐
      │                    │                    │
input_text.trmnl_   input_text.trmnl_   input_text.trmnl_
next_events         x_birthdays         next_holidays
      │                    │                    │
      ├──────────────┬─────┴─────────────┬──────┤
      │              │                   │
calendar.yaml  anniversaries.yaml  holidays.yaml
      │
weather.yaml (direkte Wetterdaten)
      │
      ▼
Dashboard „TRMNL X“
      │
TRMNL Home Assistant Add-on
      │
TRMNL X Display
```

### Grundprinzip

Das Dashboard rendert ausschließlich bereits vorbereitete Daten.

- Kalenderdaten werden im Package formatiert.
- Wetterdaten stammen direkt aus Wetter-Entitäten.
- Die Karten enthalten ausschließlich Präsentationslogik.

---

## Dashboard-Struktur

Die produktive View besteht aus genau vier Karten.

```yaml
###########################################################################
# TRMNL X
###########################################################################
- title: TRMNL X
  path: x
  icon: mdi:tablet-dashboard
  type: sections
  max_columns: 2

  kiosk_mode:
    hide_header: true
    hide_sidebar: true

  sections:
    - !include /config/trmnl/cards/weather.yaml
    - !include /config/trmnl/cards/calendar.yaml
    - !include /config/trmnl/cards/anniversaries.yaml
    - !include /config/trmnl/cards/holidays.yaml
```

### Eigenschaften

- Dashboard-Typ: `sections`
- Zwei Spalten (`max_columns: 2`)
- Kiosk-Modus aktiviert.
- Keine Sidebar.
- Kein Header.

---

## Verzeichnisstruktur

| Pfad | Aufgabe |
|------|---------|
| `/config/trmnl/cards/` | Produktive Karten des Dashboards. |
| `/config/trmnl/golden-reference/trmnl-x/` | Referenzversionen der Karten. |
| `/config/packages/trmnl_calendar.yaml` | Gemeinsame Kalender-Pipeline. |

### Karten

| Datei | Inhalt |
|-------|--------|
| `weather.yaml` | Wetterübersicht. |
| `calendar.yaml` | Kommende Termine. |
| `anniversaries.yaml` | Geburtstage, Hochzeiten und Gedenktage. |
| `holidays.yaml` | Kommende Feiertage. |

---

## Datenquellen

### Übersicht

| Karte | Datenquelle |
|-------|-------------|
| `weather.yaml` | Wetterintegration (DWD/OpenWeather). |
| `calendar.yaml` | `input_text.trmnl_next_events` |
| `anniversaries.yaml` | `input_text.trmnl_x_birthdays` |
| `holidays.yaml` | `input_text.trmnl_next_holidays` |

### Datenfluss

Die drei Kalenderkarten verwenden dieselbe Datenpipeline.

- Termine
- Jahrestage
- Feiertage

werden gemeinsam durch `trmnl_calendar.yaml` erzeugt.

---

## Kalender-Pipeline (`trmnl_calendar.yaml`)

### Aufgabe

Das Package sammelt Kalenderereignisse und erzeugt Anzeige-Strings für das Dashboard.

### Quellen

- Google Kalender „Geburtstage“
- Google Kalender „Christoph“
- Deutscher Feiertagskalender

### Ergebnis

Das Package schreibt vorbereitete Zeichenketten in `input_text`-Helper.

| Helper | Verwendung |
|--------|------------|
| `input_text.trmnl_next_events` | Termine |
| `input_text.trmnl_x_birthdays` | Jahrestage |
| `input_text.trmnl_next_holidays` | Feiertage |

Die Karten lesen ausschließlich diese Helper.

---

## Karte: Wetter

### Zweck

Darstellung der aktuellen Wetterlage auf TRMNL X.

### Inhalte

- Temperatur
- Wetterzustand
- Tagesprognose
- DWD-Warnstatus

### Datenquelle

Direkte Wetter-Entitäten aus Home Assistant.

Die Karte verarbeitet keine Wetterdaten selbst.

---

## Karte: Kalender

### Zweck

Anzeige der nächsten Termine.

### Datenquelle

`input_text.trmnl_next_events`

### Darstellung

- Liste der nächsten Termine.
- Bereits formatiert.
- Zeitinformationen werden unverändert übernommen.

---

## Karte: Jahrestage

### Zweck

Anzeige kommender Geburtstage, Hochzeiten und Gedenktage.

### Datenquelle

`input_text.trmnl_x_birthdays`

### Darstellung

Die Karte

1. liest den Helper,
2. trennt die Einträge an `|`,
3. zeigt maximal sechs Einträge.

### Anzeigeformat

Beispiele:

```text
🎂 04.10. André Marjanović
💍 11.12. Karl und Brigitte Wiegand
🕯 03.03. …
```

Am unteren Rand wird der Aktualisierungszeitpunkt angezeigt.

Format:

```text
Do 27.08.2026 08:15
```

Die deutschen Wochentage werden lokal in der Karte erzeugt.

---

## Karte: Feiertage

### Zweck

Anzeige des nächsten gesetzlichen Feiertags.

### Datenquelle

`input_text.trmnl_next_holidays`

### Darstellung

- Name des Feiertags.
- Datum.
- Restliche Tage bis zum Feiertag (falls vom Package bereitgestellt).

---

## Gestaltung der Karten

Alle vier Karten folgen demselben Layoutprinzip.

### Aufbau

- `grid`-Karte
- `markdown`-Karte
- `card_mod` für Layout und Typografie

### Einheitliche Gestaltung

- große Überschrift (`h1`)
- große Markdown-Schrift
- kompakte Zeilenabstände
- Zeitstempel als `sub`
- optimierte Abstände für das TRMNL X Display

Die Darstellung ist auf ein 16-Graustufen-ePaper abgestimmt.

---

## Golden Reference

Verzeichnis:

```text
/config/trmnl/golden-reference/trmnl-x/
```

### Zweck

Golden Reference enthält funktionierende Referenzversionen aller produktiven Karten.

### Regeln

- niemals produktiv bearbeiten
- dient ausschließlich als Referenz
- Aktualisierung nur nach erfolgreichem Test einer neuen Version

---

## Rendering auf das TRMNL X Display

### Ablauf

1. Home Assistant öffnet die TRMNL-X-View im Kiosk-Modus.
2. Das TRMNL Home Assistant Add-on erzeugt einen Screenshot.
3. Der Screenshot wird für das Display optimiert.
4. Das Bild wird per Webhook an das TRMNL X übertragen.

### Aufgabe des Dashboards

Das Dashboard liefert ausschließlich die Darstellung.

Die Kommunikation mit dem Display übernimmt das Add-on.

---

## Wartung

### Änderungen an einer Karte

1. Datei unter `/config/trmnl/cards/` bearbeiten.
2. Dashboard neu laden.
3. Darstellung prüfen.
4. Golden Reference bei stabilem Stand aktualisieren.

### Änderungen an Kalenderdaten

Änderungen erfolgen ausschließlich in

```text
/config/packages/trmnl_calendar.yaml
```

Die Karten bleiben unverändert, solange die Helper dieselbe Schnittstelle bereitstellen.

---

## Designprinzipien

TRMNL-X folgt im Homelab drei einfachen Regeln.

### Darstellung und Logik trennen

Karten enthalten nur Präsentation.

### Einheitliche Datenschnittstellen

Kalenderdaten werden über `input_text`-Helper bereitgestellt.

### Referenzbestand erhalten

Golden Reference dient als dokumentierter, funktionierender Ausgangspunkt für spätere Änderungen.

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
