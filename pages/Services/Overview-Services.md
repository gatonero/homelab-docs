# Services – Overview

Diese Übersicht beschreibt den Umgang mit **Services** im Homelab und dient als Einstiegspunkt für service‑spezifische Dokumentation.

Services sind **konkrete Anwendungen**, die innerhalb der vorgegebenen Architektur betrieben werden.

---

## Zweck

Der Bereich **Services** beantwortet:

* Welche Services existieren aktuell?
* Wie sind sie grundsätzlich angebunden (DNS, Proxy, Backend)?
* Wo sind Besonderheiten und Abweichungen dokumentiert?

Diese Übersicht ersetzt **keine** Detaildokumentation einzelner Services.

---

## Rolle von Services im Gesamtsystem

Services:

* laufen **innerhalb** der Service Plane
* folgen den architektonischen Vorgaben
* sind austauschbar
* hängen von Infrastruktur‑Services ab (DNS, Reverse Proxy)

Services definieren **keine Architekturregeln**, sondern **nutzen** sie.

---

## Enthaltene Dokumente

### Aktive Services

* **Jellyfin**
  Medienserver mit externer Datenquelle (QNAP) und Docker‑Deployment.

  → `pages/Services/Jellyfin.md`

* **Paperless‑ngx**
  Dokumentenmanagementsystem hinter Reverse Proxy.

  → `pages/Services/Paperless-ngx.md`

---

## Dokumentationsprinzipien (verbindlich)

Für jeden Service gilt:

* **Was** wird betrieben?
* **Wo** läuft der Service?
* **Wie** ist er angebunden?
* **Welche Abweichungen** gibt es vom Standard?

Nicht dokumentiert werden:

* triviale Konfigurationsoptionen
* experimentelle Tests
* kurzlebige Debug‑Schritte

---

## Abgrenzung zu anderen Bereichen

* **Architektur**: legt Regeln fest
* **NetBox**: modelliert Services strukturell
* **Services**: dokumentieren konkrete Implementierungen
* **Betrieb**: beschreibt Wiederherstellung und Alltag

---

## Status

* Rolle: Service‑Einstiegspunkt
* Änderungsfrequenz: mittel
* Verbindlichkeit: hoch

---

> **Services dürfen variieren – die Architektur nicht.**
