# Larapaper BYOS -- Analyseplan der TRMNL-Komponenten

## Ziel

Für den Aufbau eines produktionsreifen Homelab-Plugins sollen die
TRMNL-Blade-Komponenten nicht gleichzeitig untersucht werden.
Stattdessen erfolgt die Analyse schrittweise in einer festen
Reihenfolge, wobei jede Komponente vollständig verstanden wird, bevor
die nächste hinzukommt.

------------------------------------------------------------------------

# Analyse-Reihenfolge

1.  `grid.blade.php`
2.  `value.blade.php`
3.  `label.blade.php`
4.  `title-bar.blade.php`

Diese Reihenfolge ist bewusst gewählt und bildet die Grundlage für alle
weiteren Plugin-Entwicklungen.

------------------------------------------------------------------------

# 1. grid.blade.php

## Warum zuerst?

Mit `grid` steht und fällt praktisch das gesamte Dashboard.

Diese Komponente entscheidet über:

-   die Position aller Informationen
-   Anzahl der Spalten
-   Anordnung der Kacheln
-   Lesbarkeit
-   Ausnutzung der Displayfläche
-   Skalierbarkeit des Layouts

## Fragen, die beantwortet werden sollen

-   Welche CSS-Klassen erzeugt `grid`?
-   Welche Attribute unterstützt die Komponente?
-   Wie viele Spalten sind möglich?
-   Können Grid-Elemente verschachtelt werden?
-   Wie verhält sich `grid` auf unterschiedlichen Geräten?
-   Wann ist `grid` sinnvoller als `columns`?

## Erwartetes Ergebnis

Ein belastbares Raster, das als Basis für sämtliche Homelab-Dashboards
dient.

------------------------------------------------------------------------

# 2. value.blade.php

## Ziel

Analyse der Darstellung numerischer Werte.

## Fragen

-   Welche Größen (`size`) existieren?
-   Welche Auswirkungen hat `textStroke`?
-   Welche CSS-Klassen werden erzeugt?
-   Wie lassen sich große Kennzahlen optimal darstellen?
-   Welche Kombinationen eignen sich für Health, Storage oder Backup?

## Erwartetes Ergebnis

Einheitliche Darstellung aller Messwerte.

------------------------------------------------------------------------

# 3. label.blade.php

## Ziel

Analyse der Beschriftungen.

## Fragen

-   Welche Varianten (`variant`) existieren?
-   Welche Größen (`size`) werden unterstützt?
-   Wie werden Labels optimal mit `value` kombiniert?
-   Welche Typografie ist für Dashboards geeignet?

## Erwartetes Ergebnis

Ein konsistentes Erscheinungsbild aller Bezeichnungen.

------------------------------------------------------------------------

# 4. title-bar.blade.php

## Ziel

Analyse der Statusleiste.

## Fragen

-   Welche Parameter werden unterstützt?
-   Wie funktioniert `title`?
-   Wie funktioniert `instance`?
-   Wann kann ein eigenes Logo verwendet werden?
-   Welche Informationen gehören dauerhaft in die Statusleiste?

## Erwartetes Ergebnis

Eine einheitliche Statusleiste für alle Homelab-Plugins.

------------------------------------------------------------------------

# Warum diese Reihenfolge?

Die Reihenfolge orientiert sich an der Bedeutung für das Gesamtlayout:

1.  **Grid** definiert die Struktur.
2.  **Value** definiert die wichtigsten Informationen.
3.  **Label** ergänzt die Werte verständlich.
4.  **Title-Bar** vervollständigt das Plugin.

Erst wenn diese vier Komponenten vollständig verstanden sind, lohnt sich
die Untersuchung weiterer Komponenten wie `progress`, `table`, `track`,
`flex` oder `richtext`.

------------------------------------------------------------------------

# Ergebnis von Phase 2

Für Phase 3 wird folgende Strategie verfolgt:

-   Komponenten einzeln analysieren.
-   Erkenntnisse dokumentieren.
-   Sofort praktisch im Homelab-Plugin anwenden.
-   Keine unnötige Komplexität durch parallele Untersuchungen.

Der Schwerpunkt liegt zunächst eindeutig auf **`grid.blade.php`**, da
diese Komponente die Grundlage des gesamten Dashboard-Layouts bildet.
