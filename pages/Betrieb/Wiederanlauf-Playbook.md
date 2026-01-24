# Betrieb – Wiederanlauf-Playbook

## Zweck

Dieses Playbook beschreibt den **standardisierten Wiederanlauf** des Homelabs nach:

* geplantem Shutdown
* ungeplantem Stromausfall

Ziel ist ein deterministisches Vorgehen ohne situative Entscheidungen.

---

## Wiederanlauf – Übersicht

Empfohlene Reihenfolge:

1. Stromversorgung herstellen
2. NAS starten
3. Proxmox-Host starten
4. Docker-VM startet automatisch
5. Docker-Stacks starten automatisch
6. Funktionsprüfung

---

## Schritt 1 – Stromversorgung

* stabile Stromversorgung sicherstellen
* ggf. USV-Status prüfen

---

## Schritt 2 – NAS

* NAS einschalten
* warten, bis Storage und Netzwerkdienste verfügbar sind

---

## Schritt 3 – Proxmox-Host

* Proxmox-Host starten
* Management-UI erreichbar abwarten

---

## Schritt 4 – Docker-VM

* startet automatisch
* kein manuelles Eingreifen erforderlich

---

## Schritt 5 – Docker-Stacks

* Start erfolgt durch `docker-compose-autostart.service`
* erwarteter Zustand: alle produktiven Container `Up`

---

## Schritt 6 – Funktionsprüfung

* Reverse Proxy erreichbar
* kritische Dienste verfügbar

---

## Abschlusskriterium

Der Wiederanlauf gilt als erfolgreich, wenn:

* alle kritischen Systeme erreichbar sind
* keine manuellen Startmaßnahmen erforderlich waren

---

## Weiterführend

* [[Einstieg – Kritische Systeme]]
* [[Betrieb – Docker-VM Autostart & Reverse Proxy]]
