---
title: "Monitoring – Proxmox Backup (Uptime Kuma Push)"
---

# "Monitoring – Proxmox Backup (Uptime Kuma Push)"

Überwachung des **erfolgreichen Abschlusses** des täglichen Proxmox-Backup-Jobs mittels **Push-Monitoring** in Uptime Kuma.
Ein Alarm wird **nur ausgelöst**, wenn ein erwarteter erfolgreicher Backup-Lauf **ausbleibt**.

Dieses Monitoring überwacht **nicht** die Erreichbarkeit von Hosts oder Diensten, sondern den **Erfolg eines konkreten Jobs**.

---

## Architektur

**Prinzip:** *Push statt Polling*

* Proxmox führt den Backup-Job aus (vzdump)
* Nach erfolgreichem Abschluss (`job-end OK`) wird ein HTTP-Push an Uptime Kuma gesendet
* Bleibt dieser Push aus, schlägt das Monitoring nach Ablauf des Zeitfensters an

```
Proxmox Backup Job
        │
        ▼
vzdump Hookscript
        │   (HTTP POST)
        ▼
Uptime Kuma – Push Monitor
```

---

## Monitoring-Objekt

* **Name:** `[JOB] Proxmox Backup – Push`
* **Typ:** Push-Monitor
* **Zweck:** Signalisierung eines erfolgreichen Backup-Laufs

### Semantik

| Ereignis                        | Ergebnis                 |
| ------------------------------- | ------------------------ |
| Backup erfolgreich              | Push → Monitor **UP**    |
| Backup fehlgeschlagen           | Kein Push                |
| Backup nicht gelaufen           | Kein Push                |
| Kein Push innerhalb Zeitfenster | Monitor **DOWN** + Alarm |

---

## Uptime Kuma – Konfiguration

### Allgemein

* **Monitor-Typ:** Push
* **Push-URL:** intern (IP + Port, kein Proxy)
* **Statusänderung:** ausschließlich push-basiert

### Zeitverhalten

* **Prüfintervall:** `93600 Sekunden` (26 Stunden)

  * 24 h Backup-Zyklus
  * * Reserve für Laufzeit / Verzögerungen
* **Wiederholungen:** `0`
* **Erneute Benachrichtigung:** `0`

> Hinweis: Bei Push-Monitoren entspricht das *Prüfintervall* dem erwarteten Heartbeat-Zeitfenster.
> Eine separate Heartbeat-Toleranz existiert nicht.

---

## Proxmox – Hookscript

### Speicherort

```
/var/lib/vz/snippets/vzdump-uptime-kuma-hook.sh
```

### Auslöser

* `job-end OK`
* Wird **einmal pro Backup-Job** ausgeführt

### Verhalten

* Sendet **genau einen Push**, wenn der gesamte Job erfolgreich war
* Sendet **keinen Push** bei Fehlern oder Teilfehlschlägen

### Relevanter Codeausschnitt

```bash
case "$1" in
  job-end)
    if [ "$2" = "OK" ]; then
      curl -fsS -X POST "${KUMA_PUSH_URL}?status=up&msg=Backup_OK" >/dev/null
    fi
    ;;
esac
```

---

## Betriebsverhalten (Soll)

* Monitor bleibt **grün** bis zum nächsten erwarteten Backup
* Erfolgreicher Lauf → Zeitfenster wird zurückgesetzt
* Fehlender Lauf → Alarm nach 26 Stunden

### Typische Szenarien

| Situation               | Monitoring |
| ----------------------- | ---------- |
| Backup erfolgreich      | OK         |
| Backup-Job schlägt fehl | Alarm      |
| Proxmox war offline     | Alarm      |
| Storage nicht verfügbar | Alarm      |

---

## Wartung & Hinweise

* **Tokenänderungen** erfordern Anpassung des Hookskripts
* Push-URL niemals manuell rekonstruieren – immer aus Uptime Kuma kopieren
* Keine regelmäßigen manuellen Push-Tests im Produktivbetrieb
* Historische Testdaten können nach Abschluss gelöscht werden

---

## Offener Punkt

* Der erste **echte produktive Backup-Lauf (03:00)** ist noch zu beobachten
* Erwartung: genau **ein Push** im Monitor
* Dieser Punkt ist bewusst offen gelassen und blockiert den Betrieb nicht

---

## Ergebnis

Das Backup-Monitoring ist:

* ereignisbasiert
* robust gegen Neustarts
* frei von False Positives
* reproduzierbar dokumentiert

Es entspricht bewährter Praxis für Job-Monitoring in Proxmox-Homelabs und produktiven Umgebungen.
