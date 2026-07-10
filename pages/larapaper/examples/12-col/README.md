# 12 Col

## Zweck

`<x-trmnl::col>` repräsentiert eine einzelne Spalte innerhalb eines Grids.

## Verifiziert

- Darf nur innerhalb eines `grid` verwendet werden.
- Enthält typischerweise genau ein `item`.
- Positionierung erfolgt über das Grid.

## Attribute

### position

Verifiziert:

- center

Weitere Werte bisher nicht verifiziert.

## Zusammenspiel

layout
└── grid
    └── col
        └── item

## Status

Verifiziert
