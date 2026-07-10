# Larapaper BYOS -- Phase 2 Erkenntnisse

## Ziel der Analyse

Ziel war es, die Architektur von Larapaper BYOS sowie den praktischen
Einsatz von `laravel-trmnl-blade` anhand eines produktiven
Home-Assistant-Plugins zu verstehen. Alle Erkenntnisse basieren
ausschließlich auf praktisch durchgeführten Tests.

------------------------------------------------------------------------

# Architektur

## Larapaper

-   Rezepte (Recipes) enthalten Blade-Code.
-   Playlists ordnen Recipes Geräten zu.
-   Plugins definieren Datenquelle und Rendering.
-   `laravel-trmnl-blade` stellt Blade-Komponenten für das
    TRMNL-Framework bereit.

## Datenfluss

``` text
Home Assistant
      │
REST API (Polling)
      │
Recipe
      │
Blade Rendering
      │
Playlist
      │
XIAO 7.5" ePaper Panel
```

------------------------------------------------------------------------

# laravel-trmnl-blade

## Komponenten

### screen

-   Zweck: vollständiges HTML-Dokument erzeugen
-   Props: `noBleed`, `darkMode`, `deviceVariant`, `deviceOrientation`,
    `colorDepth`, `scaleLevel`, `fonts`
-   Besonderheit: bindet das offizielle TRMNL Framework (`plugins.css` /
    `plugins.js`) ein.

### view

-   Zweck: Displayfläche
-   Props: `size`
-   HTML: `<div class="view view--...">`

### layout

-   Zweck: Layoutcontainer
-   Props: `direction`, `alignment`, `stretch`
-   HTML: `<div class="layout ...">`

### grid

-   Zweck: Rasterlayout
-   Props: `cols`
-   HTML: `<div class="grid grid--cols-N">`

### column / col

-   Zweck: Spaltenelement
-   Props: `position`, `span`
-   HTML: `<div class="col ...">`

### columns

-   Zweck: gruppiert mehrere Spalten
-   HTML-Wrapper

### value

-   Zweck: Darstellung numerischer Werte
-   Props: `size`, `textStroke`
-   HTML: `<span class="value ...">`

### label

-   Zweck: Beschriftungen
-   Props: `variant`, `size`
-   HTML: `<span class="label ...">`

### title-bar

-   Zweck: Statusleiste
-   Props: `title`, `image`, `instance`
-   HTML: `<div class="title_bar">`

### item

-   Zweck: Container
-   HTML: `<div class="item">`

### table

-   Zweck: Tabellenlayout

### richtext

-   Zweck: typografischer Inhaltsblock

### title

-   Zweck: Überschrift innerhalb eines Inhaltsblocks

### text

-   Zweck: Fließtext

### description

-   Zweck: ergänzende Beschreibung

### divider

-   Zweck: Trennlinie

### mashup

-   Zweck: spezielles Mashup-Layout

------------------------------------------------------------------------

# Tatsächlicher HTML-Aufbau

Verifiziert wurde:

-   `screen` erzeugt vollständiges HTML mit `<html>`, `<head>` und
    `<body>`.
-   `view`, `layout`, `grid`, `item`, `value`, `label` und `title-bar`
    erzeugen einfache HTML-Wrapper mit definierten CSS-Klassen.
-   Die eigentliche Darstellung stammt aus dem TRMNL-Framework, nicht
    aus den Blade-Dateien.

------------------------------------------------------------------------

# CSS / TRMNL Framework

Belastbar festgestellt:

-   Das CSS liegt **nicht** im Laravel-Projekt.
-   `screen.blade.php` bindet das Framework von `trmnl.com` ein.
-   Die Blade-Komponenten erzeugen lediglich die passenden CSS-Klassen.
-   Klassen wie `layout`, `grid`, `value`, `label` oder `title_bar`
    werden vom externen Framework gestaltet.
-   Deshalb waren diese Klassen nicht in `public/build/assets/*.css`
    auffindbar.

Für das XIAO:

-   Produktiv getestet wurde ausschließlich auf dem XIAO 7.5".
-   Die Preview unterstützt verschiedene Geräteprofile.
-   Das XIAO rendert das Plugin zuverlässig.

------------------------------------------------------------------------

# Komponenten, die sich als Sackgasse erwiesen haben

-   Suche nach Framework-CSS innerhalb des Laravel-Projekts.
    -   Ergebnis: Das Styling stammt vom extern eingebundenen
        TRMNL-Framework.
-   Optimierung anhand der Preview allein.
    -   Ergebnis: Maßgeblich ist das Verhalten auf dem echten XIAO.

------------------------------------------------------------------------

# Erkenntnisse zu Recipes

-   Polling gegen externe REST-Endpunkte funktioniert.
-   Authorization Header können verwendet werden.
-   JSON-Daten werden als `$data` bereitgestellt.
-   Blade-Code wird serverseitig ausgewertet.
-   Das erzeugte HTML wird an das Zielgerät übertragen.

------------------------------------------------------------------------

# Erkenntnisse zur Home-Assistant-Anbindung

-   Polling gegen die Home-Assistant-REST-API funktioniert.
-   Bearer-Token im Authorization-Header funktioniert.
-   Die JSON-Struktur des Sensors wurde erfolgreich verarbeitet.
-   Die Daten liegen innerhalb von Blade in `$data`.
-   Für produktive Templates wurde ein schlanker Payload-Sensor
    aufgebaut.

------------------------------------------------------------------------

# Bewährte Entwurfsmuster

Bewährt haben sich:

-   Home Assistant übernimmt Datenaufbereitung.
-   Blade übernimmt ausschließlich Darstellung.
-   Kleine iterative Änderungen mit sofortigem Test auf dem XIAO.
-   Nutzung offizieller `x-trmnl::`-Komponenten.

------------------------------------------------------------------------

# Entscheidungen

-   Zielgerät ausschließlich XIAO 7.5" ePaper Panel.
-   Batterieinformation nicht Bestandteil des Homelab-Payloads.
-   Datenaufbereitung zentral in Home Assistant.
-   Verwendung offizieller `laravel-trmnl-blade`-Komponenten.
-   Entwicklung in kleinen, überprüfbaren Schritten.

------------------------------------------------------------------------

# Offene Punkte für Phase 3

-   Grid-Komponente systematisch analysieren.
-   Weitere Komponenten (`progress`, `track`, `flex`, `table`, `item`)
    untersuchen.
-   Produktives Homelab-Dashboard fertigstellen.
-   Layout vollständig auf TRMNL-Komponenten umstellen.

------------------------------------------------------------------------

# Fazit

Phase 2 hat belastbar gezeigt, dass Larapaper BYOS mit Home Assistant
über REST-Polling zusammenarbeitet, dass `laravel-trmnl-blade` als dünne
Abstraktionsschicht über dem offiziellen TRMNL-Framework fungiert und
dass das XIAO 7.5" ePaper Panel als Produktionsplattform zuverlässig
arbeitet. Die wesentlichen Architekturentscheidungen für Phase 3 wurden
getroffen und die Datenpipeline ist verifiziert.
