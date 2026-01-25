---
title: "Betrieb – Wiederanlauf-Playbook"
---

# Betrieb – Wiederanlauf-Playbook

← Zurueck zur [`Overview`](/pages/Betrieb/Overview-Betrieb.md)

## Zweck

Dieses Playbook beschreibt den **standardisierten Wiederanlauf** des Homelabs nach:

* geplantem Shutdown
* ungeplantem Stromausfall

Ziel ist ein **deterministisches Vorgehen ohne situative Entscheidungen**.

---

## Grundsatz (verbindlich)

* **Backups werden ausschließlich zentral auf dem QNAP TS-464 durchgeführt**
* Der QNAP ist der **Datenanker** des Homelabs
* Nach einem Stromausfall sind **keine manuellen Backup-Aktionen** auf Clients oder Servern erforderlich
* Google Drive dient **nur als Offsite-Ziel** für HBS3-Backups

> Clientseitige Backup-Tools (rclone, restic) sind **nicht im Einsatz**.

---

## Wiederanlauf – Übersicht

Empfohlene Reihenfolge:

1. Stromversorgung herstellen
2. NAS starten (QNAP TS-464)
3. Proxmox-Host starten (M720q)
4. Docker-VM startet automatisch
5. Docker-Stacks starten automatisch
6. Funktionsprüfung

---

## Schritt 1 – Stromversorgung

* stabile Stromversorgung sicherstellen
* ggf. USV-Status prüfen

---

## Schritt 2 – NAS (QNAP TS-464)

* NAS einschalten
* warten, bis:

  * Storage verfügbar ist
  * Netzwerkdienste aktiv sind
  * HBS3 betriebsbereit ist

**Hinweis:**
Backups laufen serverseitig und werden vom QNAP selbständig gemäß Zeitplan ausgeführt.

---

## Schritt 3 – Proxmox-Host

* Proxmox-Host starten
* Management-UI (Web) erreichbar abwarten

---

## Schritt 4 – Docker-VM

* startet automatisch
* kein manuelles Eingreifen erforderlich

---

## Schritt 5 – Docker-Stacks

* Start erfolgt durch `docker-compose-autostart.service`
* erwarteter Zustand:

  * alle produktiven Container im Status `Up`

---

## Schritt 6 – Funktionsprüfung

* Reverse Proxy erreichbar
* kritische Dienste verfügbar (z. B.:

  * NGINX Proxy Manager
  * Home Assistant
  * NetBox
  * Uptime Kuma)

---

## Abschlusskriterium

Der Wiederanlauf gilt als erfolgreich, wenn:

* alle kritischen Systeme erreichbar sind
* keine manuellen Startmaßnahmen erforderlich waren
* keine Backup-bezogenen Eingriffe notwendig waren

---

## Abgrenzung

* **Mini-IT13**:

  * kein Backup-Knoten
  * keine Cloud-Anbindung
  * keine Backup-Tools aktiv

* **Syncthing**:

  * dient ausschließlich der Arbeitskopien
  * kein Backup, keine Historisierung

---

## Weiterfuehrend

* [`Einstieg – Kritische Systeme`](/pages/Einstieg/Kritische-Systeme.md)
* [`Betrieb – Docker-VM Autostart & Reverse Proxy`](/pages/Betrieb/Betrieb-Docker-VM-Autostart-Reverse-Proxy.md)

