---
title: "Governance - Persistente KI-Regeln"
---

# Persistente KI-Regeln

Dieses Dokument definiert explizite, dauerhaft gültige Regeln, die von der KI
bei jeder Zusammenarbeit anzuwenden sind. Es macht für die KI verbindlich,
was für den Menschen teilweise implizit ist.

---

## Geltungsbereich
Diese Regeln sind bei jeder Zusammenarbeit mit KI anzuwenden, sofern KI aktiv
beteiligt ist. Die Anwendung ist zielabhängig; insbesondere ist vor Beginn
zu klären, ob das Arbeitsergebnis in GitHub endet.

---

## Arbeitsmodus und Zustandslogik
Die KI arbeitet ausschließlich auf explizite Anweisung und trifft keine
impliziten Annahmen. Zustände sind eindeutig zu behandeln: **OK**, **FAILED**
und **STOP**. Bei **STOP** wird keine weitere Aktion ausgeführt, bis eine neue
Anweisung vorliegt.

---

## Ebenenmodell
Arbeiten sind strikt in **Thema → Phase → Block** zu strukturieren.  
Ein Block kann, sofern fachlich sinnvoll, weiter in **Schritte** unterteilt
werden.

Ein Wechsel der Ebene ist erst nach vollständigem Abschluss der aktuellen
Ebene zulässig. Abweichungen sind explizit zu benennen und zu begründen.

---

## Artefakte und Persistenz
Ergebnisse sind zunächst temporär zu erstellen und erst nach expliziter
Freigabe in einen persistenten, kanonischen Ablageort zu übernehmen.

In diesem Repository erfolgt die Übernahme nach `pages/`.  
Nach erfolgreicher Übernahme sind temporäre Artefakte zu bereinigen.

---

## Kommunikationsregeln
Start und Ende jeder Ebene sind explizit zu kennzeichnen. Erwartungen an
Ausgaben sind vorab zu benennen. Parallelvorschläge oder implizite Alternativen
sind unzulässig.

---

## CLI- und Ausführungsregeln
CLI-Anweisungen und Ausgaben beziehen sich auf den vom Menschen interaktiv
bedienten Host. Ausführungsorte (Host) und explizite Pfade sind stets
anzugeben.

Eine Ausgabe gilt als vollständig, wenn Prompt und erwarteter Inhalt
enthalten sind. Bei Fehlern ist ausschließlich der Fehler zu posten;
andernfalls ist der Status zu melden.

---

## GitHub-Abschlussregel (bei GitHub-Ziel)
Diese Regel gilt ausschließlich, wenn das Arbeitsergebnis in GitHub endet.
Ein Thema gilt erst nach erfolgreichem Commit und Push als abgeschlossen.
Vor erfolgreichem Push sind keine Themenwechsel zulässig.

---

## Konflikt- und Fehlerbehandlung
Unklarheiten führen zu **STOP** und einer gezielten Rückfrage. Widersprüche
sind offenzulegen und aufzulösen, bevor fortgefahren wird. Fehler werden
gezielt korrigiert; ein Weiterlaufen ohne Klärung ist unzulässig.
