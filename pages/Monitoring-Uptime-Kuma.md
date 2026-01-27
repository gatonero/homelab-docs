---
title: "Monitoring – Uptime Kuma"
---

# title: "Monitoring – Uptime Kuma"

Dieses Dokument beschreibt das **vollständige Monitoring-Konzept** des Homelabs mit **Uptime Kuma**.

Es definiert:

* die Monitoring-Philosophie,
* die eingesetzten Monitor-Typen,
* Namens- und Strukturkonventionen,
* sowie die Einordnung spezialisierter Monitoring-Szenarien.

Das Dokument ist die **kanonische Übersicht** für Monitoring im Homelab.

---

## Monitoring-Philosophie

Das Monitoring folgt klar getrennten Ebenen:

1. **INFRA** – Erreichbarkeit grundlegender Infrastruktur
2. **SERVICE** – Funktionale Erreichbarkeit von Diensten
3. **JOB** – Erfolgsüberwachung von zeitgesteuerten Aufgaben

Ziel ist:

* maximale Aussagekraft,
* minimale Fehlalarme,
* klare Trennung von Ursachen.

---

## Monitor-Kategorien

### INFRA-Monitore

**Zweck:** Grundlegende Erreichbarkeit von Hosts und Kernkomponenten.

**Typische Eigenschaften:**

* Monitor-Typ: `Ping`
* Prüfintervall: `60 Sekunden`
* Wiederholungen: `2`

**Beispiele:**

* `[INFRA] Router – Ping`
* `[INFRA] Proxmox pve-01 – Ping`
* `[INFRA] QNAP TS-464 – Ping`
* `[INFRA] NGINX LXC – Ping`

---

### SERVICE-Monitore

**Zweck:** Verfügbarkeit und Antwortfähigkeit von Anwendungen.

**Typische Eigenschaften:**

* Monitor-Typ: `HTTP(s)`
* Interne IP + Port (kein externer Proxy)
* Akzeptierte Statuscodes: `200, 302`

**Beispiele:**

* `[SERVICE] Home Assistant – HTTP`
* `[SERVICE] Jellyfin – HTTP`
* `[SERVICE] Uptime Kuma – HTTP`

---

### JOB-Monitore

**Zweck:** Überwachung des **Erfolgs** von zeit- oder ereignisbasierten Jobs.

**Prinzip:** *Push statt Polling*

* Der Job meldet aktiv seinen Erfolg
* Bleibt die Meldung aus, wird alarmiert

**Typische Eigenschaften:**

* Monitor-Typ: `Push`
* Prüfintervall = erwartetes Job-Intervall
* Push **nur bei Erfolg**

---

## Namens- und Strukturkonventionen

### Namensschema

```
[EBENE] Objekt – Methode
```

**Beispiele:**

* `[INFRA] Router – Ping`
* `[SERVICE] Jellyfin – HTTP`
* `[JOB] Proxmox Backup – Push`

### Tags

* `infra`
* `service`
* `job`
* optionale Spezialisierung (z. B. `backup`, `proxmox`)

---

## Spezialisierte Monitoring-Szenarien

Bestimmte Monitoring-Fälle erfordern eine detaillierte Beschreibung, die den Rahmen dieser Übersicht sprengen würde.

Diese werden **bewusst als eigenständige Dokumente** gepflegt und hier lediglich referenziert.

### Proxmox Backup – Job-Monitoring

* **Dokument:** `Monitoring – Proxmox Backup (Uptime Kuma Push)`
* **Einordnung:** JOB-Monitor
* **Begründung für separates Dokument:**

  * eigene Architektur (Hookscript)
  * abweichende Semantik (Push)
  * hohe Kritikalität

---

## Betriebsgrundsätze

* Monitoring wird **nicht für Debugging missbraucht**
* Manuelle Tests erfolgen nur gezielt und temporär
* Änderungen am Monitoring werden dokumentiert
* Historische Testdaten werden nach Abschluss bereinigt

---

## Ergebnis

Das Monitoring mit Uptime Kuma ist:

* strukturiert,
* erweiterbar,
* wartbar,
* und klar dokumentiert.

Die Trennung zwischen Übersichtsdokument und spezialisierten Detaildokumenten ermöglicht sauberes Wachstum ohne Redundanz.

## Weiterführend

Dieses Dokument beschreibt die **Monitoring-Architektur und -Prinzipien** im Homelab auf Überblicksebene.

Detaillierte, betrieblich relevante Monitoring-Szenarien werden bewusst in **eigenständigen Dokumenten** beschrieben:

- **Monitoring – Proxmox Backup (Uptime Kuma Push)**  
  Job-basiertes Monitoring des täglichen Proxmox-Backups mittels Push-Semantik und Hookscript.  
  Fokus: Erfolg des Backup-Jobs, nicht Erreichbarkeit von Hosts oder Diensten.  
  [`Monitoring – Proxmox Backup (Uptime Kuma Push)`](/pages/Monitoring-Proxmox-Backup.md)

Weitere spezialisierte JOB-Monitore (z. B. Offsite-Backups, rsync-Jobs, Dokumentations-Backups) werden nach demselben Muster als eigene Detaildokumente ergänzt.
