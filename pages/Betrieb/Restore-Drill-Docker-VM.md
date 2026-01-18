# 🧪 Restore-Drill – docker-VM (VM 200)

## Zweck

Dieses Dokument beschreibt den **Restore-Drill** für den Ausfall der zentralen docker-VM (VM 200). Es dient der **Übung**, der **Erkenntnisgewinnung** und der **Verbesserung von Dokumentation und Abläufen**.

> **Abgrenzung:**
>
> * **Restore-Drill** = Lernen, Beobachten, Verbessern
> * **Notfallrestore** = Ausführen ohne Abweichungen

---

## Szenario

### Annahmen

* ❌ docker-VM (VM 200) **nicht lauffähig**
* ❌ Alle Services hinter NGINX Proxy Manager ausgefallen
* ✅ Proxmox **läuft**
* ✅ AdGuard **läuft**
* ✅ Home Assistant **läuft**
* ✅ Backups sind **verfügbar**

> Es wird **nicht** angenommen, dass Logs, Browser-Sessions oder Erinnerungen verfügbar sind.

---

## Ziel des Drills

* Wiederanlauf **unter Zeitdruck**
* **keine Improvisation**, nur Doku & Checklisten
* Nachweis, dass der Betrieb **reproduzierbar** wiederhergestellt werden kann

---

## Zeitmessung

| Marker | Bedeutung                  |
| ------ | -------------------------- |
| T0     | Ausfall erkannt            |
| T1     | Restore gestartet          |
| T2     | VM gestartet               |
| T3     | Services lokal erreichbar  |
| T4     | Services extern erreichbar |

**Bewertung:**

* 🟢 < 60 Minuten = sehr gut
* 🟡 60–90 Minuten = akzeptabel
* 🔴 > 90 Minuten = Verbesserungsbedarf

---

## Drill-Regeln (verbindlich)

* ❌ Keine freien Experimente
* ❌ Keine schnellen Fixes außerhalb der Checklisten
* ❌ Keine Änderungen an der Control Plane
* ✅ Erlaubte Dokumente:

  * `Notfallrestore-Docker-VM.md`
  * `Architektur-Gesamt.md`

---

## Phase 1 – Erkennen & Einordnen

* Feststellen: **Welche Ebene ist betroffen?**

  * DNS
  * Reverse Proxy
  * Backend
* Entscheidung treffen: **Restore der docker-VM notwendig?**

> Merksatz: **Nicht jeder Ausfall ist ein Restore-Fall.**

---

## Phase 2 – Vorbereitung

* Proxmox erreichbar (`https://proxmox.home.arpa:8006`)
* Geeigneten Backup-Zeitpunkt auswählen
* VM 200 **stoppen**

⏱️ **Zeitstempel T1 setzen**

---

## Phase 3 – Restore

* Restore **ausschließlich** gemäß `Notfallrestore-Docker-VM.md`
* Kein Autostart
* Keine Ressourcenänderungen

---

## Phase 4 – Erster Start & lokale Validierung

* VM 200 manuell starten
* Login möglich
* Docker läuft
* Erwartete Container laufen

⏱️ **Zeitstempel T2 setzen**

---

## Phase 5 – Service-Validierung (lokal, docker-VM)

```bash
curl -I http://127.0.0.1:81
curl -I http://127.0.0.1:8000
curl -I http://127.0.0.1:3001
```

* Alle Antworten erwartungsgemäß

⏱️ **Zeitstempel T3 setzen**

---

## Phase 6 – DNS & HTTPS-Validierung (Client)

```bash
nslookup uptime.home.arpa
nslookup homeassistant.home.arpa
```

```text
https://uptime.home.arpa
https://netbox.home.arpa
https://homeassistant.home.arpa
```

* DNS korrekt
* TLS aktiv
* Services erreichbar

⏱️ **Zeitstempel T4 setzen**

---

## Phase 7 – Nachbereitung

### Leitfragen

* Wo wurde gezögert?
* Welche Information wurde gesucht?
* Was war unklar oder doppelt?

### Aktionen

* Dokumentation anpassen
* Checkliste präzisieren
* Zeitmessung dokumentieren

---

## Merksätze

* **Restore ist kein Reparieren.**
* **Zeitdruck deckt Doku-Lücken auf.**
* **Was nicht dokumentiert ist, existiert nicht.**

---

## Status

* ☐ geplant
* ☐ durchgeführt
* ☐ ausgewertet
