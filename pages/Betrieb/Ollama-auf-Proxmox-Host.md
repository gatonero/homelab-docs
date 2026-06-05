---
title: "Ollama-auf-Proxmox-Host"
---

# Betrieb von Ollama direkt auf dem Proxmox-Host

## Ziel

Ollama wird bewusst direkt auf dem Proxmox-Host `pve-02` betrieben und nicht in einer VM, einem LXC-Container oder einem Docker-Container.

Ziel ist die bestmögliche CPU-Performance bei minimaler Komplexität.

---

## Architektur

```text
Open WebUI
    │
    ▼
docker-vm
192.168.1.63:3002

    │
    ▼

Ollama API
192.168.1.25:11434

    │
    ▼

pve-02
AMD Ryzen 7 8700G
```

---

## Begründung

Folgende Varianten wurden bewertet:

| Variante | Ergebnis |
|-----------|-----------|
| VM auf pve-01 | Technisch funktionsfähig, jedoch zu langsam |
| VM auf pve-02 | Funktionsfähig, zusätzlicher Verwaltungsaufwand |
| Docker auf docker-vm | Zusätzlicher Netzwerk- und Betriebsaufwand |
| Direkter Betrieb auf pve-02 | Einfachste und performanteste Lösung |

Der direkte Betrieb auf dem Host wurde als Zielzustand festgelegt.

---

## Host

```text
Hostname: pve-02
IP: 192.168.1.25
Rolle: Proxmox VE Node
CPU: AMD Ryzen 7 8700G
```

---

## Installation

Ollama wird als Systemd-Service betrieben.

Service-Datei:

```text
/etc/systemd/system/ollama.service
```

Prüfung:

```bash
systemctl status ollama
```

---

## Netzwerk

Ollama lauscht auf:

```text
0.0.0.0:11434
```

Prüfung:

```bash
ss -tlnp | grep 11434
```

---

## Konfiguration

Override-Datei:

```text
/etc/systemd/system/ollama.service.d/override.conf
```

Aktueller Inhalt:

```ini
[Service]
Environment="OLLAMA_HOST=0.0.0.0:11434"
```

Prüfung:

```bash
systemctl cat ollama
```

---

## Modelle

Installierte Modelle:

```bash
ollama list
```

Aktuell produktiv verwendet:

```text
gemma3:4b
```

---

## GPU-Unterstützung

Der Host besitzt eine integrierte:

```text
AMD Radeon 780M
gfx1103
```

ROCm erkennt die GPU grundsätzlich.

Ollama 0.30.5 unterstützt den GPU-Typ derzeit nicht stabil.

Beobachtete Fehler:

```text
ROCm launch failure
GPU reset
HTTP 500
```

Der produktive Betrieb erfolgt daher ausschließlich über CPU-Inferenz.

---

## Open WebUI

Open WebUI läuft getrennt auf:

```text
docker-vm
192.168.1.63
```

Container-Port:

```text
3002/tcp
```

Verbindung zu Ollama:

```text
http://192.168.1.25:11434
```

---

## Reverse Proxy

Interne URL:

```text
https://openwebui.home.arpa
```

Routing:

```text
openwebui.home.arpa
        │
        ▼
nginx-base
192.168.1.30
        │
        ▼
docker-vm:3002
        │
        ▼
Open WebUI
```

TLS-Termination erfolgt auf `nginx-base`.

---

## DNS

DNS-Rewrite in AdGuard:

```text
openwebui.home.arpa
→ 192.168.1.30
```

---

## Home Assistant

Home Assistant nutzt die Ollama-API direkt:

```text
http://192.168.1.25:11434
```

---

## Zed

Zed nutzt die Ollama-API direkt:

```text
http://192.168.1.25:11434
```

---

## Betriebsmodell

```text
pve-02
 └── Ollama

docker-vm
 └── Open WebUI

nginx-base
 └── TLS-Termination

AdGuard
 └── DNS-Rewrite
```

---

## Bekannte Einschränkungen

- Keine produktive GPU-Beschleunigung verfügbar.
- Modellgrößen über 8B sind auf CPU nur eingeschränkt sinnvoll.
- Bei neuen Ollama- oder ROCm-Versionen sollte die Unterstützung für `gfx1103` erneut geprüft werden.

---

## Betriebsprüfungen

Ollama-Service:

```bash
systemctl status ollama
```

Installierte Modelle:

```bash
ollama list
```

API erreichbar:

```bash
curl http://127.0.0.1:11434/api/tags
```

API aus dem LAN erreichbar:

```bash
curl http://192.168.1.25:11434/api/tags
```

Open WebUI erreichbar:

```bash
curl -Ik https://openwebui.home.arpa
```

---

## Zielzustand

```text
pve-02 (192.168.1.25)
└── Ollama
    └── gemma3:4b

docker-vm (192.168.1.63)
└── Open WebUI

nginx-base (192.168.1.30)
└── HTTPS Reverse Proxy

AdGuard (192.168.1.110)
└── DNS Rewrite

Home Assistant
└── Direkte Ollama-Anbindung

Zed
└── Direkte Ollama-Anbindung
```
