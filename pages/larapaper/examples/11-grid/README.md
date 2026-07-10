# 11 Grid

## Zweck

<x-trmnl::grid> unterteilt ein Layout in Spalten.

## Verifiziert

- cols bestimmt die Anzahl der Spalten.
- grid enthält ausschließlich x-trmnl::col.
- Die Breite der Spalten wird automatisch berechnet.
- Grid kann mehrfach innerhalb eines Layouts verwendet werden.

## Beobachtungen

cols="1"

- Hero
- Full Width

cols="5"

- KPI-Grid
- fünf gleich breite Spalten

## Zusammenspiel

layout
└── grid
    └── col
        └── item

## Status

Verifiziert
