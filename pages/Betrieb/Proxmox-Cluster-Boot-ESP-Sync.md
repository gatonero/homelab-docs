---
title: "Proxmox-Cluster-Boot-ESP-Sync"
---

# Boot-Stack und ESP-Sync-Verhalten im Proxmox-Cluster (Ist-Zustand)

---

## Ist-Zustand

### UEFI / Secure Boot

- pve-01: UEFI = yes, SecureBoot = disabled
- pve-02: UEFI = yes, SecureBoot = disabled
- pve-03: UEFI = yes, SecureBoot = disabled (zusätzlich: Platform is in Setup Mode)

---

### Bootloader-Stack (Pakete)

- GRUB (EFI) ist installiert.
- shim-signed ist installiert.
- systemd-boot ist nicht installiert.

---

### Kernel-Postinst-Hooks

- /etc/kernel/postinst.d/zz-proxmox-boot ist vorhanden.
- Owner: proxmox-kernel-helper

---

### ESP-Sync (proxmox-kernel-helper)

In /usr/share/proxmox-kernel-helper/scripts/functions ist ESP_LIST definiert als:

- ESP_LIST="/etc/kernel/proxmox-boot-uuids"

Clusterweit gilt:

- /etc/kernel/proxmox-boot-uuids existiert nicht (pve-01 / pve-02 / pve-03)

Konsequenz:

- zz-proxmox-boot loggt erwartbar: "No /etc/kernel/proxmox-boot-uuids found, skipping ESP sync."
- Es findet kein ESP-Sync statt (Feature nicht konfiguriert/aktiv).

Bewertung:

- Das ist kein Fehlerzustand, sondern ein deaktiviertes Feature.
- Zielzustand (Ziel A): keine Änderung am System; nur Dokumentation des Ist-Zustands und der erwartbaren Warnung.
