---
title: "Cookbook-Betrieb"
---

# Cookbook-Betrieb

## Zweck

Das Cookbook dient der **operativen Unterstützung im Betrieb**.

Es beschreibt **konkrete Handlungsmuster für reale Störungs- und Abweichungssituationen** und beantwortet die Frage:

> Was ist konkret zu tun, wenn ein System sich nicht wie erwartet verhält?

Das Cookbook ergänzt die bestehende Dokumentation dort, wo **schnelles, sicheres Handeln** erforderlich ist.

---

## Abgrenzung

### Das Cookbook ist nicht
- eine Architektur- oder Designbeschreibung
- eine vollständige Referenzdokumentation
- eine Sammlung aller Konfigurationsdetails
- ein Ersatz für Ansible-Playbooks oder Code

### Das Cookbook ist
- **symptomorientiert**
- **situativ**
- **handlungsfokussiert**
- bewusst **redundant**
- abgeleitet aus **realen Incidents**

---

## Einordnung innerhalb der Betriebsdokumentation

Cookbook-Einträge sind Teil der Betriebsdokumentation.

Sie beschreiben **Abweichungen vom Normalbetrieb** und die daraus resultierenden **konkreten Reaktionen**.

Der Fokus liegt nicht auf dem *Warum eines Systems*, sondern auf dem *Wie des Vorgehens im Fehlerfall*.

---

## Thematische Gruppierung

Cookbook-Einträge sind **thematisch gruppiert**.

Diese Gruppierung dient ausschließlich der **inhaltlichen Orientierung** und beschreibt **Themenfelder**, keine technische Ablage- oder Verzeichnisstruktur.

Typische Themenfelder sind:
- Fehlverhalten von Reverse-Proxies
- Probleme bei DNS- oder Namensauflösung
- TLS- und Erreichbarkeitsprobleme
- Störungen im Container- oder Laufzeitbetrieb
- Auffälligkeiten bei Monitoring und Alarmierung
- Probleme mit Plattform- oder Basisdiensten

Die konkrete Ablage folgt diesen Themen, ist jedoch **nicht Bestandteil der inhaltlichen Beschreibung**.

---

## Qualitätsregeln (verbindlich)

1. **Ein Eintrag = ein realer Incident**  
   Keine hypothetischen oder antizipativen Szenarien.

2. **Symptom vor Ursache**  
   Der Einstieg erfolgt immer über beobachtbares Verhalten.

3. **Read-only-Diagnose zuerst**  
   Prüfungen ohne Eingriffe stehen vor jeder Maßnahme.

4. **Fix klar getrennt**  
   Diagnose und Behebung sind eindeutig getrennt beschrieben.

5. **Minimalismus**  
   Keine vollständigen Konfigurationsdateien, nur relevante Ausschnitte oder Muster.

6. **Verweise statt Wiederholung**  
   Detailwissen bleibt in der Referenzdokumentation.

---

## Entstehungsprozess

Ein Cookbook-Eintrag entsteht ausschließlich:
1. aus einem realen Incident,
2. nach erfolgreicher Behebung,
3. mit eindeutig identifizierter Ursache.

Das Cookbook wird **reaktiv aus Betriebserfahrung gepflegt**, nicht vorsorglich.

---

## Nutzungshinweis

Im Betrieb gilt folgende Reihenfolge:
1. Cookbook
2. Referenz-Dokumentation
3. Code (Ansible / Compose)

Das Cookbook ist der **erste Einstiegspunkt für operative Entscheidungen**.
