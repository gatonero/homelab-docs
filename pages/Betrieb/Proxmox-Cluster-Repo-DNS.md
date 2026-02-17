---
title: "Proxmox-Cluster-Repo-DNS"
---

# Repo- und DNS-Harmonisierung für stabile Paketverwaltung im Proxmox-Cluster

---

## Zielbild

- Einheitliche, reproduzierbare DNS-Konfiguration auf allen Proxmox-Nodes.
- Einheitliche, saubere APT-Repository-Konfiguration ohne Dubletten, ohne Beta-Test-Repos.
- Enterprise-Repos sind vorhanden, aber zuverlässig deaktiviert (nur als Referenz/Platzhalter).

---

## Scope

- Betroffene Nodes:
  - pve-01 (192.168.1.26)
  - pve-02 (192.168.1.25)
  - pve-03 (192.168.1.24)
- DNS-Resolver (LAN): 192.168.1.110 (AdGuard)
- DNS-Search-Domain: fritz.box

---

## DNS-Konfiguration

### Sollzustand

- DNS wird über ifupdown2 aus `/etc/network/interfaces` in die Resolver-Konfiguration übernommen.
- Auf jedem Node ist im `vmbr0`-Stanza gesetzt:
  - `dns-nameservers 192.168.1.110`
  - `dns-search fritz.box`
- Erwartetes Ergebnis in `/etc/resolv.conf`:
  - `search fritz.box`
  - `nameserver 192.168.1.110`

---

## APT-Repository-Konfiguration

### Kanonischer Satz an Source-Dateien

- `/etc/apt/sources.list` ist leer (Datei existiert, aber ohne Inhalt).
- `/etc/apt/sources.list.d/` enthält ausschließlich:
  - `debian.sources`
  - `pve-no-subscription.sources`
  - `ceph-no-subscription.sources`
  - `pve-enterprise.sources.disabled`
  - `ceph.sources.disabled`

---

## Debian (Trixie)

- `debian.sources` verwendet:
  - `http://deb.debian.org/debian` (Suites: `trixie`, `trixie-updates`)
  - `http://security.debian.org/debian-security` (Suite: `trixie-security`)
  - Components: `main contrib non-free-firmware`
  - Signed-By: `/usr/share/keyrings/debian-archive-keyring.gpg`

---

## Proxmox (No-Subscription)

- `pve-no-subscription.sources`
  - `http://download.proxmox.com/debian/pve`
  - Suite: `trixie`
  - Component: `pve-no-subscription`

- `ceph-no-subscription.sources`
  - `http://download.proxmox.com/debian/ceph-squid`
  - Suite: `trixie`
  - Component: `no-subscription`

---

## Proxmox Enterprise (deaktiviert)

- Enterprise-Repos liegen ausschließlich als `*.disabled` vor:
  - `pve-enterprise.sources.disabled` (URIs: `https://enterprise.proxmox.com/debian/pve`)
  - `ceph.sources.disabled` (URIs: `https://enterprise.proxmox.com/debian/ceph-squid`)

---

## Validierung

### DNS-Smoketests (alle Nodes)

- `getent hosts deb.debian.org`
- `getent hosts security.debian.org`
- `getent hosts download.proxmox.com`

---

### DNS-Persistenztest (alle Nodes)

- `ifreload -a`
- Erwartung: `/etc/resolv.conf` bleibt bei `nameserver 192.168.1.110`.

---

### APT-Smoketest (alle Nodes)

- `rm -rf /var/lib/apt/lists/*`
- `apt-get update`
- Erwartung:
  - keine Fehler
  - keine Warnungen zu Duplicate-Sources
  - Enterprise-URIs ausschließlich in `*.disabled`

---

## Ergebnis

- DNS ist auf allen Nodes einheitlich und stabil.
- APT-Repos sind auf allen Nodes vereinheitlicht und bereinigt.
- Keine Beta-Test-Repos aktiv.
- Enterprise-Repos bleiben als deaktivierte Referenz vorhanden.

---

## Weiterfuehrend

- Boot-Stack und ESP-Sync (Ist): [Proxmox-Cluster-Boot-ESP-Sync](./Proxmox-Cluster-Boot-ESP-Sync.md)

