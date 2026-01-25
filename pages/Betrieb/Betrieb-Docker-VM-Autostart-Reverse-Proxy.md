# Betrieb – Docker-VM Autostart & Reverse Proxy

## Zweck

Diese Seite beschreibt den **betrieblichen Autostart der Docker-VM** sowie die Rolle des **Reverse Proxys** im Homelab.

Ziel ist ein **stabiler, reproduzierbarer Betrieb** nach:

* geplantem Shutdown
* Stromausfall
* Neustart einzelner Systeme

Die hier beschriebenen Mechanismen sind **deterministisch** und erfordern im Normalfall **kein manuelles Eingreifen**.

---

## Rolle der Docker-VM

Die Docker-VM fungiert als **zentraler Applikationshost** im Homelab.

Aufgaben:

* Betrieb mehrerer Services via Docker Compose
* Bereitstellung des Reverse Proxys als zentralem Einstiegspunkt
* Entkopplung der Applikationen vom Proxmox-Host

**Abgrenzung:**

* Die Docker-VM ist **kein Backup-Knoten**
* Es existieren **keine Cloud- oder Offsite-Backups** auf der Docker-VM
* Backup-Logik ist vollständig auf den QNAP ausgelagert

---

## Reverse Proxy

Als Reverse Proxy wird **NGINX Proxy Manager** eingesetzt.

Eigenschaften:

* eigener Docker-Stack
* exponierte Ports:

  * 80 (HTTP)
  * 81 (Admin UI)
  * 443 (HTTPS)
* TLS-Terminierung
* Weiterleitung zu internen Services

Der Reverse Proxy ist ein **kritischer Dienst** und muss nach jedem Reboot **automatisch und frühzeitig** verfügbar sein.

---

## Docker-Stack-Struktur

Alle Docker-Stacks liegen unter:

```
/opt/docker/<service>
```

Jeder Stack besitzt:

* ein eigenes Verzeichnis
* eine eigene `docker-compose.yml`
* eigene Volumes

Diese Struktur erlaubt:

* klare Trennung der Services
* gezielte Wartung einzelner Stacks
* reproduzierbaren Autostart

---

## Autostart-Mechanismus

Der Autostart aller Docker-Stacks erfolgt über einen systemd-Service:

```
docker-compose-autostart.service
```

### Funktionsweise

* systemd startet den Service nach dem Boot
* der Service iteriert über `/opt/docker/*`
* für jedes Verzeichnis mit `docker-compose.yml` wird ausgeführt:

  ```bash
  docker compose up -d
  ```

### Service-Zustand

Nach erfolgreichem Durchlauf verbleibt der Service im Zustand:

```
active (exited)
```

Dies signalisiert:

* alle Stacks wurden erfolgreich angestoßen
* kein dauerhaft laufender Prozess erforderlich

---

## Ergebnis

* automatischer Start aller Docker-Stacks
* Reverse Proxy frühzeitig verfügbar
* konsistenter Zustand nach Reboot oder Stromausfall
* kein manuelles Eingreifen erforderlich

---

## Weiterführend

> Hinweis: Die folgenden Verweise sind für die GitHub-Navigation vorgesehen.

* `pages/Betrieb/Wiederanlauf-Playbook.md`
* `pages/Einstieg/Kritische-Systeme.md`
