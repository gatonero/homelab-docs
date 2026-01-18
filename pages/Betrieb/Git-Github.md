# Git / GitHub – Betrieb & Replikation

**Datei:** `pages/Betrieb/Git-GitHub.md`

Dieses Dokument beschreibt das **verbindliche Git- und GitHub-Modell** für die Homelab-Dokumentation.

Git dient der **Versionssicherung, Nachvollziehbarkeit und externen Replikation** – **nicht** als Backup-Ersatz.

---

## Zweck

Dieses Dokument beantwortet:

* Wie ist das Repository strukturiert?
* Wie wird mit Änderungen umgegangen?
* Wann wird committed?
* Wie erfolgt die Anbindung an GitHub?

---

## Grundprinzipien (verbindlich)

* Git ist **readable history**, kein Arbeitsnotizbuch
* Jede Änderung ist **inhaltlich abgeschlossen**, bevor sie committed wird
* Commits sind **klein, verständlich und reproduzierbar**
* GitHub ist **Spiegel**, nicht Arbeitsverzeichnis

---

## Repository-Struktur

```
Homelab/
├── pages/
│   ├── 00-Overview-Homelab.md
│   ├── Architektur/
│   ├── Betrieb/
│   ├── NetBox/
│   ├── Netzwerk-DNS-TLS/
│   └── Services/
├── assets/
├── journals/
└── files/
```

**Regeln:**

* Nur Markdown (`.md`) unter `pages/`
* Keine Binärdateien in Git
* Assets nur, wenn referenziert

---

## Commit-Regeln

### Wann committen?

* nach **inhaltlich abgeschlossener Änderung**
* nach Review
* nach Architektur- oder Betriebsentscheidung

### Wann nicht committen?

* während Experimenten
* bei halbfertigen Gedanken
* bei lokalem Debugging

---

## Commit-Nachrichten (Schema)

```
<bereich>: <kurze, sachliche Beschreibung>
```

**Beispiele:**

* `architektur: control-plane klar abgegrenzt`
* `betrieb: backup-overview ergänzt`
* `services: jellyfin audio setup dokumentiert`

---

## GitHub-Anbindung

### Ziel

* Externe Sicherung
* Versionshistorie
* Nachvollziehbarkeit

### Regeln

* `main` ist **stabiler Stand**
* Keine Force-Pushes
* Keine Work-in-Progress-Commits

---

## Abgrenzung

* Git ersetzt **kein Backup**
* Git ersetzt **keinen Restore-Test**
* Git ist **Dokumentation**, nicht Betriebszustand

---

## Status

* Git-Modell: definiert
* GitHub-Anbindung: vorgesehen
* Verbindlichkeit: hoch

---

> **Git bewahrt Entscheidungen – Backups bewahren Systeme.**
