# Betrieb – Docker-VM Autostart & Reverse Proxy

## Zweck

Diese Seite beschreibt den **betrieblichen Zustand** der Docker-VM im Homelab nach der Stabilisierung des Wiederanlaufs (Stromausfall / geplanter Shutdown). Ziel ist ein **reproduzierbarer, wartungsarmer Betrieb**, bei dem zentrale Dienste automatisch starten und ohne manuelle Eingriffe verfügbar sind.

---

## Rolle der Docker-VM

Die Docker-VM stellt zentrale Applikationsdienste bereit und fungiert als **Applikations-Host** hinter einem Reverse Proxy.

Wesentliche Aufgaben:

* Hosting mehrerer Dienste via Docker Compose
* Bereitstellung des zentralen Reverse Proxys
* Entkopplung der Applikationen vom Proxmox-Host

---

## Reverse Proxy

Als zentraler Einstiegspunkt wird **NGINX Proxy Manager** eingesetzt.

Eigenschaften:

* Läuft als eigener Docker-Stack
* Exponiert die Ports **80 / 81 / 443** auf der Docker-VM
* Terminiert TLS
* Stellt die Web-UIs und Backends der internen Dienste bereit

Der Reverse Proxy ist so konfiguriert, dass er **nach jedem Reboot automatisch startet**.

---

## Docker-Stack-Struktur

Alle Docker-Stacks liegen konsistent unter:

```
/opt/docker/<service>
```

Jeder Dienst besitzt:

* ein eigenes Verzeichnis
* eine eigene `docker-compose.yml`
* eigene Volumes (lokal oder unterhalb des Stack-Verzeichnisses)

Beispiele:

* `/opt/docker/nginx-proxy-manager`
* `/opt/docker/jellyfin`
* `/opt/docker/netbox`
* `/opt/docker/uptime-kuma`

Diese Struktur ermöglicht:

* klare Trennung der Dienste
* einfache Sicherung einzelner Stacks
* gezielte Wartung ohne Seiteneffekte

---

## Autostart-Mechanismus

Der automatische Start aller Docker-Stacks wird **nicht** durch Portainer, sondern durch **systemd** realisiert.

### Prinzip

* systemd startet **einmalig** nach dem Booten einen Autostart-Service
* dieser iteriert über alle Verzeichnisse unter `/opt/docker`
* jedes gefundene `docker-compose.yml` wird mit `docker compose up -d` gestartet

### Eigenschaften

* ein zentraler Mechanismus für alle Stacks
* keine harte Codierung einzelner Dienste
* unabhängig von Portainer
* vollständig reversibel

Der systemd-Service verbleibt nach Ausführung im Zustand:

```
active (exited)
```

Dies signalisiert einen **erfolgreich abgeschlossenen Startlauf**.

---

## Verhalten nach Reboot / Stromausfall

Nach einem Reboot der Docker-VM gilt:

* Docker-Daemon startet
* systemd triggert den Autostart aller Docker-Stacks
* alle produktiven Container sind ohne manuelles Eingreifen verfügbar

Der Reverse Proxy steht frühzeitig zur Verfügung, sodass abhängige Dienste erreichbar sind, sobald sie gestartet wurden.

---

## Abgrenzung

* **Portainer** dient ausschließlich der Verwaltung und Beobachtung
* Portainer ist **nicht** Teil des Autostart-Mechanismus
* Docker Compose bleibt die alleinige Quelle der Dienstdefinitionen

---

## Ergebnis

Dieser Aufbau stellt sicher:

* stabilen Wiederanlauf nach Stromausfall
* reproduzierbaren Systemstart
* minimale betriebliche Komplexität
* klare Dokumentations- und Wartungsstruktur

Der Zustand gilt als **betriebsfähig und abgenommen**.
