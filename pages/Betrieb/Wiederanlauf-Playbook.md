# Betrieb – Wiederanlauf-Playbook

## Zweck

Dieses Playbook beschreibt den **standardisierten Wiederanlauf** des Homelabs nach

* geplantem Shutdown
* ungeplantem Stromausfall

Ziel ist ein **deterministisches, stressfreies Vorgehen**, ohne situative Entscheidungen oder Fehlersuche unter Zeitdruck.

---

## Gültigkeitsbereich

Dieses Playbook gilt für:

* NAS (Storage)
* Proxmox-Host(s)
* Docker-VM
* darauf laufende zentrale Dienste (Reverse Proxy, Management, Monitoring)

Nicht enthalten:

* Detail-Fehleranalyse einzelner Applikationen
* Recovery aus Backups (separates Restore-Konzept)

---

## Grundannahmen

* Alle Systeme sind korrekt konfiguriert (BIOS/UEFI, Autostart, systemd)
* Docker-Stacks starten automatisch via systemd
* Der Reverse Proxy ist der zentrale Einstiegspunkt

---

## Wiederanlauf – Übersicht

Empfohlene Reihenfolge:

1. **Stromversorgung wiederherstellen**
2. **NAS starten und stabilisieren lassen**
3. **Proxmox-Host starten**
4. **Docker-VM startet automatisch**
5. **Docker-Stacks starten automatisch**
6. **Funktionsprüfung der kritischen Dienste**

---

## Schritt 1 – Stromversorgung

* Sicherstellen, dass die Stromversorgung stabil ist
* Bei USV-Betrieb: USV-Status prüfen

Keine Systeme manuell starten, bevor stabile Versorgung gegeben ist.

---

## Schritt 2 – NAS

* NAS einschalten (oder automatischen Start abwarten)
* Warten, bis:

  * Storage verfügbar ist
  * Netzwerkdienste aktiv sind

**Begründung:**
Das NAS stellt Daten für Docker-Stacks und Backups bereit und muss vor abhängigen Systemen verfügbar sein.

---

## Schritt 3 – Proxmox-Host

* Proxmox-Host starten
* Abwarten, bis:

  * Host vollständig gebootet ist
  * Management-UI erreichbar ist

Falls mehrere Hosts vorhanden sind:

* zuerst der primäre Host

---

## Schritt 4 – Docker-VM

* Docker-VM startet automatisch durch Proxmox
* Kein manuelles Eingreifen erforderlich

Prüfpunkte:

* VM erreichbar (Ping / SSH)
* Docker-Daemon aktiv

---

## Schritt 5 – Docker-Stacks

Der Start erfolgt automatisch durch den systemd-Service:

```
docker-compose-autostart.service
```

Ablauf:

* systemd iteriert über `/opt/docker/*`
* alle `docker-compose.yml` werden mit `docker compose up -d` gestartet

Erwarteter Zustand:

* Service-Status: `active (exited)`
* Alle produktiven Container: `Up`

---

## Schritt 6 – Funktionsprüfung (Minimal)

### Reverse Proxy

* Web-UI erreichbar
* Exponierte Ports aktiv (80 / 443)

### Kritische Dienste

* Management-Oberflächen erreichbar
* Monitoring meldet keine kritischen Fehler

**Keine Detailtests durchführen.**
Ziel ist lediglich die Bestätigung der Grundfunktion.

---

## Abweichungen / Fehlerfall

* Einzelne Container starten nicht:

  * Logs prüfen (`docker logs <container>`)
  * Keine Änderungen an der Startreihenfolge vornehmen

* Reverse Proxy nicht erreichbar:

  * Status der Docker-VM prüfen
  * Docker-Service prüfen

Tiefe Fehleranalyse erfolgt **außerhalb dieses Playbooks**.

---

## Abschlusskriterium

Der Wiederanlauf gilt als erfolgreich, wenn:

* alle kritischen Systeme erreichbar sind
* keine manuellen Startmaßnahmen erforderlich waren

Der Normalbetrieb kann wieder aufgenommen werden.

---

## Ablageort

Diese Datei liegt unter:

```
pages/Betrieb/Wiederanlauf-Playbook.md
```

Sie ist Bestandteil der operativen Homelab-Dokumentation und wird bei Architekturänderungen aktualisiert.
