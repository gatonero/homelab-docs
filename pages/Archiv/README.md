# Archiv – Homelab Dokumente

Dieses Verzeichnis enthält **archivierte Dokumente** des Homelabs.

Archivierte Inhalte sind **nicht mehr aktiv gültig**, bleiben aber bewusst erhalten,
um Architekturentscheidungen, Betriebsänderungen und historische Kontexte
**nachvollziehbar** zu machen.

---

## Zweck des Archivs

Das Archiv dient dazu:

* frühere Architektur- oder Betriebsstände zu bewahren
* Entscheidungen im zeitlichen Kontext erklärbar zu halten
* Diskussionen über bereits verworfene Ansätze zu vermeiden

> **Archiviert bedeutet: verstanden, abgeschlossen, nicht vergessen.**

---

## Was hier liegt

Im Archiv befinden sich u. a.:

* ersetzte Architekturentscheidungen
* abgeschaltete oder migrierte Services
* frühere Betriebs- oder Restore-Verfahren
* historische Experimente mit Erkenntniswert

Diese Inhalte sind **nicht handlungsleitend** für den aktuellen Betrieb.

---

## Was hier nicht liegt

Nicht ins Archiv gehören:

* aktuelle Dokumentation
* laufende To-dos oder Ideen
* temporäre Notizen
* unfertige Konzepte

Solche Inhalte gehören entweder in aktive Bereiche oder gar nicht ins Repository.

---

## Struktur des Archivs

Das Archiv spiegelt grob die aktive Struktur:

```
Archiv/
├── Architektur/
├── Betrieb/
├── Services/
├── NetBox/
└── README.md
```

Die Unterordner sind **flach gehalten** und dienen ausschließlich der groben Einordnung.

---

## Kennzeichnung archivierter Dateien

Jede archivierte Datei beginnt mit folgendem Hinweis:

```markdown
> ⚠️ **Archiviert**  
> Dieses Dokument beschreibt einen nicht mehr aktiven Stand und dient
> ausschließlich der historischen Nachvollziehbarkeit.
```

Fehlt dieser Hinweis, gilt das Dokument als **nicht korrekt archiviert**.

---

## Umgang mit archivierten Inhalten

* Archivierte Dateien werden **nicht mehr geändert**
* Verweise aus aktiven Dokumenten sind erlaubt, aber klar zu kennzeichnen
* Erkenntnisse aus Archivdokumenten dürfen in neuen Dokumenten **neu formuliert** werden

---

## Archiv und Versionierung

* Git bleibt führend für Versionen
* Das Archiv ergänzt Git um **inhaltliche Ordnung**
* Archivierung ersetzt **keine Tags oder Releases**

---

## Status

* Archiv aktiv genutzt: ja
* Pflegeaufwand: minimal
* Verbindlichkeit: hoch

---

> **Ein gutes Archiv entlastet Gegenwart und Zukunft gleichermaßen.**
