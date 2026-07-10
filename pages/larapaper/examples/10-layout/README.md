# 10 Layout

## Zweck

`<x-trmnl::layout>` bildet den Container eines Views.

Jeder Screen besitzt genau ein Layout.

## Verifiziert

- vertikale Anordnung
- Hero oben
- KPI-Grid unten
- Divider zwischen Bereichen

## Verwendete Attribute

direction="col"

stretch="default"

## Zusammenspiel

screen
└── view
    └── layout
        ├── grid
        ├── divider
        └── title-bar

## Erkenntnisse

Layout selbst erzeugt keinen sichtbaren Inhalt.

Es positioniert ausschließlich Kindkomponenten.
