# Larapaper BYOS -- Phase 2: TRMNL-Komponenten

## Ziel

Dokumentation der in Phase 2 untersuchten TRMNL-Blade-Komponenten sowie
der daraus gewonnenen Erkenntnisse für die Entwicklung produktiver
Larapaper-Plugins.

------------------------------------------------------------------------

# Grundstruktur

Ein vollständiges Plugin besteht typischerweise aus:

``` blade
<x-trmnl::screen>
    <x-trmnl::view>
        <x-trmnl::layout>

            <!-- Inhalt -->

        </x-trmnl::layout>

        <x-trmnl::title-bar
            title="Homelab"
            instance="{{ now()->format('H:i') }}"
        />
    </x-trmnl::view>
</x-trmnl::screen>
```

------------------------------------------------------------------------

# Verwendete Komponenten

## `<x-trmnl::screen>`

Aufgabe:

-   erzeugt das HTML-Grundgerüst
-   bindet TRMNL Framework CSS und JavaScript ein
-   unterstützt Device Variant, Color Depth, Orientation und Fonts

Typischer Einsatz:

``` blade
<x-trmnl::screen>
    ...
</x-trmnl::screen>
```

------------------------------------------------------------------------

## `<x-trmnl::view>`

Aufgabe:

-   definiert die eigentliche Displayfläche

Typischer Einsatz:

``` blade
<x-trmnl::view>
    ...
</x-trmnl::view>
```

------------------------------------------------------------------------

## `<x-trmnl::layout>`

Aufgabe:

-   Hauptcontainer für das Seitenlayout

Typischer Einsatz:

``` blade
<x-trmnl::layout>
    ...
</x-trmnl::layout>
```

------------------------------------------------------------------------

## `<x-trmnl::columns>`

Aufgabe:

-   erzeugt ein horizontales Spaltenlayout

Verwendung:

``` blade
<x-trmnl::columns>

    <x-trmnl::column>
        ...
    </x-trmnl::column>

    <x-trmnl::column>
        ...
    </x-trmnl::column>

</x-trmnl::columns>
```

Geeignet für:

-   zwei Kennzahlen
-   links/rechts Layout
-   Vergleichsansichten

------------------------------------------------------------------------

## `<x-trmnl::column>`

Aufgabe:

-   einzelne Spalte innerhalb von `columns`

Typische Inhalte:

-   Label
-   Value
-   Text
-   Grid

------------------------------------------------------------------------

## `<x-trmnl::grid>`

Aufgabe:

-   Rasterlayout

Eigenschaften:

-   unterstützt mehrere Spalten
-   eignet sich für Dashboard-Kacheln

Geplanter Einsatz:

-   Internet
-   NAS
-   Zigbee
-   Storage
-   Backup
-   Health

------------------------------------------------------------------------

## `<x-trmnl::label>`

Aufgabe:

-   Beschriftung

Eigenschaften:

-   variant
-   size

Beispiel:

``` blade
<x-trmnl::label>
Storage
</x-trmnl::label>
```

------------------------------------------------------------------------

## `<x-trmnl::value>`

Aufgabe:

-   Darstellung numerischer Werte

Eigenschaften:

-   size
-   textStroke

Beispiel:

``` blade
<x-trmnl::value size="large">
92%
</x-trmnl::value>
```

------------------------------------------------------------------------

## `<x-trmnl::title-bar>`

Aufgabe:

-   Statusleiste am unteren Rand

Eigenschaften:

-   title
-   instance
-   optionales Bild

Beispiel:

``` blade
<x-trmnl::title-bar
    title="Homelab"
    instance="{{ now()->format('H:i') }}"
/>
```

------------------------------------------------------------------------

# Weitere verfügbare Komponenten

Während Phase 2 identifiziert:

-   aspect
-   background
-   clamp
-   content
-   description
-   divider
-   flex
-   item
-   markdown
-   mashup
-   meta
-   progress
-   richtext
-   table
-   text
-   title
-   track

Diese wurden noch nicht praktisch untersucht.

------------------------------------------------------------------------

# Erkenntnisse

-   Die Blade-Komponenten kapseln das TRMNL Design Framework.
-   Eigenes HTML ist möglich, sollte jedoch nur ergänzend eingesetzt
    werden.
-   `columns` eignet sich für einfache horizontale Aufteilungen.
-   `grid` ist für Dashboard-Layouts besser geeignet.
-   `value` besitzt bereits vordefinierte Größen und Typografie.
-   `title-bar` sorgt automatisch für ein konsistentes Erscheinungsbild.

------------------------------------------------------------------------

# Entscheidungen aus Phase 2

-   Entwicklung ausschließlich für das XIAO 7.5" ePaper Panel.
-   Verwendung der offiziellen `laravel-trmnl-blade`-Komponenten.
-   Keine Optimierung für TRMNL X oder OG.
-   Iterative Entwicklung mit Preview und anschließendem Test auf dem
    XIAO.

------------------------------------------------------------------------

# Geplanter Einsatz in Phase 3

-   `screen`
-   `view`
-   `layout`
-   `grid`
-   `label`
-   `value`
-   `title-bar`

Diese Komponenten bilden die Basis des produktiven Homelab-Plugins.
