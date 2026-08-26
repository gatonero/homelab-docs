# TRMNL Dashboard V5 (Stable)

status:: stable
projekt:: TRMNL
version:: V5 Stable
dashboard:: /homeassistant/dashboard-trmnl-v5-stable.yaml
addon:: TRMNL HA
datum:: 2026-08-21

---

## Zweck

Produktive Referenzversion des Home-Assistant-Dashboards für das **TRMNL X (16 Graustufen)**.

Diese Version ist eingefroren. Änderungen erfolgen ausschließlich in einer neuen Version (V6, V7 ...).

---

## Dashboard-Datei

Datei:

/homeassistant/dashboard-trmnl-v5-stable.yaml

---

## Layout

### Linke Spalte

- Wetter
- Wetterwarnung
- Jahrestage (6 Einträge)

### Rechte Spalte

- Kalender (10 Termine)
- Feiertage (6 Einträge)

---

## Kalender-Regeln

- Quelle: input_text.trmnl_x_events
- maximal 10 Termine.
- Aufzählung mit Bullet `•`.
- Keine `<text preserveWhitespace>` Tags.
- Der Begriff **Hanny** wird fett dargestellt.
- Kurze Kalendereinträge werden bevorzugt (WAF-Regel).

---

## Jahrestage

Quelle:

input_text.trmnl_x_birthdays

Anzeige:

- maximal 6 Einträge.

---

## Feiertage

Quelle:

input_text.trmnl_x_holidays

Anzeige:

- maximal 6 Feiertage.

---

## Typografie

### Wetterkarte

- Temperatur sehr groß.
- Wetterzustand fett.
- Warnblock unter horizontaler Linie.

### Kalenderkarte

- Titel: 54 px.
- Abschnitt "TERMINE": fett.
- Schriftgröße: 22 px.
- Zeilenhöhe: 1.20.
- Kompakter Zeilenabstand.
- Fettmarkierung von **Hanny**.

### Jahrestage / Feiertage

- Titel: 54 px.
- Schriftgröße: 22 px.
- Zeilenhöhe: 1.22.

---

## TRMNL HA Add-on Einstellungen (Referenz)

### Dashboard

- Dashboard Path: `/dashboard-trmnl/x?kiosk`
- Device Preset: `TRMNL X`
- Home Assistant Mode: aktiviert

### Screenshot

- Viewport: **1872 × 1404 Pixel**
- Crop Region: deaktiviert
- Format: PNG
- Rotation: None
- Zoom: **1.70**
- Wait: **1000 ms**
- Theme: Default
- Language: `de`
- Dark Mode: deaktiviert (Dashboard nutzt eigenes dunkles Theme.)
- Invert Colors: deaktiviert
- Show Capture Time: deaktiviert

### Dithering

- Dithering: aktiviert.
- Methode: **Floyd–Steinberg**
- Palette: **16 Graustufen (TRMNL X)**

Diese Kombination liefert die beste Lesbarkeit auf dem TRMNL X Display.

---

## Rendering-Entscheidungen

- Weißer Hintergrund.
- Schwarze Schrift.
- Keine Icons außer Emojis in Jahrestagen.
- Keine farbabhängigen Elemente.
- Maximale Lesbarkeit auf 16-Graustufen-E-Ink.

---

## Änderungsprotokoll

### V5 Stable (21.08.2026)

- Kalender komplett auf Bullet-Liste umgestellt.
- `<text preserveWhitespace>` entfernt.
- Kompaktere Kalender-Typografie.
- Fettmarkierung von **Hanny**.
- Jahrestage auf 6 Einträge begrenzt.
- Feiertage auf 6 Einträge begrenzt.
- Optimale TRMNL-HA-Parameter dokumentiert.

---

## Status

Diese Version gilt als **Golden Master**.

Neue Experimente erfolgen ausschließlich in:

- dashboard-trmnl-v6.yaml
- dashboard-trmnl-og-v1.yaml

Die Datei `dashboard-trmnl-v5-stable.yaml` wird nicht mehr verändert.
