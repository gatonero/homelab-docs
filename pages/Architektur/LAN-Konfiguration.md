**Status:** überprüft und angepasst  
**Gültig ab:** 2026-01-16  
**Versionsdatum:** 2026-01-16

---

# 1. Überblick

Dieses Dokument beschreibt die **verbindliche Architektur** des Homelabs. Es dient als **technische Referenz**, Entscheidungsgrundlage für Änderungen sowie als Grundlage für Wiederherstellung (Restore) und Fehlersuche.

Die Dokumentation ist **manuell gepflegt**, orientiert sich jedoch strikt an NetBox als *Source of Truth* und ist jederzeit erweiter- und aktualisierbar.

---

# 2. Namens- & DNS-Konzept

## 2.1 Interne Zone `home.arpa`

Alle internen Services werden ausschließlich unter der Zone `home.arpa` betrieben.

**Begründung:**
- RFC-konforme, reservierte Zone für Heim- und Lab-Netze
- Keine Kollision mit öffentlichen Domains
- Klare Trennung zwischen internem und externem Namensraum

## 2.2 DNS-Resolver

- Zentraler Resolver: **AdGuard Home**
- Alle Clients (inkl. Docker-Container) nutzen AdGuard als DNS

## 2.3 DNS-Prinzipien

- Keine direkten DNS-Einträge auf Backend-Systeme
- Alle Service-Namen zeigen auf den Reverse Proxy
- Keine CNAME-Ketten oder DNS-Loops

**Beispiel:**
```
netbox.home.arpa  → nginx-proxy-manager → Backend
```

---

# 3. Entry Points & Traffic Flow

## 3.1 Zentrales Entry-Point-Modell

```
Client → DNS (AdGuard) → Reverse Proxy (NPM) → Backend-Service
```

## 3.2 Reverse Proxy

- Produkt: **NGINX Proxy Manager**
- Rolle: Zentrale TLS-Terminierung
- Backends: ausschließlich HTTP

## 3.3 Sonderfall Proxmox

- Zugriff direkt via `https://proxmox.home.arpa:8006`
- Kein Reverse Proxy
- Eigenes Zertifikat

---

# 4. Zentrale Infrastruktur-Services

## 4.1 AdGuard Home

- Funktion: DNS, Ad-Blocking
- DNS-Zone: `home.arpa`
- Kritischer Infrastruktur-Service

## 4.2 NGINX Proxy Manager

- Zentrales HTTPS-Gateway
- Verwaltung interner und externer Zertifikate
- Einziger erlaubter Entry Point für Services

## 4.3 NetBox

- Rolle: Source of Truth
- Modelliert:
  - Devices & VMs
  - Application Services
  - Rollen & Abhängigkeiten

---

# 5. Applikations-Services (intern)

| Service | URL | Backend |
|------|-----|--------|
| AdGuard Web | https://adguard.home.arpa | HTTP :80 |
| Home Assistant | https://homeassistant.home.arpa | HTTP :8123 |
| Uptime Kuma | https://uptime.home.arpa | HTTP :3001 |
| Portainer (Docker-VM) | https://portainer-docker-vm.home.arpa | HTTP :9000 |
| Portainer (QNAP) | https://portainer-qnap.home.arpa | HTTP :9000 |
| NetBox | https://netbox.home.arpa | HTTP :8000 |

---

# 6. Öffentliche Services

## 6.1 Öffentliche Domain

- Domain: `elselevy7.org`
- DNS: externer Provider

## 6.2 Technische Umsetzung

```
Internet → WAN → NGINX Proxy Manager → interner Backend-Service
```

- TLS: Let’s Encrypt
- Keine direkte Exposition interner Systeme

---

# 7. Monitoring & Observability

## 7.1 Monitoring-System

- Tool: **Uptime Kuma**
- Standort: Docker-VM

## 7.2 Monitoring-Prinzipien

- Interne Services:
  - HTTPS
  - TLS-Fehler ignorieren (interne Zertifikate)
- Öffentliche Services:
  - HTTPS
  - TLS-Prüfung aktiv

---

# 8. Backup & Restore

## 8.1 Backup

- Orchestrator: Proxmox VE
- Ziel: QNAP TS-464
- Sicherung produktiver VMs

## 8.2 Restore-Erkenntnisse

- Restore **nur in produktive VMs** möglich
- Beispiel: `docker-vm`
- Nach Restore prüfen:
  - IP-Adresse
  - DNS-Auflösung
  - Zertifikate

---

# 9. Verbindliche Architekturregeln

- ❌ Kein direkter Zugriff auf Backend-IPs
- ❌ Kein TLS auf Backend-Services
- ❌ Kein Reverse Proxy für Proxmox
- ✅ DNS → Proxy → Backend
- ✅ NetBox ist führende Quelle

---

**Dieses Dokument ersetzt alle vorherigen Versionen vollständig.**

