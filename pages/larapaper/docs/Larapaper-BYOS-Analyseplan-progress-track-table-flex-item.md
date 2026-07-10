# Larapaper BYOS -- Analyseplan weiterer TRMNL-Komponenten

## Ziel

Nach Abschluss der Analyse der Kernkomponenten (`grid`, `value`,
`label`, `title-bar`) werden die folgenden Komponenten untersucht. Ziel
ist es, ihren praktischen Nutzen für Homelab-Dashboards zu bewerten und
geeignete Einsatzszenarien zu dokumentieren.

------------------------------------------------------------------------

# progress

## Zweck

Darstellung eines Fortschritts oder Füllstands.

## Zu klärende Fragen

-   Welche Parameter werden unterstützt?
-   Wie wird der Prozentwert übergeben?
-   Können Beschriftungen ergänzt werden?
-   Welche Darstellung eignet sich für Speicher, Batterie oder Backups?
-   Welche CSS-Klassen werden erzeugt?

## Mögliche Einsatzgebiete

-   Speicherbelegung
-   Backup-Fortschritt
-   Akkustand
-   CPU- oder RAM-Auslastung

------------------------------------------------------------------------

# track

## Zweck

Darstellung eines Balkens oder einer Skala mit Positionsanzeige.

## Zu klärende Fragen

-   Welche Eigenschaften besitzt die Komponente?
-   Wie unterscheidet sie sich von `progress`?
-   Können Schwellenwerte dargestellt werden?
-   Welche Daten eignen sich für eine Track-Darstellung?

## Mögliche Einsatzgebiete

-   Temperaturbereiche
-   Luftfeuchtigkeit
-   Energieverbrauch
-   Sensorwerte mit Minimal-/Maximalbereich

------------------------------------------------------------------------

# table

## Zweck

Tabellarische Darstellung strukturierter Daten.

## Zu klärende Fragen

-   Wie werden Zeilen und Spalten definiert?
-   Welche Formatierungsmöglichkeiten bestehen?
-   Wie viele Zeilen sind auf dem Display sinnvoll?
-   Wie verhält sich die Tabelle bei langen Texten?

## Mögliche Einsatzgebiete

-   Uptime-Kuma-Status
-   Backup-Liste
-   Letzte Systemereignisse
-   Kalenderübersicht

------------------------------------------------------------------------

# flex

## Zweck

Flexibles Layout auf Basis von CSS Flexbox.

## Zu klärende Fragen

-   Welche Flex-Richtungen werden unterstützt?
-   Können Elemente automatisch verteilt werden?
-   Wann ist `flex` geeigneter als `columns`?
-   Lässt sich `flex` mit `grid` kombinieren?

## Mögliche Einsatzgebiete

-   Symbol + Text
-   Statusleisten
-   Horizontal oder vertikal angeordnete Kennzahlen
-   Responsive Layoutbereiche

------------------------------------------------------------------------

# item

## Zweck

Ein einzelnes Dashboard-Element innerhalb größerer Layouts.

## Zu klärende Fragen

-   Welche Standardformatierung besitzt `item`?
-   Wie arbeitet `item` mit `grid` zusammen?
-   Welche Komponenten werden typischerweise innerhalb eines `item`
    verwendet?
-   Ist `item` lediglich ein Container oder bringt es eigenes Styling
    mit?

## Mögliche Einsatzgebiete

-   Dashboard-Kachel
-   Statusblock
-   Kennzahl mit Label und Symbol
-   Wiederverwendbare UI-Bausteine

------------------------------------------------------------------------

# Priorität

  Komponente   Priorität   Begründung
  ------------ ----------- -------------------------------------------------------
  progress     Hoch        Für Auslastungs- und Prozentanzeigen
  track        Mittel      Für Skalen und kontinuierliche Messwerte
  table        Mittel      Für Listen und strukturierte Informationen
  flex         Hoch        Für flexible Layouts innerhalb von Grid-Zellen
  item         Hoch        Grundbaustein für wiederverwendbare Dashboard-Kacheln

------------------------------------------------------------------------

# Erwartetes Ergebnis

Für jede Komponente sollen dokumentiert werden:

-   Blade-Syntax
-   unterstützte Parameter
-   erzeugte CSS-Klassen
-   typische Einsatzszenarien
-   Kombinationen mit anderen TRMNL-Komponenten
-   konkrete Beispiele für das Homelab-Dashboard

Diese Analyse ergänzt die Untersuchung der Kernkomponenten und bildet
die Grundlage für den Aufbau komplexerer, aber konsistenter
Larapaper-Plugins.
