# TRMNL Pattern Library

## Ziel

Dieses Dokument beschreibt verifizierte Layout- und Designmuster (Patterns) für Larapaper/TRMNL.

Im Gegensatz zu den Komponenten besteht ein Pattern aus mehreren Komponenten.

---

# Pattern

## Hero

### Zweck

Hervorhebung einer einzelnen Kennzahl.

### Aufbau

```
grid (1)

└── col

    └── item

        ├── meta

        └── content

            ├── label

            ├── value (xxxlarge)

            └── label
```

### Verwendete Komponenten

- grid
- col
- item
- meta
- content
- label
- value

### Beispiel

```blade
<x-trmnl::grid cols="1">

    <x-trmnl::col position="center">

        <x-trmnl::item>

            <x-trmnl::meta />

            <x-trmnl::content
                contentAlignment="center"
                textAlignment="center"
                gapSize="large">

                <x-trmnl::label>
                    Home Assistant Health
                </x-trmnl::label>

                <x-trmnl::value
                    size="xxxlarge">

                    91%

                </x-trmnl::value>

                <x-trmnl::label>

                    OK

                </x-trmnl::label>

            </x-trmnl::content>

        </x-trmnl::item>

    </x-trmnl::col>

</x-trmnl::grid>
```

---

# Pattern

## KPI Grid

### Zweck

Darstellung mehrerer Kennzahlen.

### Aufbau

```
grid (5)

├── KPI
├── KPI
├── KPI
├── KPI
└── KPI
```

### Verwendete Komponenten

- grid
- col
- item
- meta
- content
- value
- label

### Eigenschaften

- gleich breite Spalten
- jede KPI besitzt dieselbe Struktur

---

# Pattern

## Dashboard

### Zweck

Kombination mehrerer Bereiche.

### Aufbau

```
layout

├── Hero

├── Divider

└── KPI Grid
```

### Verwendete Komponenten

- layout
- grid
- divider
- title-bar

---

# Pattern

## KPI Card

### Aufbau

```
item

├── meta

└── content

    ├── value

    └── label
```

### Eigenschaften

- klein
- kompakt
- wiederverwendbar

---

# Pattern

## Footer

### Komponente

```
title-bar
```

### Aufgabe

Anzeige von

- Titel
- Logo
- Instanz
- Uhrzeit

---

# Referenzscreen

Der derzeit vollständig verifizierte Referenzscreen kombiniert folgende Patterns:

```
screen

└── view

    └── layout

        ├── Hero

        ├── Divider

        ├── KPI Grid

        └── Title Bar
```

---

# Verifizierte Patterns

| Pattern | Status |
|----------|:------:|
| Hero | ✅ |
| KPI Card | ✅ |
| KPI Grid | ✅ |
| Dashboard | ✅ |
| Footer | ✅ |

---

# Geplante Patterns

- Status List
- Table
- Weather
- Calendar
- Timeline
- Notification
- Multi Page
- Mixed Dashboard
