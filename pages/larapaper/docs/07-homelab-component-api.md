# Homelab Component API

## Ziel

Dieses Dokument definiert die öffentliche API der Homelab-Komponenten.

Die API soll stabil bleiben, auch wenn sich Larapaper oder TRMNL intern ändern.

---

# Architektur

```
Home Assistant
        │
        ▼
Recipe
        │
        ▼
Homelab Components
        │
        ▼
TRMNL Components
```

Recipes verwenden ausschließlich Homelab-Komponenten.

TRMNL-Komponenten werden nur innerhalb der Homelab-Komponenten verwendet.

---

# Dashboard

```blade
<x-homelab::dashboard>

    ...

</x-homelab::dashboard>
```

---

# Hero

```blade
<x-homelab::hero
    title="Home Assistant Health"
    value="91"
    unit="%"
    status="OK" />
```

## Parameter

| Parameter | Typ | Beschreibung |
|-----------|-----|--------------|
| title | string | Überschrift |
| value | number|string | Hauptwert |
| unit | string | Einheit |
| status | string | OK, WARN, ERROR |

---

# KPI

```blade
<x-homelab::kpi
    label="Storage"
    value="61"
    unit="%"
    state="OK" />
```

## Parameter

| Parameter | Typ |
|-----------|-----|
| label | string |
| value | mixed |
| unit | string |
| state | string |

---

# Status

```blade
<x-homelab::status
    label="Internet"
    state="OK" />
```

---

# Weather

```blade
<x-homelab::weather
    temperature="21"
    condition="Cloudy"
    warning="None" />
```

---

# Calendar

```blade
<x-homelab::calendar
    :events="$events" />
```

---

# Dashboard-Beispiel

```blade
<x-homelab::dashboard>

    <x-homelab::hero
        title="Home Assistant"
        value="91"
        unit="%"
        status="OK" />

    <x-homelab::kpi
        label="Storage"
        value="61"
        unit="%"
        state="OK" />

    <x-homelab::kpi
        label="Backup"
        value="4"
        unit="h"
        state="OK" />

    <x-homelab::status
        label="Internet"
        state="OK" />

</x-homelab::dashboard>
```

---

# Regeln

- Komponenten enthalten keine Business-Logik.
- Komponenten greifen nicht direkt auf Home Assistant zu.
- Komponenten erhalten fertige Werte.
- Komponenten erzeugen ausschließlich Darstellung.
