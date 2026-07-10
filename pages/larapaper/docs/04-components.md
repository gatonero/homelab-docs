# TRMNL Blade Components

## Ziel

Dieses Dokument beschreibt ausschließlich verifizierte Eigenschaften der TRMNL-Blade-Komponenten.

Es enthält keine Vermutungen oder geplanten Erweiterungen.

---

# Render Pipeline

Verifiziert:

Plugin::render()

↓

Blade::render()

↓

renderedContent

↓

trmnl-layouts.single

↓

<x-trmnl::screen>

↓

{!! \$slot !!}

Der äußere `<x-trmnl::screen>` wird vom Framework erzeugt.

Plugin-Markup beginnt daher mit `<x-trmnl::view>` und nicht mit `<x-trmnl::screen>`.

---

# Komponenten

## view

### Zweck

Root-Container eines Plugin-Screens.

### Verifiziert

- Einstiegspunkt eines Screens
- Wird innerhalb von `trmnl-layouts.single` gerendert

---

## layout

### Zweck

Layoutcontainer innerhalb einer View.

### Verifiziert

Bekannte Attribute

- direction
- stretch

---

## grid

### Zweck

Grid-Layout.

### Verifiziert

- Komponente vorhanden
- Separate Analyse unter `examples/11-grid`

---

## col

### Zweck

Spalte innerhalb eines Grid.

### Verifiziert

Bekannte Attribute

- position
- span

---

## item

### Zweck

Basiselement für Inhalte.

### Verifiziert

Kann enthalten

- label
- value
- meta
- content

Separate Analyse unter `examples/20-item`.

---

## label

### Zweck

Beschriftung.

### Verifiziert

Bekanntes Attribut

- variant

Bekannte Varianten

- primary
- secondary
- underline
- inverted

Separate Analyse unter `examples/21-label`.

---

## value

### Zweck

Darstellung numerischer oder kurzer Werte.

### Verifiziert

Bekannte Größen

- default
- small
- large
- xlarge
- xxlarge
- xxxlarge

Bekanntes Attribut

- data-fit-value

Analyse in Vorbereitung.

---

## meta

### Zweck

Metabereich innerhalb eines Item.

### Verifiziert

- Komponente vorhanden
- CSS definiert eine feste Breite

Analyse in Vorbereitung.

---

## content

### Zweck

Container innerhalb eines Item.

### Verifiziert

Bekannte Attribute

- contentAlignment
- textAlignment
- gapSize

Analyse in Vorbereitung.

---

## title-bar

### Zweck

Footer eines Screens.

### Verifiziert

- Wird innerhalb von `<x-trmnl::view>` verwendet

---

# Verifizierte Layoutregeln

- Plugin-Markup beginnt mit `<x-trmnl::view>`.
- `<x-trmnl::screen>` wird automatisch vom Framework erzeugt.
- `item` ist die grundlegende Inhaltseinheit.
- `title-bar` befindet sich direkt innerhalb von `view`.
- Blade-Views unter `resources/views` können per `@include()` eingebunden werden.

---

# Referenztests

Die reproduzierbaren Testfälle befinden sich unter:

- examples/01-screen
- examples/10-layout
- examples/11-grid
- examples/12-col
- examples/20-item
- examples/21-label

Weitere Komponenten werden nach Abschluss ihrer Analyse ergänzt.
