---
title: "Einstieg – Kritische Systeme"
---

# Einstieg – Kritische Systeme

← Zurueck zur [`Overview`](/pages/00-Overview-Homelab.md)

## Zweck

Minimaler, **DNS-unabhängiger Einstiegspunkt** für Betrieb und Wiederanlauf.

Diese Seite wird genutzt:

* nach Stromausfall
* nach geplantem Shutdown
* bei Problemen mit DNS oder Reverse Proxy

Sie stellt den **stabilsten Zugriffspfad** auf alle **betriebs- und sicherheitskritischen Komponenten** dar.

---

## Kritische Systeme

| System               | URL                                                    |
| -------------------- | ------------------------------------------------------ |
| Router (Fritz!Box)   | [http://192.168.1.1](http://192.168.1.1)               |
| NAS (QNAP TS-464)    | [http://192.168.1.31:8080](http://192.168.1.31:8080)   |
| Proxmox Host (M720q) | [https://192.168.1.26:8006](https://192.168.1.26:8006) |
| AdGuard              | [http://192.168.1.28](http://192.168.1.28)             |
| Home Assistant       | [http://192.168.1.40:8123](http://192.168.1.40:8123)   |

---
### NGINX (Ingress)

Der zentrale NGINX läuft als **dedizierter LXC-Container** und stellt die
Ingress-Funktion für interne Services bereit.

* **Kein Web-Interface**
* **Kein direkter HTTP/HTTPS-Zugriff**
* Administration **ausschließlich per SSH**

**Zugriff:**

ssh <user>@192.168.1.30


Der Container ist bewusst **minimal und headless** ausgelegt, um die
Angriffsfläche zu reduzieren und den Betrieb auch bei gestörtem DNS oder
Reverse-Proxy-Abhängigkeiten stabil zu halten.

## Rolle des NAS (verbindlich)

Der **QNAP TS-464** ist der **zentrale Daten- und Backup-Anker** des Homelabs:

* zentrale Datenhaltung
* einzige Instanz für Offsite-Backups (HBS3 → Google Drive)
* maßgeblich für Wiederanlauf und Datenintegrität

Alle Backup-bezogenen Maßnahmen werden **ausschließlich** auf dem QNAP durchgeführt.

---

## Hinweise

* bewusst **minimal gehalten**
* ausschließlich **IP-basierte URLs**
* keine Abhängigkeit von:

  * DNS
  * Reverse Proxy
  * Zertifikaten
* Änderungen an IP-Adressen **hier zuerst pflegen**

---

## Abgrenzung

* **Mini-IT13**:

  * kein Backup-Knoten
  * keine Cloud-Anbindung
  * keine Backup-Tools aktiv

* **Syncthing**:

  * dient ausschließlich der Arbeitskopien
  * kein Backup

---

## Weiterfuehrend

* [`Betrieb – Wiederanlauf-Playbook`](/pages/Betrieb/Wiederanlauf-Playbook.md)

