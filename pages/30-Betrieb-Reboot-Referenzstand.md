---
title: "Reboot- und Betriebsarchitektur – stabiler Referenzstand"
---

# Reboot- und Betriebsarchitektur – stabiler Referenzstand

## Ziel dieses Dokuments

Dieses Dokument beschreibt den **stabilen, verifizierten Betriebszustand** des Homelabs nach Abschluss der strukturellen Bereinigung, der Ingress-Migration und eines erfolgreichen Reboot-/Stromausfall-Tests.

Der Stand ist **technisch robust**, **methodisch sauber** und dient als **neuer Referenzpunkt** für zukünftige Änderungen.

---

## Überblick – Architektur (Ist-Zustand)

### Zentrale Prinzipien

* Klare Trennung von **Ingress**, **Monitoring** und **Applikationen**
* Keine infrastrukturellen Abhängigkeiten von instabilen Storage-Backends
* Deterministisches Verhalten bei Reboot / Stromausfall
* Dokumentation spiegelt die reale Architektur wider

---

## Komponentenübersicht

### Proxmox Host (`pve-01`)

* Rolle: Virtualisierungsplattform
* Startet alle LXCs und VMs
* Führt **Uptime Kuma nativ** aus

**Begründung:**
Monitoring muss beim Reboot **so früh wie möglich** verfügbar sein. Eine Host-nahe Installation ist für diesen Zweck robuster als ein nachgelagerter Container.

---

### Ingress-LXC (`nginx-lxc`)

* Typ: LXC
* Funktion: **Nativer NGINX als Reverse Proxy**
* Statische IP
* Kein Docker
* Keine Storage-Abhängigkeiten

**Status:** produktiv, getestet, abgenommen

**Begründung:**

* Kein NGINX Proxy Manager (NPM)
* Keine versteckten Volumes
* Keine CIFS-/NFS-Abhängigkeiten
* Volle Kontrolle über Startverhalten und Konfiguration

---

### docker-vm

* Typ: Virtuelle Maschine
* Rolle: **Reine Applikationsplattform**

**Enthaltene Dienste:**

* Jellyfin
* NetBox
* PostgreSQL (NetBox)
* Redis (NetBox)
* Portainer (optional, administrativ)

**Nicht enthalten:**

* Ingress
* Monitoring
* Infrastruktur-Glue

**Begründung:**
Die docker-vm enthält ausschließlich fachliche Anwendungen. Infrastruktur wird bewusst ausgelagert.

---

### Storage

* Produktiver Storage-Zugriff via **NFS**
* CIFS vollständig entfernt
* Keine Docker-Volumes auf instabilen Backends

**Ergebnis:**
Kein Startblocker mehr durch „storage not online“.

---

## Volume-Management (Docker)

### NetBox

Alle produktiven Volumes sind **explizit benannt**:

* `netbox_postgres_data`
* `netbox_redis_data`
* `netbox_netbox_media`
* `netbox_netbox_reports`
* `netbox_netbox_scripts`

**Wichtig:**

* Keine anonymen Volumes
* Keine Altlasten
* Volumes sind eindeutig zuordenbar und erklärbar

---

## Monitoring

### Uptime Kuma

* Installationsort: **Proxmox Host (`pve-01`)**
* Startet früh im Bootprozess
* Überwacht:

  * Proxmox Host
  * Ingress-LXC
  * docker-vm
  * NetBox (HTTP)
  * Jellyfin (HTTP)

**Designentscheidung:**
Monitoring bewusst nicht containerisiert, um Abhängigkeiten zu minimieren.

---

## Reboot- / Stromausfall-Test

### Testziel

Nachweis, dass das System nach Reboot oder Stromausfall:

* automatisch
* ohne manuelle Eingriffe
* in konsistenter Reihenfolge
  wieder betriebsbereit ist.

---

### Testdurchführung

* Reboot des Proxmox-Hosts
* Beobachtung ausschließlich über Uptime Kuma
* Keine manuellen Eingriffe

---

### Beobachtetes Verhalten (Ist)

1. Proxmox Host kurzzeitig nicht erreichbar
2. Ingress-LXC startet
3. docker-vm startet
4. NetBox wird erreichbar (HTTP 200)
5. Jellyfin wird erreichbar (HTTP 200)

Kurzzeitige rote Statusmeldungen (`Host unreachable`, `EHOSTUNREACH`) während des Reboots sind **erwartet** und korrekt.

---

### Testergebnis

✅ **Test bestanden**

* Alle Dienste kamen selbstständig zurück
* Keine Storage-Fehler
* Keine hängenden Autostarts
* Keine manuelle Intervention erforderlich

---

## Lessons Learned

### Was vermieden wird

* NGINX Proxy Manager als Blackbox
* CIFS für produktive Infrastruktur
* Infrastruktur-Dienste in Docker
* Anonyme Volumes

### Was sich bewährt hat

* Native Dienste für kritische Funktionen
* Klare Rollen pro VM/LXC
* Explizite Volumes
* Reboot-Tests als verbindlicher Qualitätsnachweis

---

## Stabiler Referenzpunkt

Dieser Stand gilt als:

> **stabiler, getesteter Referenzzustand**

Alle zukünftigen Änderungen erfolgen:

* bewusst
* dokumentiert
* und werden erneut gegen Reboot-/Wiederanlauf geprüft.

---

*Dokument erstellt nach erfolgreichem Systemtest und Abnahme.*
