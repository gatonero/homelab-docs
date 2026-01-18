# Arbeits- und Dokumentationsrichtlinien – Homelab

## Zweck

Dieses Dokument definiert die **verbindlichen Arbeits‑, Dokumentations‑ und Übergaberegeln** für das Homelab‑Repository. Es stellt sicher, dass Inhalte **logseq‑konfliktfrei**, **git‑tauglich**, **wartbar** und **langfristig konsistent** bleiben.

Dieses Dokument ist **maßgeblich**. Abweichungen sind dokumentationspflichtig.

---

## 1. Grundsatz

* Es wird **immer genau eine vollständige Markdown‑Datei** erzeugt oder geändert.
* Keine Stückelung.
* Keine Vermischung von Dokument‑ und Erklärungstext.
* Jedes Dokument ist für sich **vollständig, eindeutig und reproduzierbar**.

---

## 2. Logseq‑Regeln (verbindlich)

### 2.1 Eindeutige Seitentitel

* **Jeder Seitentitel ist global eindeutig.**
* Gleiche Titel in unterschiedlichen Verzeichnissen sind **nicht erlaubt**.

**Namensschema für Überschriften (H1):**

```
# <Bereich> – <Kontext> – <Zweck>
```

**Beispiele:**

* `# Architektur – Overview`
* `# Netzwerk · DNS · TLS – Overview`
* `# Services – Backup – Overview`

---

## 3. Dateibenennung & Struktur

### 3.1 Verzeichnisstruktur

```
Homelab/
├── pages/
│   ├── 00-Overview-Homelab.md
│   ├── Architektur/
│   ├── Betrieb/
│   ├── NetBox/
│   ├── Netzwerk-DNS-TLS/
│   ├── Services/
│   └── Archiv/
```

### 3.2 Overview‑Dateien

* Pro Bereich **genau eine** Overview‑Datei
* Dateiname:

```
Overview-<Bereich>.md
```

* Titel **entspricht dem Bereich**, nicht dem Dateinamen

---

## 4. Dokumentarten

### 4.1 Architektur‑Dokumente

* Beschreiben **Warum** und **Prinzipien**
* Keine Schritt‑für‑Schritt‑Anleitungen

### 4.2 Betriebs‑ und Restore‑Dokumente

* Reproduzierbar
* Ohne Annahmen
* Ohne implizites Wissen

### 4.3 Service‑Dokumente

* Klare Abgrenzung zwischen:

  * Entry‑Point
  * Reverse Proxy
  * Backend

---

## 5. Git‑Regeln

### 5.1 Commits

* Kleine, thematisch geschlossene Commits
* Aussagekräftige Commit‑Messages

### 5.2 Releases

* Semantische Tags:

```
v1.x-homelab
```

* Ein Release markiert **einen stabilen Dokumentationsstand**, keinen Work‑in‑Progress

---

## 6. Archiv‑Policy

* Veraltete, aber historisch relevante Dokumente werden **verschoben**, nicht gelöscht
* Zielverzeichnis:

```
pages/Archiv/
```

* Archiv‑Dokumente werden **nicht aktiv gepflegt**

---

## 7. Zusammenarbeit mit Assistenzsystemen

Für jede neue Aufgabe ist explizit anzugeben:

* Ziel‑Datei (Pfad + Name)
* Neu anlegen **oder** aktualisieren
* Ob Git‑Befehle benötigt werden

Ohne diese Angaben erfolgt **keine Erstellung**.

---

## 8. Gültigkeit

* Diese Regeln gelten **ab sofort**
* Änderungen an dieser Datei sind versions‑ und begründungspflichtig

---

**Status:** verbindlich · geprüft · freigegeben
