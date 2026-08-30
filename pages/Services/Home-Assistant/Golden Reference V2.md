# Golden Reference V2

status:: Produktiv
version:: 2.0
projekt:: Homelab
stand:: 2026-08-30

---

# Zweck

Die Golden Reference V2 beschreibt die verbindliche Architektur des Homelab-Projekts.

Sie ist die Referenz für:

- Produktivkonfiguration.
- Projektstruktur.
- Collector-Architektur.
- Dashboard-Architektur.
- TRMNL-Architektur.
- Arbeitsweise innerhalb des Homelab-Projekts.

Änderungen an der Golden Reference erfolgen ausschließlich nach erfolgreicher Projektabnahme.

---

# Architekturübersicht

```text
                        Golden Reference V2
                                │
        ┌───────────────────────┼────────────────────────┐
        │                       │                        │
   Collector                Aggregator               Dashboard
        │                       │                        │
 Docker / QNAP / PVE / HA / Website        TRMNL Views / Karten
        │                       │                        │
        └──────────────► Home Assistant ◄───────────────┘
                                │
                           TRMNL-HA Add-on
                                │
                           Screenshot Rendering
                                │
                              TRMNL X
```

Grundprinzip:

- Collector erzeugen ausschließlich Rohdaten.
- Aggregatoren erzeugen zusammengesetzte Informationen.
- Dashboards konsumieren ausschließlich Aggregatoren bzw. Abstraktionssensoren.
- TRMNL rendert Screenshots des Dashboards.

---

# Projektstruktur

## Produktivsystem

```text
/config/
├── packages/
│   ├── homelab/
│   ├── haghs.yaml
│   └── trmnl-calendar.yaml
├── trmnl/
│   ├── views/
│   ├── cards/
│   └── card-mod/
└── automations.yaml
```

## Golden Reference

```text
/config/golden-reference/
├── ROADMAP.md
├── packages/
├── trmnl/
│   ├── og/
│   │   ├── cards/
│   │   └── card-mod/
│   └── x/
└── ...
```

Regel:

Jede produktive Datei besitzt genau eine Golden Reference.

---

# Collector-Architektur

## Prinzip

Collector liefern ausschließlich Rohdaten.

Keine Dashboard-Logik.

Keine TRMNL-Logik.

Keine Aggregation.

## Standardisierte Collector-Sensoren

Jeder Collector liefert:

| Sensor | Zweck |
|--------|------|
| `*_update_raw` | Rohdaten |
| `*_update_count` | Anzahl Updates |
| `*_update_summary` | Lesbare Zusammenfassung |
| `*_updates_available` | Boolean |

## Implementierte Collector

| Collector | Status |
|-----------|--------|
| Docker | Produktiv |
| QNAP | Produktiv |
| Proxmox | Produktiv |
| Home Assistant | Produktiv |
| Website (WordPress / webtrees) | Produktiv |

---

# Update Aggregator

Produktive Datei:

```text
/config/packages/homelab/update_aggregator.yaml
```

Eigenschaften:

- genau ein Aggregator.
- liest ausschließlich Collector-Sensoren.
- keine Kommunikation zu Collectorn.
- keine REST-Aufrufe.

Der Aggregator erzeugt die Informationen für Dashboard und TRMNL.

---

# Health Score Architektur

## HAGHS

Read Only.

Die Originalintegration bleibt unverändert.

## Homelab Wrapper

Produktive Datei:

```text
/config/packages/haghs.yaml
```

Aufgaben:

- Homelab-spezifische Erweiterungen.
- Zombie-Hygiene.
- Abstraktionssensoren.

Dashboard und TRMNL verwenden ausschließlich:

```text
sensor.homelab_ha_health_percent
```

Nicht den HAGHS-Core direkt.

---

# TRMNL Architektur

## Renderingpfad

```text
Dashboard
    │
    ▼
TRMNL-HA Add-on
    │
Screenshot
    │
    ▼
TRMNL X Display
```

Larapaper rendert keine Blade-Templates für das Homelab-Dashboard.

---

## Views

Produktiv:

- trmnl-og.yaml
- trmnl-x.yaml

## Karten

OG Dashboard:

- homelab
- infra
- updates
- renault

Weitere Karten:

- weather
- calendar
- anniversaries
- holidays

---

# Card-Mod Standard

Seit LAY-001B existiert eine gemeinsame Definition.

## Gemeinsame Datei

```text
/config/trmnl/card-mod/trmnl-card-style.yaml
```

Alle OG-Karten verwenden:

```yaml
card_mod:
  style: !include ../card-mod/trmnl-card-style.yaml
```

Regeln:

- keine CSS-Duplikate.
- gemeinsame Layoutdefinition zentral.
- kartenspezifische CSS-Regeln nur wenn technisch erforderlich.

---

# TRMNL Rendering-Regeln

## Vier feste Message-Zeilen

Update-Karten besitzen immer vier reservierte Zeilen.

## Leere Zeilen

Nicht belegte Zeilen verwenden:

```jinja
{{ '&nbsp;' }}
```

Dadurch bleibt die Kartenhöhe konstant.

## Footer

Der Footer besitzt immer dieselbe vertikale Position.

---

# Dashboard-Standard

## Update-Karte

Anzeigeformat:

```text
Docker-VM 3
Home Assistant 2
ElseLevy7 5
Stammbaum 1
```

Details stammen ausschließlich aus:

```text
*_update_summary
```

## Homelab-Karte

Zeigt ausschließlich abstrahierte Sensoren.

Keine direkte Collector-Logik.

---

# Arbeitsweise (Projektstandard)

Jeder technische Abschnitt beginnt mit genau einer Kennzeichnung.

- ANALYSE
- VORSCHLAG
- AUSFÜHREN

## Reihenfolge

1. Analyse (Read Only).
2. Produktionsartefakt verifizieren.
3. Temporäres Backup nur vor Änderungen an Produktivdateien.
4. Änderungen ausschließlich im vereinbarten Umfang.
5. Verifikation (`ha core check`, Funktionstest).
6. Bereinigung temporärer Artefakte.
7. Projektabnahme.
8. Golden Reference synchronisieren.

---

# Projektfamilien

| Präfix | Bedeutung |
|--------|-----------|
| UPD | Neue Funktion / Collector |
| RF | Refactoring |
| PRÜF | Architektur- oder Konsistenzprüfung |
| CLEANUP | Bereinigung von Artefakten |
| LAY | Dashboard- und Layoutarchitektur |
| DOC | Dokumentation |

---

# Abnahmeprozess

Ein Teilprojekt gilt erst als abgeschlossen, wenn:

- Funktion sichtbar geprüft wurde.
- Verifikation erfolgreich war.
- Artefakte bereinigt wurden.
- Christoph die Abnahme ausdrücklich erteilt hat.
- Ein Abschlussbericht für den Projekt-Master erstellt wurde.

---

# Meilensteine

## M1 — Homelab Update-System V2.0

Abgeschlossen.

Enthält UPD-001 bis UPD-005.

## M2 — Homelab Health Score V2

Abgeschlossen.

Enthält RF-003.

## M3 — Golden Reference V2.0 konsolidiert

Abgeschlossen.

Enthält PRÜF-002 und CLEANUP-001.

## M4 — TRMNL Layout konsolidiert

Abgeschlossen.

Enthält LAY-001A und LAY-001B.

---

# Wartungsregeln

- Produktivdateien und Golden Reference bleiben synchron.
- Neue Architekturregeln werden erst nach Projektabnahme übernommen.
- Jedes Projekt endet mit einer Artefaktprüfung.
- Keine Legacy-Dateien oder Testartefakte verbleiben im Produktivsystem.

