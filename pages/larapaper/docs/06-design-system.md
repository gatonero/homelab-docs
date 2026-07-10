# Larapaper Design System

## Ziel

Dieses Dokument definiert die Gestaltungsregeln für alle zukünftigen Homelab-Plugins.

Es beschreibt keine technischen Komponenten, sondern Konventionen.

---

# Grundprinzipien

- Wiederverwendbare Komponenten
- Einheitliche Typografie
- Einheitliche Abstände
- Keine Inline-CSS
- Keine Duplikate
- Blade vor HTML
- Daten und Darstellung trennen

---

# Layout

Ein Screen besteht aus

```
screen
└── view
    └── layout
```

Innerhalb eines Layouts werden ausschließlich

- grid
- divider
- title-bar

platziert.

---

# Hero

Verwendung

- wichtigste Kennzahl
- maximal ein Hero pro Screen

Aufbau

```
label

value

label
```

---

# KPI

Jede KPI besitzt dieselbe Struktur.

```
item

├── meta

└── content

    ├── value

    └── label
```

---

# Dashboard

Reihenfolge

```
Hero

Divider

KPI Grid

Footer
```

---

# Typografie

Hero

```
value

size="xxxlarge"
```

KPI

```
value

Standardgröße
```

Beschriftungen

```
label
```

---

# Daten

Alle Daten werden ausschließlich aus

```
$data
```

gelesen.

Keine Datenbankabfragen.

Keine HTTP-Aufrufe.

Keine Business-Logik.

---

# Komponenten

Eigene Komponenten kapseln ausschließlich Darstellung.

Keine Sensorlogik.

Keine API-Logik.

---

# Benennung

Komponenten

```
hero-health

kpi-storage

kpi-backup

weather-card

calendar-card
```

Recipes

```
homelab-status

weather

calendar
```

---

# Git

Jede neue Komponente besitzt

- Blade-Datei
- Screenshot
- README

Jede Änderung wird unmittelbar versioniert.

---

# Qualitätsregeln

Eine Komponente gilt erst als abgeschlossen wenn

- sie dokumentiert ist
- ein Screenshot existiert
- sie im Referenzscreen verwendet wurde
- sie im Git versioniert ist
