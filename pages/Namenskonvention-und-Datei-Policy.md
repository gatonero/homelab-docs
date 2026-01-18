# Namenskonvention und Datei-Policy

Dieses Dokument definiert **verbindliche Regeln** für Dateinamen, Seitentitel und Struktur
im Homelab-Dokumentations-Repository.

Ziel ist eine **dauerhaft konfliktfreie Nutzung** mit:

* Git
* Logseq
* Markdown-Editoren

Diese Regeln sind **verbindlich für alle bestehenden und zukünftigen Dateien**.

---

## 1. Grundprinzipien

* **Eine Datei = eine Seite**
* **Ein global eindeutiger Seitentitel (`# …`)**
* **Git ist führend, Logseq ist Darstellung**
* **Struktur schlägt Bequemlichkeit**

Alles, was diese Prinzipien verletzt, gilt als **Fehlkonfiguration**.

---

## 2. Seitentitel (H1) – kritisch

### Verbindliche Regeln

* Jede Markdown-Datei beginnt mit **genau einer** H1-Überschrift (`#`)
* Dieser Titel ist **global eindeutig** im gesamten Repository
* Ordnernamen spielen **keine Rolle** für Logseq

### Verboten

* identische Titel in mehreren Dateien
* generische Titel wie:

  * `# Overview`
  * `# 00-Overview`
  * `# Notes`

### Erlaubt / empfohlen

* sprechende Titel mit Kontext:

  * `# Architektur – Overview`
  * `# NetBox – Arbeitsmodell`
  * `# Betrieb – Restore-Drill`

---

## 3. Dateinamen

### Allgemeine Regeln

* keine Leerzeichen
* keine Sonderzeichen außer `-`
* UTF‑8 ist erlaubt
* Endung immer `.md`

### Empfohlenes Schema

* Inhalte: `Klarer-Name.md`
* Overviews: `Overview-<Bereich>.md`

### Beispiele

| Zweck                 | Dateiname                     |
| --------------------- | ----------------------------- |
| Architektur-Übersicht | `Overview-Architektur.md`     |
| Service-Doku          | `Jellyfin.md`                 |
| Richtlinie            | `Control-Plane-Policy-NPM.md` |

---

## 4. Ordnerstruktur

Die Ordnerstruktur bildet **Themenbereiche**, nicht Seitenidentitäten.

```text
pages/
├── Architektur/
├── Betrieb/
├── NetBox/
├── Netzwerk-DNS-TLS/
├── Services/
```

### Regeln

* Dateien dürfen **verschoben**, aber nicht dupliziert werden
* Overviews liegen **immer im jeweiligen Ordner**
* Es gibt **keine** mehrfach verwendeten `00-Overview.md`

---

## 5. Logseq-spezifische Regeln

* Logseq nutzt den **Seitentitel**, nicht den Dateinamen
* Gleichlautende Titel führen zu:

  * Importfehlern
  * übersprungenen Seiten
  * inkonsistenten Graphen

### Nach strukturellen Änderungen

Pflichtschritte:

1. Logseq schließen
2. Lokales Verzeichnis `logseq/` löschen
3. Logseq neu starten und neu indexieren

---

## 6. Git-Regeln

* Versioniert werden:

  * `pages/`
  * `assets/`
  * `files/`

* Niemals versioniert werden:

  * `logseq/`
  * `journals/`

* Jede strukturelle Änderung:

  * eigener Commit
  * sprechende Commit-Message

---

## 7. Kontrollfragen vor neuen Dateien

Vor dem Anlegen einer neuen Datei müssen alle Fragen mit **Ja** beantwortet sein:

* Ist der Seitentitel eindeutig?
* Ist der Dateiname eindeutig?
* Passt die Datei thematisch in genau **einen** Ordner?
* Wird keine bestehende Seite logisch dupliziert?

Wenn nicht: **nicht anlegen**.

---

## 8. Merksatz

> **In Logseq ist der Titel der Primärschlüssel.**
> **In Git ist die Datei der Primärschlüssel.**

Beides muss eindeutig sein – immer.
