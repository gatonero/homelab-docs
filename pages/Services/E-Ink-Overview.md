---
title: "E-Ink Overview"
---

# E-Ink Overview

This section documents the E-Ink infrastructure used within the Homelab.

The objective is to provide a unified platform for low-power information displays that integrate with Home Assistant while remaining fully self-hosted over time.

---

## Scope

The E-Ink platform currently includes:

- TRMNL X
- Seeed Studio XIAO ESP32-C3 with 7.5" ePaper display
- Home Assistant dashboards
- Puppet screenshot service

Future work will extend this platform with:

- TRMNL Cloud integration
- TRMNL BYOS
- Multiple synchronized E-Ink displays

---

## Current Status

### Production

- Home Assistant dashboard
- TRMNL X
- Puppet Add-on

### Evaluation completed

- ESPHome rendering
- Docker image proxy
- Pillow image processing

The evaluation demonstrated that image post-processing cannot reliably compensate for rendering differences introduced by the screenshot pipeline.

---

## Current Architecture

The current production system consists of Home Assistant as the data source, Puppet as the rendering service and the TRMNL X as the presentation device.

---

## Target Architecture

The long-term target architecture consists of Home Assistant as the data source, TRMNL Cloud (later TRMNL BYOS) as the central rendering and management platform, and multiple E-Ink devices including the TRMNL X and the Seeed Studio XIAO 7.5.

---

## Guiding Principles

The E-Ink platform follows the same principles as the remainder of the Homelab:

- Simplicity over complexity
- Single rendering pipeline
- Self-hosting whenever practical
- Reproducible deployment
- Minimal device-specific customization

---

## Related Documents

- [E-Ink Hardware](./E-Ink-Hardware.md)
- [E-Ink Roadmap](./E-Ink-Roadmap.md)

