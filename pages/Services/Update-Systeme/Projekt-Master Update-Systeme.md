# Projekt-Master Update-Systeme

Projektstatus und Steuerungsdokument des Projekts **Update-Systeme**.

**Betriebsreferenz:** V1.3

---

## Projektstatus

| UPSYS | System | Status |
|-------|--------|--------|
| UPSYS-000 | Projekt-Master / Betriebsreferenz V1.3 | ABGENOMMEN |
| UPSYS-001 | Docker VM | ABGENOMMEN |
| UPSYS-002 | Home Assistant | ABGENOMMEN |
| UPSYS-003 | QNAP TS-464 | ABGENOMMEN |
| UPSYS-004 | Proxmox Cluster | OFFEN |
| UPSYS-005 | ElseLevy7 | OFFEN |
| UPSYS-006 | Stammbaum | OFFEN |
| UPSYS-007 | Weitere Systeme | GEPLANT |

---

## Verbindliche Projektregeln

### ERG-HA-001 — SSH-/BusyBox-Regel

- Home-Assistant-Kommandos müssen in einer SSH-/BusyBox-Sitzung funktionieren.
- Zulässig: `curl`, `grep`, `cat`, `ha core check`, `ha core restart`.
- `ha state get` und Supervisor-CLI-Kommandos zur Statusabfrage werden nicht verwendet.
- Sensoren und Templates werden ausschließlich in den Entwicklerwerkzeugen geprüft.

### ERG-DOC-001 — Vollständige Codeblöcke

- Ausschließlich vollständige `cat <<'EOF'`-Blöcke.
- Keine Diffs, Patch-Dateien, Teilausschnitte oder Platzhalter.

### ERG-DOC-002 — Keine Platzhalter in Referenzdokumenten

- Alle Kapitel müssen vorhanden sein.
- Keine unvollständigen Workflows.
- Noch nicht ausgearbeitete Inhalte werden ausdrücklich gekennzeichnet.

### ERG-PM-001 — Trennung Projekt-Master und Teilprojekte

- Projekt-Master pflegt Projektstatus, Regeln, Betriebsreferenz und Abnahmen.
- Fachliche Dokumentation erfolgt ausschließlich in den UPSYS-Teilprojekten.

### ERG-PM-002 — AUSFÜHREN-Format

- Jeder AUSFÜHREN-Schritt enthält gemeinsam Schreib- und Verifikationsbefehl.
- Kein separater „Nächster Befehl“.

### ERG-PM-003 — Verifikation großer Dokumente

Große Betriebsreferenzen werden standardmäßig verifiziert mit:

- `wc -l <Datei>`
- `head -20 <Datei>`
- `tail -20 <Datei>`
- Optional `grep "^## " <Datei>`

Der vollständige `cat <Datei>` bleibt Standard für kleinere Dokumente.

### ERG-PM-004 — Auslieferung großer Dateien

Wenn eine vollständige Datei die maximale Antwortgröße überschreitet:

- Ausgabe in mehreren unmittelbar aufeinanderfolgenden Teilen.
- Alle Teile bilden unverändert eine Datei.
- Der letzte Teil schließt den `EOF`-Block und enthält die Verifikation.

---

## Betriebsreferenz V1.3

Jeder Wartungsworkflow besitzt verpflichtend folgende Kapitel:

1. Auslöser (TRMNL-Update-Instanz)
2. Datenquelle (Collector)
3. Vorbedingungen
4. Durchführung
5. Verifikation
6. Rollback
7. Besonderheiten

Collector, Update-Aggregator und TRMNL werden durch dieses Projekt nicht verändert.

---

## Dokumentationsort

/home/cs/Dokumente/Logseq-Graphs/Homelab/pages/Services/Update-Systeme/

Alle Dokumentation wird über Git versioniert.

---

## Arbeitsweise des Projekts

Der Projekt-Master arbeitet ausschließlich in diesem Chat.

Jedes UPSYS-Teilprojekt erhält einen eigenen Arbeitschat.

Ablauf:

1. ANALYSE
2. VORSCHLAG
3. AUSFÜHREN
4. VERIFIKATION
5. BEREINIGUNG
6. ABSCHLUSSBERICHT an den Projekt-Master

---

## Abschlussberichte

Jedes UPSYS-Projekt endet mit:

1. Verifikation.
2. Bereinigung temporärer Artefakte.
3. Abschlussbericht an den Projekt-Master.
4. Git-Commit und Git-Push nach Abnahme.

Erst danach setzt der Projekt-Master den Status auf **ABGENOMMEN**.
