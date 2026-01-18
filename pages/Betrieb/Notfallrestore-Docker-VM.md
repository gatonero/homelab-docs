# 🚨 Notfallrestore – docker-VM (VM 200)

## Zweck

Diese Checkliste ermöglicht einen **schnellen, reproduzierbaren und stressfesten Restore** der zentralen docker-VM (VM 200) unter Proxmox.

* ohne Denkpausen
* ohne Architekturänderungen
* ohne implizite Annahmen

> **Diese Checkliste ist für den Ernstfall.**
> Erklärungen, Optimierungen und Experimente sind hier **nicht erlaubt**.

---

## Voraussetzungen (Pflicht)

Vor Beginn **müssen alle Punkte erfüllt sein**:

* [ ] Aktuelles Proxmox-Backup der VM 200 vorhanden
* [ ] Zugriff auf Proxmox Web-UI oder CLI
* [ ] Dokumentation verfügbar (DNS / NPM / TLS)
* [ ] Klarheit, **auf welcher Maschine** gearbeitet wird:

  * Proxmox-Host
  * docker-VM (VM 200)
  * Client-System

---

## 1️⃣ Vor dem Restore (kritisch)

* [ ] **VM 200 ist gestoppt** ❗
* [ ] Restore erfolgt **nicht** in eine laufende VM
* [ ] Entscheidung getroffen: **Overwrite Restore** (keine neue VM-ID)

> ⚠️ Ein Restore in eine laufende VM führt zu inkonsistenten Zuständen.

---

## 2️⃣ Restore in Proxmox

* [ ] Backup auswählen: `vzdump-qemu-200-…`
* [ ] Restore-Ziel: **VM 200**
* [ ] *Start after restore*: ❌ deaktiviert
* [ ] *Unique*: ❌ deaktiviert
* [ ] Ressourcen unverändert übernehmen

---

## 3️⃣ Erster Start (kontrolliert)

* [ ] VM 200 manuell starten
* [ ] Login als `root` möglich
* [ ] **Kein** Emergency Mode
* [ ] **Kein** Filesystem-Repair notwendig

---

## 4️⃣ Systemcheck (docker-VM)

```bash
uptime
df -h /
free -h
```

* [ ] Load normal
* [ ] Root-Filesystem < 90 %
* [ ] RAM ausreichend verfügbar

---

## 5️⃣ Docker-Status prüfen (docker-VM)

```bash
systemctl status docker
docker ps
```

* [ ] Docker-Dienst aktiv
* [ ] Erwartete Container vorhanden:

  * NGINX Proxy Manager
  * NetBox (inkl. DB / Redis)
  * Uptime Kuma
  * Portainer

---

## 6️⃣ Lokale Port-Tests (docker-VM)

```bash
curl -I http://127.0.0.1:81
curl -I http://127.0.0.1:8000
curl -I http://127.0.0.1:3001
```

* [ ] HTTP-Antworten (200 / 302)

> ⚠️ **Nicht vom Client aus testen.**
> `127.0.0.1` bezieht sich immer auf die lokale Maschine.

---

## 7️⃣ DNS-Validierung (Client)

```bash
nslookup uptime.home.arpa
nslookup netbox.home.arpa
nslookup homeassistant.home.arpa
```

* [ ] Alle Records zeigen auf **192.168.1.63** (Reverse Proxy)

---

## 8️⃣ HTTPS-Validierung (Client, Inkognito)

Aufruf im Browser:

```
https://uptime.home.arpa
https://netbox.home.arpa
https://homeassistant.home.arpa
```

* [ ] HTTPS aktiv
* [ ] Zertifikat: `*.home.arpa` (mkcert)
* [ ] Keine Redirect-Loops

---

## 9️⃣ Abschluss

* [ ] Uptime Kuma überwacht alle kritischen Services
* [ ] NGINX Proxy Manager Konfiguration konsistent
* [ ] Restore-Datum dokumentiert

---

## Merksätze für den Ernstfall

* **Erst stoppen, dann restoren.**
* **Befehle immer auf der richtigen Maschine ausführen.**
* **DNS repariert Erreichbarkeit, nicht Docker.**
* **Restore ist kein Ort für Optimierungen.**

---

## Status

* ✔ getestet
* ✔ reproduzierbar
* ✔ stressfest
