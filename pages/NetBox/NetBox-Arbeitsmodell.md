# NetBox – Pflege- und Arbeitsmodell

## Zweck

Dieses Dokument beschreibt das **verbindliche Pflege‑ und Arbeitsmodell für NetBox** im Homelab.

Es legt fest:

* wann NetBox führend ist
* wann bewusst **nicht**
* wie Modell, Realität und Dokumentation zusammenspielen

Ziel ist ein **dauerhaft wartbares, ruhiges und belastbares NetBox**, das Orientierung gibt, ohne Pflegeaufwand zu erzeugen.

---

## 1. Grundprinzip

> **NetBox ist die Source of Truth für Struktur und Architektur – nicht für jede technische Schraube.**

NetBox beschreibt den **Soll‑Zustand** der Infrastruktur:

* welche Systeme existieren
* welche Rollen sie haben
* wie Services logisch aufgebaut sind
* welche Abhängigkeiten relevant sind

NetBox ist:

* **kein** Orchestrator
* **kein** Logbuch
* **kein** Ersatz für Proxmox, Docker oder Konfigurationsdateien

---

## 2. Zentrale Faustregel

**Struktur zuerst in NetBox modellieren.**
**Umsetzung zuerst in der Realität durchführen.**
**Danach NetBox vervollständigen.**

Diese Reihenfolge sorgt für:

* bewusste Entscheidungen
* konsistente Namen und Rollen
* eine ruhige, übersichtliche NetBox‑Datenbasis

---

## 3. Arten von Änderungen

### 3.1 Strukturelle Änderungen – NetBox zuerst

Betrifft alle Änderungen, die die **Architektur** beeinflussen.

**Beispiele:**

* neue VM oder neues Device
* neuer Service
* neue Rolle (z. B. `infrastructure`, `backend`)
* neuer Entry‑Point oder neue Domain
* neue Abhängigkeiten

**Vorgehen:**

1. Modellierung in NetBox (Objekt, Name, Rolle)
2. Architektur gedanklich prüfen
3. Umsetzung in der Realität
4. NetBox vervollständigen (Ports, Kommentare)

**Begründung:**
NetBox dient hier als **Planungs‑ und Denkwerkzeug** und verhindert spontane, inkonsistente Entscheidungen.

---

### 3.2 Technische Detailänderungen – Realität zuerst

Betrifft Änderungen ohne Einfluss auf das Modell.

**Beispiele:**

* Anpassungen an Docker‑Compose‑Dateien
* Timeout‑ oder Performance‑Tuning
* Zertifikatserneuerungen
* Monitoring‑Intervalle

**Vorgehen:**

1. Änderung in der Realität durchführen
2. Funktion prüfen
3. NetBox **nur anpassen**, wenn sich Struktur oder Abhängigkeiten geändert haben

**Begründung:**
NetBox soll **keine Konfigurationssammlung** sein. Zu viele Details machen es laut und pflegeintensiv.

---

### 3.3 Fehler & Notfälle – Realität zuerst, NetBox danach

**Beispiele:**

* DNS‑Ausfall
* abgelaufenes Zertifikat
* Container‑ oder VM‑Ausfall
* Restore‑Szenarien

**Vorgehen:**

1. Problem beheben
2. System stabilisieren
3. NetBox nachziehen, wenn:

   * neue Erkenntnisse gewonnen wurden
   * Abhängigkeiten angepasst wurden
   * Architekturregeln geändert wurden

NetBox ist **kein Ticket‑System**, sondern ein **Erkenntnis‑Speicher**.

---

## 4. Empfohlenes Arbeitsmodell

1. **Denken (NetBox)**
   Planung neuer Komponenten, Rollen und Abhängigkeiten

2. **Bauen (Realität)**
   Proxmox, Docker, Reverse Proxy, Tests

3. **Abgleichen (NetBox)**
   Ports, Kommentare, Klarstellungen

4. **Dokumentieren (Architektur)**
   Nur bei geänderten Prinzipien oder Regeln

---

## 5. Was bewusst nicht in NetBox gehört

* einzelne Konfigurationsoptionen
* temporäre Experimente
* Debug‑Schritte
* Log‑ oder Ereignishistorien

NetBox bleibt bewusst **unvollständig**, aber **verlässlich**.

---

## 6. Entscheidende Leitfrage

> **Würde ich bei einem Restore davon profitieren?**

* **Ja** → gehört in NetBox
* **Nein** → gehört in Code, Compose‑Dateien oder Betriebshandbücher

---

## 7. Beispiel: Neuer Service

### Richtig

* NetBox: Service `paperless-web` anlegen
* Rolle vergeben (`backend`)
* Umsetzung mit Docker
* Port und Kommentar ergänzen

### Falsch

* Container starten
* Namen improvisieren
* NetBox später „irgendwie nachziehen“

---

## 8. Zusammenfassung

* NetBox ist **Referenz**, nicht Spiegel der Realität
* Architektur wird **zuerst gedacht**, dann gebaut
* Technik darf sich ändern, ohne NetBox ständig anzufassen
* NetBox bleibt ruhig, klar und belastbar

> **Ein gepflegtes NetBox reduziert Stress – es erzeugt keinen.**

---

# NetBox – Entscheidungshilfe: Service Template oder Custom Service

Diese Entscheidungshilfe legt verbindlich fest, ob ein Dienst in NetBox als **Service Template** oder als **Custom Service** angelegt wird.

---

## Entscheidungsvorprüfung

Vor dem Anlegen eines Services sind folgende Fragen zu beantworten:

1. Kommt dieser Dienst mehrfach vor?
2. Würde ich ihn in sechs Monaten identisch erneut anlegen?
3. Hat er feste Ports und ein stabiles Protokoll (TCP/UDP/SCTP)?
4. Hat er eine klar definierte Rolle im Gesamtsystem?
5. Ist er Teil der Infrastruktur oder ein wiederkehrendes Muster?

---

## Entscheidung

### Service Template verwenden, wenn …

* mindestens **drei** Fragen mit **Ja** beantwortet wurden
* ein architektonisches Muster modelliert wird
* der Dienst bei einem Restore zwingend reproduzierbar sein muss

**Typische Beispiele:**

* DNS‑Resolver
* Reverse Proxy (HTTPS‑Entry)
* Web‑Anwendungen hinter Reverse Proxy
* Monitoring‑Endpunkte

---

### Custom Service verwenden, wenn …

* der Dienst einmalig oder experimentell ist
* Ports oder Verhalten sich häufig ändern
* der Dienst zeitlich begrenzt genutzt wird
* kein wiederholbares Muster existiert

---

## Architekturelle Leitlinien

* Templates modellieren **technische Muster**, nicht Produkte
* Protocol‑Felder beschreiben **Layer 4** (TCP/UDP/SCTP)
* HTTP/HTTPS gehören in **Description oder Comments**
* DNS und Reverse Proxy sind **Infrastruktur‑Abhängigkeiten**

---

## Kontrollfragen vor dem Speichern

* Ist eindeutig erkennbar, ob es Infrastruktur oder Applikation ist?
* Ist der Port realistisch und korrekt?
* Ist klar, ob Benutzer direkten Zugriff haben dürfen?
* Sind Abhängigkeiten (DNS, Proxy, Backend) dokumentiert?

Wenn eine dieser Fragen offen bleibt, ist das Modell **unvollständig**.

---

## Status

* verbindlich
* betriebserprobt
* konsistent zur Gesamtarchitektur
