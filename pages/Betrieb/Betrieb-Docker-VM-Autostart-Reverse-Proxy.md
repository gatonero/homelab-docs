# Betrieb – Docker-VM Autostart & Reverse Proxy

## Zweck

Diese Seite beschreibt den **betrieblichen Autostart** der Docker-VM sowie die Rolle des **Reverse Proxys** im Homelab.

Ziel ist ein stabiler Betrieb nach:

* geplantem Shutdown
* Stromausfall
* Neustart einzelner Systeme

---

## Rolle der Docker-VM

Die Docker-VM fungiert als zentraler Applikationshost.

Aufgaben:

* Betrieb mehrerer Services via Docker Compose
* Bereitstellung des Reverse Proxys als zentralem Einstiegspunkt
* Entkopplung der Applikationen vom Proxmox-Host

---

## Reverse Proxy

Als Reverse Proxy wird **NGINX Proxy Manager** eingesetzt.

Eigenschaften:

* eigener Docker-Stack
* exponierte Ports: 80 / 81 / 443
* TLS-Terminierung
* Weiterleitung zu internen Services

Der Reverse Proxy ist ein **kritischer Dienst** und muss nach jedem Reboot automatisch verfügbar sein.

---

## Docker-Stack-Struktur

Alle Docker-Stacks liegen unter:

```
/opt/docker/<service>
```

Jeder Stack besitzt:

* eigenes Verzeichnis
* eigene `docker-compose.yml`
* eigene Volumes

---

## Autostart-Mechanismus

Der Autostart erfolgt über einen systemd-Service:

```
docker-compose-autostart.service
```

Ablauf:

* systemd startet nach dem Boot
* iteriert über `/opt/docker/*`
* startet jedes gefundene `docker-compose.yml` mit `docker compose up -d`

Der Service verbleibt im Zustand:

```
active (exited)
```

Dies signalisiert einen erfolgreichen Startlauf.

---

## Ergebnis

* automatischer Start aller Docker-Stacks
* Reverse Proxy frühzeitig verfügbar
* kein manuelles Eingreifen erforderlich

---

## Weiterführend

* [[Wiederanlauf-Playbook]]
* [[Einstieg – Kritische Systeme]]
