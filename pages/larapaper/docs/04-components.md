# TRMNL Blade Components

## Ziel

Dieses Dokument beschreibt die verifizierten Blade-Komponenten des Pakets `bnussbau/laravel-trmnl-blade`.

Es werden ausschließlich tatsächlich überprüfte Erkenntnisse dokumentiert. Vermutungen sind entsprechend gekennzeichnet oder werden bewusst weggelassen.

---

# Architektur

Die Komponentenbibliothek ist in vier Ebenen aufgebaut:

```
Blade Component
        │
        ▼
HTML + CSS-Klassen
        │
        ▼
plugins.css
        │
        ▼
Darstellung auf dem TRMNL
```

Die Blade-Komponenten enthalten überwiegend wenig Logik. Sie erzeugen HTML und CSS-Klassen. Das eigentliche Layout wird nahezu vollständig durch `plugins.css` bestimmt.

---

# screen

## Aufgabe

Root-Komponente eines TRMNL-Screens.

Sie erzeugt:

- vollständiges HTML-Dokument
- `<head>`
- CSS-Einbindung
- JavaScript-Einbindung
- `<body>`
- `<div class="screen">`

## Blade

```blade
<x-trmnl::screen>

    ...

</x-trmnl::screen>
```

## Verifizierte Props

| Prop | Zweck |
|-------|-------|
| noBleed | Bildschirmrand deaktivieren |
| darkMode | Dark Mode |
| deviceVariant | Gerätemodell (og, x) |
| deviceOrientation | Ausrichtung |
| colorDepth | Farbtiefe |
| scaleLevel | Skalierung |
| fonts | Schriftart |

---

# view

## Aufgabe

Container eines kompletten Views.

## Blade

```blade
<x-trmnl::view size="full">

    ...

</x-trmnl::view>
```

## HTML

```html
<div class="view view--full">
```

## Verifizierte Props

| Prop | Zweck |
|-------|-------|
| size | full, half, quadrant |

---

# layout

## Aufgabe

Positioniert den Inhalt innerhalb eines Views.

## Blade

```blade
<x-trmnl::layout
    direction="col"
    stretch="default">

    ...

</x-trmnl::layout>
```

## Verifizierte Props

| Prop | CSS-Klasse |
|-------|-------------|
| direction | layout--col |
| alignment | layout--... |
| stretch | layout--stretch |

## Erkenntnisse

Layout besitzt eigene Logik zur Erzeugung der CSS-Klassen.

---

# grid

## Aufgabe

Unterteilt ein Layout in Spalten.

## Blade

```blade
<x-trmnl::grid cols="5">

    ...

</x-trmnl::grid>
```

## HTML

```html
<div class="grid grid--cols-5">
```

## Verifizierte Props

| Prop | CSS-Klasse |
|-------|-------------|
| cols | grid--cols-N |

## Erkenntnisse

- mehrere Grids pro Layout möglich
- Spaltenbreiten werden über CSS berechnet

---

# col

## Aufgabe

Eine Spalte innerhalb eines Grid.

## Blade

```blade
<x-trmnl::col position="center">

    ...

</x-trmnl::col>
```

## HTML

```html
<div class="col col--center">
```

## Verifizierte Props

| Prop | CSS-Klasse |
|-------|-------------|
| position | col--center |
| span | col--span-N |

---

# item

## Aufgabe

Container für eine einzelne Informationseinheit.

Typischer Aufbau:

```
item
 ├── meta
 └── content
```

## Blade

```blade
<x-trmnl::item>

    ...

</x-trmnl::item>
```

## HTML

```html
<div class="item">
```

## Props

Keine.

## Erkenntnisse

Die Komponente ist ein reiner Wrapper.

---

# meta

## Aufgabe

Linker Meta-Bereich eines Item.

## Blade

```blade
<x-trmnl::meta />
```

## HTML

```html
<div class="meta">
```

## Props

Keine.

## Erkenntnisse

Die Darstellung wird vollständig über CSS bestimmt.

---

# content

## Aufgabe

Rechter Inhaltsbereich eines Item.

## Blade

```blade
<x-trmnl::content
    contentAlignment="center"
    textAlignment="center"
    gapSize="large">

    ...

</x-trmnl::content>
```

## Verifizierte Props

| Prop | CSS-Klasse |
|-------|-------------|
| contentAlignment | content--... |
| textAlignment | text--... |
| gapSize | gap--... |

## Erkenntnisse

Die Komponente erzeugt dynamisch mehrere CSS-Klassen.

---

# label

## Aufgabe

Beschriftung.

## Blade

```blade
<x-trmnl::label>

    Storage

</x-trmnl::label>
```

## Verifizierte Props

| Prop | CSS-Klasse |
|-------|-------------|
| variant | label--... |
| size | label--... |

---

# value

## Aufgabe

Darstellung eines Wertes.

## Blade

```blade
<x-trmnl::value
    size="xxxlarge">

    91%

</x-trmnl::value>
```

## Verifizierte Props

| Prop | CSS-Klasse |
|-------|-------------|
| size | value--... |
| textStroke | text-stroke--... |

---

# divider

## Aufgabe

Trennlinie zwischen zwei Bereichen.

## Blade

```blade
<x-trmnl::divider />
```

## Props

Keine.

---

# title-bar

## Aufgabe

Fußleiste des Screens.

## Blade

```blade
<x-trmnl::title-bar
    title="Homelab"
    instance="09:42" />
```

## Verifizierte Props

| Prop | Zweck |
|-------|-------|
| title | Titel |
| image | Logo oder Inline-Inhalt |
| instance | rechte Anzeige |

## Erkenntnisse

Die Komponente enthält interne Logik für

- Standardlogo
- eigenes Bild
- Inline-Slot
- Titel
- Instanz

---

# Komponentenhierarchie

```
screen
└── view
    └── layout
        ├── grid
        │   └── col
        │       └── item
        │           ├── meta
        │           └── content
        │               ├── label
        │               └── value
        ├── divider
        └── title-bar
```

---

# Verifizierungsstatus

| Komponente | Blade | CSS | Praxis |
|------------|:-----:|:---:|:------:|
| screen | ✅ | ✅ | ✅ |
| view | ✅ | ✅ | ✅ |
| layout | ✅ | ✅ | ✅ |
| grid | ✅ | ✅ | ✅ |
| col | ✅ | ✅ | ✅ |
| item | ✅ | ✅ | ✅ |
| meta | ✅ | ✅ | ✅ |
| content | ✅ | ✅ | ✅ |
| label | ✅ | ✅ | ✅ |
| value | ✅ | ✅ | ✅ |
| divider | ✅ | ✅ | ✅ |
| title-bar | ✅ | ✅ | ✅ |

---

# Fazit

Die TRMNL-Blade-Komponenten sind bewusst schlank implementiert. Sie dienen hauptsächlich dazu, semantische HTML-Strukturen und CSS-Klassen zu erzeugen. Die eigentliche Darstellung, Positionierung und Typografie wird nahezu vollständig durch `plugins.css` gesteuert.

Damit bildet `plugins.css` den zentralen Bestandteil des TRMNL-Frameworks, während die Blade-Komponenten eine deklarative und leicht lesbare API bereitstellen.
