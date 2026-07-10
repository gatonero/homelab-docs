# Homelab Plugin – hl-health

Stand: Juli 2026

## Zweck

Anzeige des Home-Assistant-Gesundheitszustands.

Datenquelle

    sensor.system_ha_global_health_score

Polling

    Home Assistant REST API

Refresh

    5 Minuten

## Payload

Beispiel

{
    "entity_id": "...",
    "state": "82",
    "attributes": {
        ...
    }
}

## Verwendete Variablen

$data['state']

$trmnl

$config

## Layout

Header

Health Score

Statusbalken

Zeit

