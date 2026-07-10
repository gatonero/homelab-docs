# LaraPaper BYOS – Architektur und Datenfluss

Stand: Juli 2026

## Ziel

Dieses Dokument beschreibt die Architektur von LaraPaper BYOS auf Grundlage
praktischer Tests und Quellcodeanalyse.

Es dient als Referenz für die Entwicklung eigener Plugins.

---

## Objektmodell

LaraPaper besteht aus vier zentralen Objekten.

    Device
        │
        ▼
    Playlist
        │
        ▼
    Plugin
        │
        ▼
    View (Blade oder Liquid)

### Device

Ein Device repräsentiert ausschließlich die Hardware.

Beispiele:

- TRMNL X
- TRMNL OG
- XIAO 7.5" ePaper Panel

Ein Device besitzt genau eine Playlist.

### Playlist

Eine Playlist enthält eine geordnete Liste von Plugins.

Sie bestimmt die Reihenfolge der Anzeige auf dem Device.

### Plugin

Ein Plugin beschreibt

- die Datenquelle
- die Konfiguration
- die Darstellung

Recipes sind intern keine eigene Objektklasse.

Sie sind Plugins mit

    plugin_type = recipe


---

## Renderpipeline

Die Renderpipeline erzeugt aus einem Plugin die letztlich auf dem Display
angezeigte PNG-Datei.

    Plugin
        │
        ▼
    render()
        │
        ▼
    Blade View
        │
        ▼
    ImageGenerationService
        │
        ▼
    PNG
        │
        ▼
    Device

### Erkenntnisse

GenerateScreenJob übernimmt ausschließlich die Bildgenerierung.

Aufgaben:

- Blade rendern
- PNG erzeugen
- current_image aktualisieren
- Bild dem Device zuweisen

GenerateScreenJob beschafft keine Daten.

Die eigentliche Datenbeschaffung erfolgt bereits vor dem Rendern.


---

## Datenpipeline

Die Datenpipeline ist vollständig von der Renderpipeline getrennt.

    HTTP / Webhook
            │
            ▼
      Response Parser
            │
            ▼
      data_payload
            │
            ▼
        Blade View

### Verifiziert

Im Plugin-Modell werden HTTP-Antworten über

    Http::pool()

abgerufen.

Die Antworten werden anschließend durch einen passenden Parser verarbeitet.

Unterstützte Parser:

- JSON / Text
- XML
- iCal

Die Ergebnisse werden als

    data_payload

im Plugin gespeichert.

Beim Rendern wird data_payload als

    $data

an die Blade-View übergeben.

### Interpretation

Die Blade-Views kennen die Herkunft der Daten nicht.

Sie arbeiten ausschließlich mit den bereitgestellten Variablen.

Dadurch können dieselben Views unabhängig von der Datenquelle verwendet werden.

