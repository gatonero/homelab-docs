# Larapaper BYOS API

## Ziel

Definiert die stabile Schnittstelle zwischen Home Assistant und Larapaper.

---

# Datenquelle

sensor.homelab_trmnl_payload

Recipes lesen ausschließlich dessen Attribute.

---

# Pflichtattribute

| Attribut | Typ | Bedeutung |
|----------|-----|-----------|
| health | int | HA Health Score (%) |
| storage | int | Speicherbelegung (%) |
| backup | int | Alter letztes Backup (h) |
| internet | bool | Internet verfügbar |
| nas | bool | NAS erreichbar |
| zigbee | bool | Zigbee2MQTT erreichbar |

---

# Erweiterbare Attribute

| Attribut | Typ |
|----------|-----|
| mqtt | bool |
| battery | int |
| weather_warning | string |
| weather_temperature | float |
| weather_humidity | int |
| calendar_title | string |
| calendar_time | string |
| docker_running | int |
| docker_stopped | int |
| proxmox_status | string |

---

# Architektur

```text
Home Assistant
        │
Template Sensor
        │
sensor.homelab_trmnl_payload
        │
Webhook
        │
Larapaper
        │
Recipe
        │
TRMNL
```

---

# Designregeln

- Home Assistant erzeugt die Daten.
- Larapaper stellt die Daten ausschließlich dar.
- Recipes enthalten keine Geschäftslogik.
- Statusberechnungen erfolgen ausschließlich in Home Assistant.
- Neue Funktionen werden ausschließlich über zusätzliche Attribute eingeführt.
- Bestehende Attribute bleiben unverändert (abwärtskompatibel).

---

# Version

API-Version: 1.0
Status: Stable
