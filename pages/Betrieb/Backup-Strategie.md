---


# Betrieb - Backup-Strategie

← Zurueck zur [Betrieb-Overview](Overview-Betrieb.md)

Diese Seite beschreibt die **aktuelle, verbindliche Backup-Strategie** des Homelabs.
Der Fokus liegt auf **Betriebssicherheit**, **klarer Verantwortlichkeit** und **nachvollziehbarer Wiederherstellbarkeit**.

---

## Zweck

Diese Seite konkretisiert die Backup-Grundsaetze und ordnet sie in eine
**zentrale, betrieblich orientierte Strategie** ein.

Backups werden nicht als Einzelmassnahme verstanden, sondern als
**integraler Bestandteil des laufenden Betriebs**.

---

## Strategische Leitlinien

Die Backup-Strategie folgt klaren, bewusst restriktiven Leitlinien:

* Backups sind **regelmaessig und automatisiert**
* Backup-Logik ist **zentralisiert**
* Produktivsysteme fuehren **keine eigenen Offsite-Backups** aus
* Wiederherstellung ist **explizit Teil des Konzepts**

Ein Backup ohne getesteten Restore gilt als **nicht akzeptabel**.

---

## Zentrale Architektur

### QNAP als Daten- und Backup-Anker

Der **QNAP TS-464** ist die **einzige Backup-Instanz** im Homelab:

* zentrale Datenhaltung
* Ausfuehrung aller produktiven Backup-Jobs
* Steuerung der Offsite-Sicherung

Alle Offsite-Backups erfolgen **ausschliesslich ueber den QNAP**.

---

## Backup-Ziele

### Google Drive (Offsite)

Google Drive wird ausschliesslich als **Offsite-Ziel** genutzt:

* Schutz vor Brand, Diebstahl und Totalausfall
* keine Arbeitskopien
* kein produktiver Zugriff

Das Offsite-Backup dient der **Wiederherstellbarkeit**, nicht der Historisierung von Arbeitsstaenden.

---

## Gesicherte Schutzobjekte

### Dokumente

* **Quelle:** `/share/homes/cs/Dokumente/`
* **Tool:** HBS3 (Backup)
* **Ziel:** Google Drive
* **Versionierung:** aktiviert und begrenzt
* **Zielsetzung:** Schutz kritischer Arbeits- und Referenzdokumente

Die Versionierung dient dem Schutz vor Fehlbedienung und unbeabsichtigtem Datenverlust.

---

### paperless-ngx

Gesichert werden ausschliesslich die **fachlich relevanten Daten**:

* `media` (Originaldokumente)
* `data` (Metadaten, OCR-Ergebnisse)

Nicht Bestandteil des Backups sind:

* `pgdata` (PostgreSQL-Datenbank)

* `redisdata`

* temporaere Verzeichnisse

* **Backup-Typ:** HBS3 Backup (`.qdff`)

* **Versionierung:** systembedingt minimal

* **Datenvolumen:** ca. 3–4 GiB

Der Fokus liegt auf einer **schlanken, aktuellen Sicherung**, nicht auf Archivierung.

---

### Weitere Systeme

#### elselevy7.org

* Backup erfolgt **ausschliesslich ueber UpdraftPlus**
* kein HBS3-Backup
* keine zusaetzliche Offsite-Sicherung ueber den QNAP

---

## Abgrenzung

### Mini-IT13

* kein Backup-Knoten
* keine Cloud-Anbindung
* keine Backup-Tools aktiv

### Docker-VM

* kein Backup-Knoten
* keine Offsite-Sicherung
* rein produktiver Applikationshost

### Syncthing

* dient ausschliesslich der Arbeitskopie
* kein Backup
* keine Historisierung

---

## Wiederanlauf und Restore

* Backup-Jobs laufen serverseitig auf dem QNAP
* nach Stromausfall oder Reboot ist **kein manuelles Eingreifen erforderlich**
* Wiederherstellung erfolgt ausschliesslich ueber HBS3

Restore-Tests werden **gezielt und dokumentiert** durchgefuehrt.

---

## Zusammenfassung

Die Backup-Strategie ist:

* zentralisiert
* wartbar
* nachvollziehbar
* auf das notwendige Mass reduziert

Sie vermeidet bewusst dezentrale Sonderloesungen und minimiert damit
Komplexitaet und Fehlerquellen.

---

## Weiterfuehrend

* [`Backup – Overview`](/pages/Betrieb/Backup-Overview.md)
* [`Restore-Drill`](/pages/Betrieb/Restore-Drill.md)
* [`Restore-Szenarien`](/pages/Betrieb/Restore-Szenarien.md)
* [`Betrieb – Wiederanlauf-Playbook`](/pages/Betrieb/Wiederanlauf-Playbook.md)
