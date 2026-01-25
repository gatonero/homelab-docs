---
title: "Admin – Dashboard"
---

# Admin – Dashboard

← Zurueck zur [`Overview`](/pages/00-Overview-Homelab.md)

## Zweck

Diese Seite dient als **zentrale Admin- und Komfortübersicht** für das Homelab.

Sie bündelt **alle regelmäßig genutzten Verwaltungs‑, Monitoring‑ und Service‑Oberflächen** an einem Ort.

> ⚠️ Diese Seite ist **kein Notfall‑ oder Wiederanlauf‑Einstieg**.
> Für den Betrieb im Fehlerfall ist ausschließlich **„Einstieg – Kritische Systeme“** maßgeblich.

---

## Admin / Infrastruktur

```yaml
Admin:
  - Fritzbox:
      href: http://192.168.1.1
      icon: avm-fritzbox.png
  - TS-464:
      href: https://192.168.1.31:8080/cgi-bin/
      icon: qnap.png
  - Proxmox:
      href: https://192.168.1.26:8006
      icon: proxmox.png
  - AdGuard:
      href: http://192.168.1.28/
      icon: adguard-home.png
  - NGINX:
      href: http://192.168.1.63:81/
      icon: nginx.png
  - Home Assistant:
      href: http://192.168.1.40:8123
      icon: home-assistant.svg
  - Uptime Kuma:
      href: https://uptime.home.arpa
      icon: uptime-kuma.png
  - Portainer docker-vm:
      href: https://portainer-docker-vm.home.arpa
      icon: portainer.png
  - Portainer QNAP:
      href: https://portainer-qnap.home.arpa
      icon: portainer.png
  - NetBox:
      href: https://netbox.home.arpa
      icon: netbox.png
  - myQNAPcloud Link:
      href: https://qlink.to/gatonero
      icon: si-qnap.svg-#17bbf2
  - Syncthing Mini-IT13:
      href: http://127.0.0.1:8384
      icon: syncthing.svg
  - Syncthing TS-464:
      href: http://192.168.1.31:8384
      icon: syncthing.svg
  - elselevy7.org:
      href: https://elselevy7.org
      icon: /icons/avatar_rund.png
  - Cloudflare:
      href: https://dash.cloudflare.com/login
      icon: cloudflare.png
  - dokuwiki Farmer - TS-464:
      href: http://192.168.1.31:40110
      icon: http://192.168.1.31:40110/lib/tpl/dokuwiki/images/logo.png
  - dragino:
      href: http://192.168.1.50:8000/
      icon: dragino.png
  - FRITZ!WLAN Repeater 1750E:
      href: http://192.168.1.2
      icon: avm-fritzbox.png
  - TP-Link:
      href: http://192.168.1.30
      icon: /icons/TP-Link-Logo.png
  - Brother MFC L2710DW:
      href: http://192.168.1.25/general/status.html
      icon: brother.png
```

---

## Hinweise

* DNS‑basierte URLs (`*.home.arpa`) sind hier **bewusst erlaubt**.
* Diese Seite ist für den **Normalbetrieb und Komfort** gedacht.
* Änderungen an Diensten oder URLs sollten hier zeitnah nachgeführt werden.

---

## Ablageort

```
pages/Admin/Admin-Dashboard.md
```

Diese Seite ergänzt die operative Dokumentation, ist jedoch **nicht kritisch für den Wiederanlauf**.

---

## Weiterfuehrend

* [`Einstieg – Kritische Systeme`](/pages/Einstieg/Kritische-Systeme.md)
* [`Betrieb – Wiederanlauf-Playbook`](/pages/Betrieb/Wiederanlauf-Playbook.md)
* [`Betrieb – Docker-VM Autostart & Reverse Proxy`](/pages/Betrieb/Betrieb-Docker-VM-Autostart-Reverse-Proxy.md)

## Hinweis

Für den Betrieb im Fehlerfall und den Wiederanlauf ist **nicht** diese Seite maßgeblich.

➡ Siehe: [`Einstieg – Kritische Systeme`](/pages/Einstieg/Kritische-Systeme.md)
