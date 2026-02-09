---
title: "Backup-Proxmox-Cluster"
---

# Cluster-Backups: Proxmox-Job + Restore-Validierung

---

## Ziel

Ein vollständiges Backup umfasst den **gesamten Zustand des Proxmox-Clusters**:
- alle QEMU-VMs
- alle LXCs
- clusterweit (alle Nodes)

Zusätzlich ist ein Backup erst dann „valide“, wenn ein **idempotenter Restore-Test** durchgeführt und dokumentiert ist.

---

## Geltungsbereich

Proxmox-Cluster `homelab` (Nodes: pve-01, pve-02, pve-03) auf gemeinsames Backup-Storage `TS-464-nfs`.

---

## Proxmox Backup Job (GUI)

Pfad: `Datacenter -> Backup`

Vorgabe (Zielzustand):
- Node: `All`
- Storage: `TS-464-nfs`
- Schedule: `03:00`
- Compression: `ZSTD`
- Mode: `Snapshot`
- Selection mode: `All`
- Enabled: `true`

Retention (Empfehlung, an Storage-Kapazität anpassen):
- keep-daily: 14
- keep-weekly: 8
- keep-monthly: 12
- optional keep-yearly: 2

---

## Backup-Umfang (Ist)

Laufende Gäste (Referenzliste zur Validierung, Stand: 2026-02-09):
- pve-01: CT 102 (Adguard), CT 103 (uptime-kuma), CT 104 (infra-ddclient), VM 200 (docker-vm), VM 1020 (nginx-base)
- pve-02: CT 120 (elselevy7-org), VM 100 (Home-Assistant), VM 1100 (paperless-vm)
- pve-03: aktuell keine laufenden Gäste

Hinweis: „Selection mode = All“ sichert auch nicht laufende und zukünftige Gäste automatisch.

---

## Restore-Validierung (Pflicht)

Ein Backup gilt erst dann als „valide“, wenn mindestens ein Restore-Test durchgeführt wurde:

Pflichtkriterien:
1. Restore aus Backup-Archiv erfolgreich (CT/VM wird erstellt)
2. Start erfolgreich
3. Grundfunktion ok (minimaler Smoke-Test je System)
4. Ergebnis dokumentiert (Datum, Backup-Archivname, Ziel-VMID/CTID, Testresultat)

---

## Smoke-Tests (Minimal)

- nginx-base: `curl -sS -o /dev/null -w "HTTP=%{http_code}\n" http://elselevy7.org`
- AdGuard: UI erreichbar / DNS-Query intern ok
- infra-ddclient: ddclient läuft und kann Cloudflare API erreichen
- uptime-kuma: Monitor für elselevy7.org zeigt „Up“
- docker-vm: Portainer/Stack erreichbar (oder definierter Dienst)
- Home Assistant: Web-UI erreichbar
- paperless-vm: Web-UI erreichbar
- elselevy7-org (CT): Web-UI erreichbar

---

## Sicherheit

Backups können sensible Inhalte enthalten (Konfiguration, Schlüssel, Tokens in Configs).  
Backup-Storage ist daher als **kritisch** zu behandeln (Zugriffskontrolle, Offline-/Immutable-Strategie nach Bedarf).


---

## Durchgeführte Restore-Tests (Ist)

- Datum: 2026-02-09
  - Quelle: vzdump-lxc-104-2026_02_09-18_47_22.tar.zst
  - Restore: CT 104 → CT 9104 (Test-CTID)
  - Isolation: net0 link_down=1 (keine externen Effekte)
  - Smoke-Test: ddclient enabled + nach Start active (running)
  - Hinweis: DNS/API-Fehler im Log erwartbar wegen link_down=1

