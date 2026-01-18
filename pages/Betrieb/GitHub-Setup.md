# GitHub-Setup & Workflow für das Homelab-Repository

Dieses Dokument beschreibt das **verbindliche Vorgehen**, um das Homelab-Dokumentations-Repository
auf GitHub zu veröffentlichen und dauerhaft sauber zu betreiben.

Es ergänzt die lokale Git-Nutzung um:

* ein Remote Repository
* einen klaren Push-Workflow
* empfohlene Sicherheits- und Betriebsregeln

---

## Ziel

* Zentrale, externe Ablage der Dokumentation
* Reproduzierbarkeit bei Geräte- oder Datenverlust
* Klare Trennung zwischen **lokaler Bearbeitung** und **externer Sicherung**
* Keine Abhängigkeit von Logseq-internen Daten

---

## Voraussetzungen

* Lokales Git-Repository ist initialisiert
* Initial Commit existiert
* Verzeichnisstruktur ist stabil

Repository-Root:

```text
/home/cs/Dokumente/PKM/Homelab
```

---

## 1. GitHub-Repository anlegen

1. Auf [https://github.com](https://github.com) anmelden
2. **New repository** erstellen
3. Einstellungen:

   * Repository name: `homelab-docs`
   * Description: `Homelab documentation (Git + Logseq compatible)`
   * Visibility: **Private** (empfohlen)
   * **Kein** README erzeugen
   * **Kein** .gitignore erzeugen
   * **Keine** License auswählen

→ Repository leer erstellen

---

## 2. Remote Repository hinzufügen

Im lokalen Repository ausführen:

```bash
git remote add origin git@github.com:<USERNAME>/homelab-docs.git
```

Alternative (HTTPS):

```bash
git remote add origin https://github.com/<USERNAME>/homelab-docs.git
```

Prüfen:

```bash
git remote -v
```

---

## 3. Initialen Stand pushen

```bash
git push -u origin main
```

Ergebnis:

* Branch `main` existiert auf GitHub
* Lokaler Branch ist mit Remote verknüpft

---

## 4. Empfohlener Arbeits-Workflow

### Lokale Arbeit

* Änderungen **ausschließlich lokal** in `pages/` vornehmen
* Logseq nur als Editor verwenden
* Nach strukturellen Änderungen:

  * Logseq schließen
  * lokales `logseq/`-Verzeichnis löschen

### Versionierung

```bash
git status
git add pages
git commit -m "<aussagekräftige Beschreibung>"
git push
```

---

## 5. Commit-Richtlinien

* Kleine, thematisch saubere Commits
* Keine Sammel-Commits
* Commit-Messages beschreiben **Inhalt**, nicht Tätigkeit

### Beispiele

```text
Clarify DNS and reverse proxy policy
Update Jellyfin audio documentation
Add restore drill findings
```

---

## 6. Sicherheit & Hygiene

* Repository bleibt **Private**
* Keine Secrets, Tokens oder Passwörter committen
* Keine Logseq-Metadaten versionieren

Versioniert werden **nur**:

* `pages/`
* `assets/`
* `files/`

---

## 7. Backup-Strategie (empfohlen)

GitHub ist **kein Backup**, sondern ein Remote.

Empfohlene Ergänzungen:

* zusätzliches Remote (z. B. Gitea oder GitLab)
* regelmäßiges lokales Backup von `/home/cs/Dokumente/PKM`

Optional:

```bash
git remote add mirror git@gitea.example.local:docs/homelab.git
git push mirror main
```

---

## 8. Wiederherstellung

Im Notfall:

```bash
git clone git@github.com:<USERNAME>/homelab-docs.git
```

Danach:

* Logseq öffnen
* Graph auf geklontes Verzeichnis setzen
* Inhalte sind sofort verfügbar

---

## Status

* Rolle: Externe Sicherung & Versionskontrolle
* Änderungsfrequenz: gering
* Verbindlichkeit: hoch

---

> **GitHub ist das Gedächtnis – Logseq ist das Denkwerkzeug.**
