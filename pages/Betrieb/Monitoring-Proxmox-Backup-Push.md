---
title: "Monitoring Proxmox Backup Push"
---

## Ziel

Proxmox-Backups werden push-basiert an Uptime Kuma gemeldet.
Pro Backup-Job existiert genau ein Status.

Erfolgreich:
- Push mit Status up

Fehlerhaft oder ausgeblieben:
- Alarm

Pull-basierte Prüfungen werden bewusst nicht verwendet.

## Architektur

- Ein Hook-Script wird beim Ereignis vzdump job-end ausgeführt
- Ein Guard-Mechanismus stellt sicher, dass der Hook dauerhaft aktiv bleibt
- Der Push erfolgt IP-basiert, TLS wird vollständig validiert
- Die Umsetzung ist node-lokal und für Multi-Node-Betrieb ausgelegt

## Komponenten

### Hook-Script

Pfad:

    /var/lib/vz/snippets/vzdump-uptime-kuma-hook.sh

Aufgabe:
- reagiert ausschließlich auf das Ereignis job-end
- bewertet den Gesamtstatus des Backup-Jobs
- sendet genau einen Push an Uptime Kuma

### Guard-Script

Pfad:

    /usr/local/sbin/ensure-vzdump-hook.sh

Aufgabe:
- überwacht die Datei /etc/pve/vzdump.cron
- stellt sicher, dass folgende Zeile immer vorhanden ist:

        hookscript: local:snippets/vzdump-uptime-kuma-hook.sh

Änderungen an Backup-Jobs oder an VMs/LXCs können den Push dadurch nicht versehentlich deaktivieren.

### systemd Guard

Units:

    vzdump-hook-guard.path
    vzdump-hook-guard.service

Funktion:
- reagiert auf jede Änderung an vzdump.cron
- führt das Guard-Script automatisch aus
- stellt den Sollzustand selbstheilend wieder her

## Multi-Node-Betrieb

- jeder Proxmox-Node besitzt die gleiche Backup-Push-Baseline
- die Umsetzung erfolgt über die Ansible-Role proxmox-backup-push
- neue Nodes werden durch Aufnahme in die Inventory-Gruppe proxmox_hosts integriert

## Betriebsregeln

- jeder produktive Proxmox-Node muss diese Role erhalten
- ein fehlender Push ist immer als Fehler zu werten
- es existiert keine stille Degradierung

## Test

Manueller Funktionstest auf einem Node:

    /var/lib/vz/snippets/vzdump-uptime-kuma-hook.sh job-end ok

Erwartetes Ergebnis:
- der Push erscheint unmittelbar in Uptime Kuma
- der Zeitstempel wird aktualisiert

## Wartung

- Änderungen an Backup-Jobs sind ohne zusätzliche Maßnahmen zulässig
- der Guard stellt den korrekten Zustand automatisch wieder her
- die Konfiguration ist vollständig versioniert und über Ansible reproduzierbar
