---
title: "SMTP TCP25 Policy"
---

# Clusterweit kein SMTP/25; Notifications via SMTP Submission (587)

---

## Ziel

- Outbound **TCP/25** ist auf allen Proxmox-Nodes **gesperrt** (IPv4+IPv6).
- Inbound **TCP/25** ist auf den Nodes **nicht aus dem LAN erreichbar** (Postfix nur loopback).
- Proxmox Notifications werden **ausschließlich** über den Proxmox Notification SMTP Endpoint (Submission) versendet.
  - Endpoint: `smtp-gmail-christoph`
  - Server: `smtp.gmail.com`
  - Port: `587`
  - Mode: `starttls`

---

## Motivation

- Vermeidung von unkontrollierten SMTP/25-Verbindungen (Abuse/Spam-Risiko, Reputation, Provider-Policies).
- Klare Trennung:
  - Postfix lokal nur als Übergabe (local → proxmox-mail-forward),
  - Zustellung nach extern ausschließlich über Proxmox Notification Endpoint.

---

## Scope

- Nodes: `pve-01`, `pve-02`, `pve-03`
- Datum der Umsetzung: 2026-02-17

---

## Umsetzung

### Schicht 1: OS-Firewall (Egress-Block)

- systemd Unit: `block-egress-25.service` (enabled)
- Script: `/usr/local/sbin/block-egress-25`
- Wirkung:
  - `iptables` OUTPUT: `--dport 25` → `REJECT`
  - `ip6tables` OUTPUT: `--dport 25` → `REJECT`

### Schicht 2: Postfix Outbound deaktiviert

- `default_transport` und `relay_transport` sind auf `error:` gesetzt.
- Wirkung: selbst bei Fehldesign/Fehlkonfig kann Postfix nicht als Outbound-SMTP genutzt werden.

### Schicht 3: Postfix inbound auf Loopback begrenzt

- `inet_interfaces = loopback-only`
- Wirkung: Listener nur auf `127.0.0.1:25` und `::1:25`, kein LAN-Listener auf `0.0.0.0:25`.

---

## Evidenz (Ist, 2026-02-17)

### Egress TCP/25 blockiert (Beispielregel)

- `iptables -S OUTPUT` enthält:
  - `-A OUTPUT -p tcp -m tcp --dport 25 -j REJECT --reject-with icmp-port-unreachable`
- `ip6tables -S OUTPUT` enthält:
  - `-A OUTPUT -p tcp -m tcp --dport 25 -j REJECT --reject-with icmp6-port-unreachable`

### Postfix: loopback-only

- `ss -lntp` zeigt nur:
  - `127.0.0.1:25`
  - `::1:25`

### Postfix: outbound deaktiviert

- `postconf -n` zeigt:
  - `default_transport = error:outbound smtp disabled; use proxmox notification smtp endpoint`
  - `relay_transport   = error:outbound smtp disabled; use proxmox notification smtp endpoint`

### Proxmox Notifications: Endpoint-Konfiguration

- `pvesh get /cluster/notifications/endpoints/smtp/smtp-gmail-christoph`:
  - server: `smtp.gmail.com`
  - port: `587`
  - mode: `starttls`
  - from-address / mailto / username: `christoph.schwaeppe@gmail.com`

### Failure-Injection bestätigt Pfad (587)

- Temporäres Blocken von TCP/587 führte bei:
  - `pvesh create /cluster/notifications/targets/smtp-gmail-christoph/test`
- zu:
  - `500 Could not test target ... Connection error: Network is unreachable (os error 101)`
  - Returncode `101`

---

## Verifikation (Cookbook)

### Auf jedem Node

- Status Firewall-Unit:
  - `systemctl is-enabled block-egress-25.service`
  - `systemctl is-active block-egress-25.service`

- Regeln:
  - `iptables -S OUTPUT | grep -F -- "--dport 25"`
  - `ip6tables -S OUTPUT | grep -F -- "--dport 25"`

- Inbound:
  - `postconf -n | grep -E '^inet_interfaces *= '`
  - `ss -lntp | grep -E '(:25[[:space:]])'`

### Proxmox Notification Test

- `pvesh create /cluster/notifications/targets/smtp-gmail-christoph/test`

---

## Rollback (bewusst nicht automatisch)

Rollback ist möglich, aber nicht vorgesehen. Wenn erforderlich:

- systemd Unit deaktivieren + Regeln entfernen:
  - `systemctl disable --now block-egress-25.service`
  - `/usr/local/sbin/block-egress-25 --remove`

- Postfix Defaults zurücksetzen (nur nach expliziter Freigabe):
  - `postconf -X default_transport`
  - `postconf -X relay_transport`
  - `postconf -e "inet_interfaces = all"`
  - `systemctl restart postfix`

