# Namenskonvention & Datei-Policy

## Zweck

Dieses Dokument definiert die **verbindlichen Regeln** für Dateinamen, Ordnerstruktur und Dokumenttypen in diesem Repository.

Ziel ist:

* langfristige Wartbarkeit
* eindeutige Orientierung (auch unter Stress)
* saubere Git-Historie
* problemlose Nutzung mit Logseq

Diese Regeln sind **verbindlich für alle bestehenden und zukünftigen Dateien**.

---

## 1. Grundprinzipien

* Dateinamen sind **stabiler als Inhalte**
* Namen dienen der **Navigation**, nicht der Beschreibung jedes Details
* Konsistenz ist wichtiger als sprachliche Perfektion
* Keine impliziten Bedeutungen

---

## 2. Sprache & Zeichensatz

### Sprache

* Dokumente: **Deutsch**
* Fachbegriffe: Englisch, wenn etabliert (z. B. DNS, TLS, Backend)

### Zeichensatz

* UTF-8
* **keine Sonderzeichen** in Dateinamen
* keine Umlaute, keine Akzente
* keine Backticks, Klammern oder Sonder-Symbole

---

## 3. Dateinamen – verbindliches Schema

### Allgemeine Regeln

* ausschließlich Kleinbuchstaben
* Wörter mit Bindestrich `-` trennen
* keine Leerzeichen
* keine Versionsnummern im Dateinamen

### Erlaubt

```
architektur-gesamt.md
lokales-ssl-home-arpa.md
service-onboarding.md
```

### Verboten

```
Lokales SSL Setup.md
netbox_doku_final_v3.md
README (final).md
```

---

## 4. Ordnerstruktur

* Jeder Ordner enthält **genau eine** `00-overview.md`
* Weitere Dateien sind thematisch untergeordnet
* Keine verschachtelten Unterordner ohne Notwendigkeit

Die Ordnerstruktur ist **Teil der Architektur**.

---

## 5. Dokumenttypen

### 00-Overview.md

* Einstiegspunkt eines Ordners
* normativ und navigational
* keine Anleitungen
* keine Codeblöcke

### Architektur-Dokumente

* beschreiben Prinzipien und Entscheidungen
* ändern sich selten
* keine Schritt-für-Schritt-Anleitungen

### Betriebs-Dokumente

* klar, linear, checklistenartig
* für Nutzung unter Zeitdruck
* keine Hintergrunddiskussionen

### Service-Dokumente

* beschreiben eine konkrete Umsetzung
* folgen immer dem Service-Onboarding
* enthalten nur servicespezifische Abweichungen

---

## 6. Dateiinhalt – formale Regeln

* genau **ein Thema pro Datei**
* klare Überschriftenhierarchie
* keine Vermischung von Architektur und Betrieb
* Merksätze explizit kennzeichnen

---

## 7. Änderungen & Versionierung

* Änderungen erfolgen **inhaltlich**, nicht durch neue Dateien
* keine Kopien oder Varianten
* Historie gehört ins Git, nicht in den Dateinamen

---

## 8. Review-Regeln

* jede strukturelle Änderung benötigt Review
* Architekturänderungen sind dokumentationspflichtig
* bei Unklarheit: **nicht ändern**, sondern klären

---

## Merksätze

* Dateinamen sind Teil der Architektur
* Ordnung schlägt Vollständigkeit
* Was nicht auffindbar ist, existiert nicht

---

## Status

* verbindlich
* repo-weit gültig
* Grundlage für Git-Nutzung
