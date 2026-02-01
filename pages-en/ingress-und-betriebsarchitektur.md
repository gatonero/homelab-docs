---
title: "Ingress- und Betriebsarchitektur"
---

# Ingress- und Betriebsarchitektur

> **Ziel dieses Dokuments**  
> Beschreibung der realen, produktiven Architektur des Homelabs mit Fokus auf Robustheit, Wiederanlauf, Ingress, TLS und Betrieb.  
> Dieses Dokument bildet den **Ist-Zustand** ab und dient als Grundlage für Betrieb, Fehlersuche und Weiterentwicklung.

---

## 1. Überblick

### 1.1 Zielarchitektur

* Ein zentraler Ingress-Punkt für interne und externe Dienste
* Klare Trennung von Rollen (Ingress, Applikationen, Storage)
* Keine Storage-Abhängigkeiten im Ingress-Pfad

### 1.2 Leitprinzipien

* Technisch robust (Ausfall & Wiederanlauf ohne Eingriffe)
* Methodisch sauber (keine dauerhaften Provisorien)
* Dokumentation = Realität
* Architektur innerhalb des festgelegten Rahmens

---

## 2. Ingress & Netzwerk

### 2.1 Rolle des Ingress

Der Ingress ist der **einzige Eintrittspunkt** für sämtlichen HTTP(S)-Traffic – intern wie extern.
Er übernimmt ausschließlich Netzwerk- und Transportaufgaben:

* TLS-Terminierung
* Routing nach Hostnamen
* Protokoll-Weitergabe an Backend-Services

Der Ingress enthält **keine Applikationslogik** und **keinen persistenten Storage**.
Dadurch bleibt er stabil bei Ausfällen anderer Komponenten und ist unabhängig vom Startzustand einzelner Dienste.

### 2.2 Implementierung: NGINX-LXC

Der Ingress ist als **dedizierter LXC-Container** auf dem Proxmox-Host umgesetzt.

**Begründung für LXC:**

* Sehr schneller Start (relevant für Wiederanlauf nach Stromausfall)
* Keine Abhängigkeit von Docker-Daemons oder Overlay-Netzen
* Geringer Ressourcenverbrauch
* Klare Rolle: Systemdienst, nicht Applikationscontainer

**Bewusste Abgrenzung:**

* Keine VM (unnötiger Overhead)
* Kein Docker (keine zusätzliche Orchestrierungsebene im Ingress)

### 2.3 Interne Hosts (`.home.arpa`)

Interne Dienste werden über feste Hostnamen im Namespace `.home.arpa` angesprochen.

**Eigenschaften:**

* Namensauflösung über AdGuard
* Alle internen Hostnamen zeigen auf den Ingress
* Routing erfolgt ausschließlich über NGINX

**Vorteile:**

* Konsistenter Zugriff unabhängig vom Backend-Standort
* Zentrale Kontrolle über TLS und Weiterleitungen
* Vereinfachte Fehlersuche durch einen eindeutigen Einstiegspunkt

### 2.4 Externe Hosts (öffentliche Domains)

Öffentliche Domains (z. B. `elselevy7.org`) werden ebenfalls über den Ingress geführt.

**Besonderheiten:**

* Öffentliche DNS-Auflösung über Cloudflare
* Dynamische IP-Aktualisierung über `ddclient`
* Umschaltpunkt ist der Router (Port-Forwarding auf den Ingress)

Interne und externe Dienste nutzen **dieselbe Ingress-Instanz**, unterscheiden sich jedoch in DNS-Quelle und Zertifikatsherkunft.

---

## 3. TLS & Zertifikate

### 3.1 Grundsätzliche TLS-Strategie

Die TLS-Terminierung erfolgt **ausschließlich im Ingress (NGINX-LXC)**.
Backend-Services werden intern ausschließlich über **HTTP** angesprochen.

**Begründung:**

* Eine zentrale TLS-Instanz reduziert Komplexität und Fehlerquellen
* Backend-Dienste müssen keine Zertifikate verwalten
* Einheitliches Verhalten für interne und externe Zugriffe

TLS ist damit Teil der **Netzwerk- und Transportebene**, nicht der Applikationsebene.

### 3.2 ACME-Client: `acme.sh`

Für die Zertifikatsverwaltung wird **`acme.sh`** eingesetzt.

**Entscheidungsgründe:**

* Native Unterstützung von DNS-01-Challenges
* Sehr gute Integration mit Cloudflare
* Kein zusätzlicher Systemdienst erforderlich
* Transparente und robuste Renewal-Mechanik

Alternativen wie `certbot` wurden bewusst verworfen, da sie für dieses Szenario unnötigen Overhead erzeugen.

### 3.3 DNS-01 Challenge mit Cloudflare

Alle öffentlichen Zertifikate werden über **DNS-01** validiert.

**Vorteile von DNS-01:**

* Unabhängig von offenen Ports (80/443)
* Robust bei dynamischer öffentlicher IP
* Erneuerung auch bei nicht laufenden Backend-Services möglich

Die DNS-Challenge wird über einen minimal berechtigten Cloudflare-API-Token umgesetzt.

### 3.4 Zertifikatsablage & Rechte

Zertifikate werden auf dem Ingress in einer klar strukturierten Verzeichnisstruktur abgelegt:

```
/etc/nginx/ssl/
├── internal/
└── external/
    └── elselevy7.org/
        ├── fullchain.pem
        └── privkey.pem
```

**Rechte:**

* `privkey.pem`: `600` (root:root)
* `fullchain.pem`: `644` (root:root)

### 3.5 Renewal & Reload

`acme.sh` installiert automatisch einen Cronjob zur regelmäßigen Prüfung und Erneuerung der Zertifikate.
Nach erfolgreicher Erneuerung wird automatisch ein `nginx reload` ausgelöst.

---

## 4. DNS & Dynamic IP

### 4.1 Interner DNS

Die interne Namensauflösung erfolgt über **AdGuard**.

* Feste interne IP-Adressen
* Alle internen Hostnamen zeigen auf den Ingress
* Keine direkten Backend-Zugriffe per DNS

### 4.2 Externer DNS (Cloudflare)

Cloudflare dient ausschließlich als **autoritativer DNS**.

* DNS-only
* Kein HTTP-Proxy
* Volle Kontrolle über den Datenpfad

### 4.3 Dynamic IP Update

Die öffentliche IP wird über `ddclient` aktualisiert.

* Docker-Container auf QNAP
* Aktualisierung der A-Records für `elselevy7.org` und `www.elselevy7.org`

### 4.4 Zusammenspiel DNS ↔ Router

Der Router ist der **entscheidende Umschaltpunkt**:

* DNS zeigt auf die öffentliche IP
* Router leitet HTTPS an den Ingress weiter

---

## 5. Boot- & Wiederanlaufverhalten

### 5.1 Abhängigkeiten

1. Router
2. Proxmox-Host
3. Ingress (NGINX-LXC)
4. Backend-Services

### 5.2 Erkenntnisse aus Stromausfalltests

Frühere Architekturen zeigten:

* Storage-Abhängigkeiten im Ingress
* Manuelle Eingriffe beim Wiederanlauf

### 5.3 Neuer Zielzustand

* Ingress startet unabhängig
* TLS-Zertifikate lokal vorhanden
* Vollständiger Wiederanlauf ohne Eingriffe

### 5.4 Bewusste Vereinfachungen

* Kein Storage
* Kein Docker
* Keine dynamischen Konfigurationsquellen

---

## 6. Betrieb & Fehlersuche

### 6.1 Prüfpfad

1. DNS
2. Router
3. Ingress
4. Backend

### 6.2 Ingress-Prüfung

```bash
systemctl status nginx
nginx -t
journalctl -u nginx
```

### 6.3 Backend-Prüfung

* Container-Status
* Direktzugriff per IP:Port (HTTP)

### 6.4 Rollback

Rollback ist **temporär** und dient ausschließlich der Wiederherstellung der Erreichbarkeit.

---

## 7. NetBox-Abbildung

### 7.1 Ingress

* Device: `nginx-lxc`
* Rolle: Ingress / Reverse Proxy
* Feste Management-IP

### 7.2 Abhängigkeiten

Backend-Services werden logisch dem Ingress zugeordnet.

---

## Weiterführend

* [`Wiederanlauf-Playbook`](/pages/Betrieb/Wiederanlauf-Playbook.md)
* [`Overview Netzwerk, DNS und TLS`](/pages/Netzwerk-DNS-TLS/Overview-Netzwerk-DNS-TLS.md)
* [`NetBox als Source of Truth`](/pages/NetBox/NetBox-als-Source-of-Truth.md)
* [`Overview Architektur`](/pages/Architektur/Overview-Architektur.md)
