# Einstieg – Kritische Systeme

## Zweck

Minimaler, DNS-unabhängiger Einstiegspunkt für Betrieb und Wiederanlauf.

Diese Seite wird genutzt:

* nach Stromausfall
* nach geplantem Shutdown
* bei Problemen mit DNS oder Reverse Proxy

---

## Kritische Systeme

| System               | URL                                                    |
| -------------------- | ------------------------------------------------------ |
| Router (Fritz!Box)   | [http://192.168.1.1](http://192.168.1.1)               |
| NAS (TS-464)         | [https://192.168.1.31:8080](https://192.168.1.31:8080) |
| Proxmox Host (M720q) | [https://192.168.1.26:8006](https://192.168.1.26:8006) |
| AdGuard              | [http://192.168.1.28](http://192.168.1.28)             |
| Docker-VM (NGINX)    | [http://192.168.1.63:81](http://192.168.1.63:81)       |
| Home Assistant       | [http://192.168.1.40:8123](http://192.168.1.40:8123)   |

---

## Hinweise

* bewusst minimal gehalten
* ausschließlich IP-basierte URLs
* Änderungen an IPs hier zuerst pflegen

---

## Weiterführend

* [[Wiederanlauf-Playbook]]
