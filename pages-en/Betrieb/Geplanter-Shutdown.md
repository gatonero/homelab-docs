---
title: "Betrieb – Geplanter Shutdown"
---

# Betrieb – Geplanter Shutdown

← Zurueck zur [`Overview`](/pages/Betrieb/Overview-Betrieb.md)

Hinweis: Die Rolle des Reverse Proxys innerhalb des Ingress ist
netzwerkseitig beschrieben unter:
[`Netzwerk – Reverse Proxy und Zugriffspfade`](/pages/Netzwerk-DNS-TLS/Reverse-Proxy-und-Zugriffspfade.md)

## Zweck

Dieses Dokument beschreibt den **standardisierten, geplanten Shutdown** des Homelabs.

Ziel ist ein **kontrolliertes, verlustfreies Herunterfahren** aller Systeme, sodass:

* Daten konsistent bleiben
* der anschließende Wiederanlauf deterministisch erfolgt
* keine manuellen Reparaturschritte nötig sind

Dieses Dokument ist das **Gegenstück** zum *Wiederanlauf-Playbook*.

---

## Gültigkeitsbereich

Der geplante Shutdown umfasst:

* Docker-VM
* darauf laufende Docker-Stacks
* Proxmox-Host(s)
* NAS

Nicht enthalten:

* Wartungsarbeiten an einzelnen Applikationen
* Backup- oder Restore-Prozesse (separate Dokumente)

---

## Grundprinzip

Der Shutdown erfolgt **in umgekehrter Reihenfolge des Wiederanlaufs**:

1. Dienste
2. Docker-VM
3. Proxmox-Host
4. NAS

---

## Schritt 1 – Dienste (Docker-Stacks)

Auf der Docker-VM:

```bash
cd /opt/docker
sudo systemctl stop docker-compose-autostart.service
```

Optional (kontrolliert):

```bash
for d in /opt/docker/*; do
  if [ -f "$d/docker-compose.yml" ]; then
    cd "$d" && docker compose down
  fi
done
```

Erwartung:

* alle Container sauber beendet
* keine laufenden Applikationsprozesse

---

## Schritt 2 – Docker-VM

```bash
sudo shutdown -h now
```

Erwartung:

* VM fährt sauber herunter
* keine hängenden Prozesse

---

## Schritt 3 – Proxmox-Host

* Proxmox-Web-UI öffnen
* prüfen, dass alle VMs gestoppt sind
* Host herunterfahren

Alternativ (CLI):

```bash
shutdown -h now
```

---

## Schritt 4 – NAS

* NAS über Web-UI herunterfahren
* vollständiges Ausschalten abwarten

Begründung:
Das NAS wird zuletzt heruntergefahren, da es Daten für alle vorgelagerten Systeme bereitstellt.

---

## Abschlusskriterium

Der Shutdown gilt als erfolgreich, wenn:

* alle Systeme ausgeschaltet sind
* keine Fehlermeldungen aufgetreten sind
* keine Dateninkonsistenzen vorliegen

---

## Hinweise

* Dieser Ablauf ist für **geplante** Abschaltungen gedacht.
* Bei Stromausfall greift ausschließlich das *Wiederanlauf-Playbook*.
* Reihenfolge nicht ändern, um Seiteneffekte zu vermeiden.

---

## Weiterfuehrend

* [`Wiederanlauf-Playbook`](/pages/Betrieb/Wiederanlauf-Playbook.md)
* [`Kritische Systeme`](/pages/Einstieg/Kritische-Systeme.md)
