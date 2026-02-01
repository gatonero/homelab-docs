---
title: "Ingress"
---

# Zentraler Eintrittspunkt für externe und interne HTTP(S)-Zugriffe

← Zurück zur [`Overview Architektur`](/pages/Architektur/Overview-Architektur.md)

Der externe Zugriff auf die im Homelab betriebenen Web-Services erfolgt ausschließlich über einen **dedizierten Ingress**.  
Dieser stellt einen bewusst begrenzten, kontrollierten und nachvollziehbaren Eintrittspunkt dar.

Der hier beschriebene Zustand repräsentiert einen **verifizierten Referenzstand** nach vollständiger Härtung und praktischen Zugriffstests.

---

## Architektur

### Rolle des Ingress

Der Ingress übernimmt die zentrale Rolle als:

- einziger Eintrittspunkt für HTTP(S)-Traffic
- Trennschicht zwischen externen Zugriffen und internen Services
- Ort der TLS-Terminierung und Zugriffskontrolle

Der Ingress enthält **keine Applikationslogik** und **keinen persistenten Storage**.

Die technische Umsetzung des Reverse Proxys als Bestandteil des Ingress ist im Detail beschrieben unter:  
[`Netzwerk – Reverse Proxy und Zugriffspfade`](/pages/Netzwerk-DNS-TLS/Reverse-Proxy-und-Zugriffspfade.md)

---

### Netzwerkprinzipien

Der Ingress folgt klaren netzwerkseitigen Leitlinien:

- Extern erreichbar sind ausschließlich die für HTTP(S) erforderlichen Ports
- Administrativer Zugriff ist **nicht öffentlich exponiert**
- Management-Zugriffe erfolgen ausschließlich über kontrollierte interne Zugriffspfade
- Nicht genutzte Protokolle und Adressfamilien sind konsequent ausgeschlossen

Diese Prinzipien reduzieren die Angriffsfläche und vereinfachen Analyse und Betrieb.

---

## Sicherheitsprinzipien

### Firewall-Grundsätze

Der Ingress ist nach dem **fail-closed-Prinzip** abgesichert:

- eingehender Traffic ist standardmäßig blockiert
- explizit erlaubte Verbindungen sind auf das notwendige Minimum beschränkt
- etablierte Verbindungen werden korrekt weitergeführt

Firewall-Regeln sind vollständig reproduzierbar und Teil der automatisierten Systemkonfiguration.

---

### TLS und HTTP-Sicherheit

#### TLS

- zeitgemäße, distributionskonforme TLS-Konfiguration
- bewusste Vermeidung applikationsspezifischer Sonderkonfigurationen
- zentrale Pflege der TLS-Parameter

#### HTTP-Sicherheitsheader

Sicherheitsheader werden konsistent eingesetzt, ohne Konflikte zwischen Ingress und Applikationen zu erzwingen.

Bewusst umgesetzt sind u. a.:

- Schutz vor MIME-Type-Sniffing
- kontrolliertes Referrer-Verhalten
- Rahmensetzung durch die jeweilige Applikation

Eine Erzwingung zusätzlicher Header auf Ingress-Ebene erfolgt nur dort, wo keine Konflikte entstehen.

---

## Verifizierte Zugriffstests

Der Referenzstand wurde durch gezielte Prüfungen validiert, darunter:

- korrekte HTTPS-Erreichbarkeit
- deterministische Weiterleitung von HTTP auf HTTPS
- kontrollierter Umgang mit nicht vorgesehenen Pfaden
- Blockade unsicherer HTTP-Methoden
- kein unbeabsichtigtes Leaken interner Informationen

Diese Tests bestätigen die Wirksamkeit der getroffenen Architektur- und Sicherheitsentscheidungen.

---

## Bewusste Akzeptanzen

Bestimmte Aspekte werden bewusst akzeptiert, um Stabilität und Wartbarkeit zu gewährleisten, darunter:

- keine erzwungene globale HSTS-Policy auf Ingress-Ebene
- applikationsseitige Verantwortung für bestimmte Header
- kontrollierte Sichtbarkeit technischer Informationen bei abgewiesenen Anfragen

Diese Entscheidungen sind dokumentiert, bewertet und können bei geänderten Anforderungen neu überprüft werden.

---

## Referenzstatus

Der beschriebene Zustand ist:

- technisch verifiziert
- sicherheitsseitig bewertet
- methodisch sauber dokumentiert
- als stabiler Referenzstand eingefroren

Änderungen erfolgen ausschließlich nach erneuter Bewertung und dokumentierter Entscheidung.
