# Larapaper BYOS -- Phase 2

## Ziel

Aufbau einer lokalen Larapaper-BYOS-Instanz und systematisches
Verständnis der Plugin-, Recipe- und Playlist-Architektur mit Fokus auf
dem Seeed Studio XIAO 7.5" ePaper Panel.

## Architektur

-   Home Assistant → `sensor.homelab_trmnl_payload`
-   REST API (Polling)
-   Larapaper Recipe
-   Blade Template
-   Playlist
-   XIAO 7.5" ePaper Panel

## Home-Assistant-Payload

State: - OK

Attribute: - ha_health - storage_percent - backup_age_hours - internet -
nas - zigbee

Die Batterieinformation wurde bewusst entfernt, da sie
TRMNL-X-spezifisch ist.

## TRMNL-Blade-Komponenten

-   `<x-trmnl::screen>`
-   `<x-trmnl::view>`
-   `<x-trmnl::layout>`
-   `<x-trmnl::columns>`
-   `<x-trmnl::column>`
-   `<x-trmnl::grid>`
-   `<x-trmnl::label>`
-   `<x-trmnl::value>`
-   `<x-trmnl::title-bar>`

## Erkenntnisse aus den Blade-Dateien

### screen

-   bindet Framework-CSS und JavaScript
-   definiert Gerätevariante, Farbtiefe und HTML-Rahmen

### view

-   definiert die Bildschirmfläche

### layout

-   zentraler Layout-Container

### value

-   unterstützt Größen (`size="large"`)

### label

-   unterstützt Varianten und Größen

### title-bar

-   Statusleiste mit Titel und Instanz

## Bekannte Besonderheiten

-   Die Preview kann verschiedene Zielgeräte simulieren.
-   Produktiv wird ausschließlich auf dem XIAO getestet.
-   Daten liegen unter `data['attributes']`.
-   Layout und Datenzugriff sollten getrennt entwickelt werden.

## Getroffene Entscheidungen

-   Ausschließliches Zielgerät: XIAO 7.5" ePaper Panel
-   Iterative Entwicklung
-   Verwendung der offiziellen `laravel-trmnl-blade`-Komponenten
-   Zentrale Datenquelle: `sensor.homelab_trmnl_payload`

## Offene Punkte für Phase 3

-   Datenzugriff vereinheitlichen
-   Vollständige Umstellung auf TRMNL-Komponenten
-   Statusindikatoren Internet, NAS und Zigbee
-   Optimierung für das XIAO-Display
