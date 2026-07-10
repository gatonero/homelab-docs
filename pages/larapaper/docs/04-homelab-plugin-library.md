# LaraPaper BYOS – Homelab Plugin Library

Stand: Juli 2026

## Ziel

Aufbau einer wiederverwendbaren Bibliothek von Homelab-Plugins.

Jedes Plugin

- besitzt genau eine Aufgabe
- besitzt genau eine Datenquelle
- besitzt genau eine Darstellung
- kann einzeln oder als Mashup verwendet werden

---

## Plugin-Übersicht

| Plugin | Datenquelle | Status |
|---------|-------------|--------|
| Homelab Health | Home Assistant | geplant |
| Homelab Storage | Home Assistant | geplant |
| Homelab Backup | Home Assistant | geplant |
| Internet Status | Home Assistant | geplant |
| Wetter | Home Assistant / DWD | geplant |
| Kalender | Home Assistant | geplant |
| Geburtstage | Home Assistant | geplant |
| TRMNL Status | Home Assistant | geplant |

---

## Designprinzipien

- Ein Plugin = eine Verantwortung
- Keine Logik im Markup
- Daten ausschließlich über data_payload
- Einheitliches Erscheinungsbild
- Mashups kombinieren fertige Plugins

