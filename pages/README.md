# HomeLab-Dokumentation

## Zweck dieses Repositories

Dieses Repository enthält die **verbindliche, konsolidierte Dokumentation** eines privat betriebenen HomeLabs.

Es beschreibt **Architektur, Prinzipien und betriebliche Abläufe** – nicht einzelne Befehle oder spontane Konfigurationen.
Ziel ist ein System, das:

* stabil betrieben werden kann
* reproduzierbar wiederherstellbar ist
* auch unter Stress verständlich bleibt
* ohne implizites Wissen funktioniert

Dieses Repository ist **kein How‑To‑Blog** und **kein Konfigurationsdump**.

---

## Wie dieses Repository zu lesen ist

Die Dokumentation folgt einer **klaren Hierarchie**.
Sie ist bewusst so aufgebaut, dass Leser zuerst **Prinzipien**, dann **Regeln** und erst danach **konkrete Umsetzungen** verstehen.

**Empfohlene Lesereihenfolge:**

1. Architektur
2. Netzwerk, DNS & TLS
3. NetBox
4. Services
5. Betrieb

Jeder Ordner enthält eine `00-Overview.md`, die als Einstiegspunkt dient.

---

## Ordnerstruktur

```
.
├── Architektur/
│   ├── 00-Overview.md
│   ├── Architektur-Gesamt.md
│   ├── Hardware.md
│   └── LAN-Konfiguration.md
│
├── Netzwerk-DNS-TLS/
│   ├── 00-Overview.md
│   ├── Control-Plane-Policy-NPM.md
│   ├── Lokales-SSL-home-arpa.md
│   └── Neuer-home-arpa-Service.md
│
├── NetBox/
│   ├── 00-Overview.md
│   └── NetBox-Arbeitsmodell.md
│
├── Services/
│   ├── 00-Overview.md
│   ├── Jellyfin.md
│   └── Paperless-ngx.md
│
├── Betrieb/
│   ├── 00-Overview.md
│   ├── Notfallrestore-Docker-VM.md
│   ├── Restore-Drill-Docker-VM.md
│   └── Service-Onboarding.md
└── README.md
```

---

## Zentrale Leitprinzipien

Diese Prinzipien gelten **repo-weit**:

* **Architektur vor Technik**
  Entscheidungen werden zuerst gedacht, dann gebaut.

* **Control Plane ≠ Service Plane**
  Kritische Systeme werden nicht „optimiert“.

* **DNS benennt Dienste, nicht Plattformen**

* **TLS endet am Reverse Proxy**

* **NetBox beschreibt Struktur, nicht Betrieb**

* **Was nicht dokumentiert ist, existiert nicht**

---

## Was dieses Repository bewusst nicht ist

* kein Ersatz für Konfigurationsdateien
* kein Ticket‑ oder Logbuch
* kein Sammelbecken für Experimente
* kein Ort für spontane Workarounds

Temporäre oder experimentelle Änderungen gehören **nicht** hierher.

---

## Änderungen & Pflege

* Dokumente werden geändert, wenn sich **Prinzipien oder belastbare Erkenntnisse** ändern
* reine Implementierungsdetails ändern keine Dokumentation
* nach Drills oder realen Vorfällen wird gezielt nachgeschärft

Die Dokumentation ist **lebendig**, aber nicht volatil.

---

## Zielgruppe

Dieses Repository richtet sich an:

* den aktuellen Betreiber
* den Betreiber in sechs Monaten
* den Betreiber unter Zeitdruck

Nicht an:

* Suchmaschinen
* Einsteiger-Tutorials
* „Quick Fix“-Mentalität

---

## Merksatz

> Gute Dokumentation ersetzt Gedächtnis – besonders dann, wenn es versagt.

---

## Status

* konsolidiert
* verbindlich
* git‑tauglich
* Logseq‑kompatibel
