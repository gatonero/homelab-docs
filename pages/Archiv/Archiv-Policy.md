# Archiv-Policy – Homelab

**Ablageort (verbindlich):**

```
pages/Archiv/Archiv-Policy.md
```

Diese Archiv-Policy definiert **verbindlich**, welche Inhalte im Homelab
**aktiv gepflegt**, **eingefroren** oder **archiviert** werden.

Ziel ist es, die Dokumentation langfristig **übersichtlich, belastbar und wartbar** zu halten,
ohne historisches Wissen zu verlieren.

---

## Zweck

Diese Policy beantwortet:

* Welche Inhalte gelten als *aktiv*?
* Wann wird ein Dokument archiviert?
* Was bedeutet „archiviert“ konkret?
* Wie wird Archiviertes gekennzeichnet und genutzt?

---

## Grundsatz (verbindlich)

> **Archivieren heißt bewahren – nicht vergessen.**

Archivierte Inhalte sind:

* weiterhin **lesbar**
* **nicht mehr änderbar**
* **nicht mehr handlungsleitend**

---

## Kategorien von Dokumenten

### 1. Aktive Dokumente

**Definition:**
Dokumente, die den **aktuellen Soll-Zustand** beschreiben.

**Beispiele:**

* Architektur-Gesamtüberblick
* Control-Plane-Policy
* NetBox-Arbeitsmodell
* Backup-Overview
* Service-Dokumentationen aktueller Services

**Regeln:**

* dürfen geändert werden
* folgen der v1.x-Policy
* sind handlungsleitend

---

### 2. Archivierte Dokumente

**Definition:**
Dokumente, die **nicht mehr gültig**, aber historisch oder erklärend relevant sind.

**Typische Gründe für Archivierung:**

* Architekturentscheidung wurde ersetzt
* Service wurde abgeschaltet oder migriert
* Betriebsverfahren wurde grundlegend geändert

**Regeln:**

* keine inhaltlichen Änderungen
* nur orthografische Korrekturen im Ausnahmefall
* klar als archiviert gekennzeichnet

---

### 3. Historische Artefakte

**Definition:**
Zeitbezogene Momentaufnahmen ohne Anspruch auf Aktualität.

**Beispiele:**

* frühe Restore-Drills
* alte Setup-Anleitungen
* verworfene Architekturansätze

Diese dienen **nur** der Nachvollziehbarkeit.

---

## Archiv-Struktur (verbindlich)

```
pages/
├── Archiv/
│   ├── README.md
│   ├── Architektur/
│   ├── Betrieb/
│   ├── Services/
│   └── NetBox/
```

**Regeln:**

* Archiv spiegelt grob die aktive Struktur
* keine tiefen Verschachtelungen
* klare, sprechende Dateinamen

---

## Kennzeichnung archivierter Dateien

Jede archivierte Datei erhält **am Anfang** folgenden Block:

```markdown
> ⚠️ **Archiviert**  
> Dieses Dokument beschreibt einen **nicht mehr aktiven Stand** und dient
> ausschließlich der historischen Nachvollziehbarkeit.
```

---

## Archivierungsprozess (verbindlich)

1. Entscheidung treffen (warum archivieren?)
2. Datei in passenden Unterordner unter `pages/Archiv/` verschieben
3. Archiv-Hinweis am Dokumentanfang einfügen
4. Ggf. Verweis im aktiven Dokument ergänzen
5. Git-Commit mit klarer Message

**Beispiel Commit:**

```
archiv: jellyfin alte audio-struktur eingefroren
```

---

## Abgrenzung

* Archiv ersetzt **keine Versionierung** (Git bleibt führend)
* Archiv ersetzt **keine Backups**
* Archivierte Inhalte sind **nicht handlungsleitend**

---

## Status

* Archiv-Regeln: definiert
* Gültigkeit: ab `v1.0-homelab`
* Verbindlichkeit: hoch

---

> **Ein gutes Archiv verhindert Diskussionen mit der Vergangenheit.**
