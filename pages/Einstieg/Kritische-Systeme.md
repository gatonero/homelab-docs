# Einstieg – Kritische Systeme

## Zweck

Diese Seite dient als **minimaler, DNS-unabhängiger Einstiegspunkt** für den Betrieb und den Wiederanlauf des Homelabs.

Sie wird insbesondere genutzt:

* nach Stromausfall
* nach geplantem Shutdown
* bei Problemen mit DNS oder Reverse Proxy

Alle Zugriffe erfolgen **ausschließlich über feste IP-Adressen**.

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

* Diese Seite ist **bewusst kurz gehalten**.
* Weitere Dienste (Monitoring, Management, Applikationen) sind **nicht** Teil dieses Einstiegs.
* Änderungen an IP-Adressen müssen hier **zuerst** nachgeführt werden.

---

## Ablageort

```
pages/Einstieg/Kritische-Systeme.md
```

Diese Seite ist Bestandteil des operativen Betriebs und wird im Rahmen von Architektur- oder Netzwerkänderungen aktualisiert.
