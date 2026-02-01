---
title: "HTTPS – falscher Dienst wird angezeigt"
---

# HTTPS – falscher Dienst wird angezeigt

## Symptom

Der Aufruf eines Services über HTTPS zeigt die Weboberfläche eines **anderen Dienstes**.

Beispiel:
- Erwartet: Uptime Kuma
- Tatsächlich angezeigt: AdGuard Web UI

Der direkte Aufruf des Services über IP und Port funktioniert korrekt.

---

## Kontext

- Zugriff über NGINX als Reverse Proxy
- Namensbasierte Virtual Hosts
- TLS-Terminierung auf dem Reverse Proxy
- Betroffen ist **nur ein einzelner FQDN**, andere Services funktionieren korrekt

---

## Schnellcheck (read-only)

1. Direkter Aufruf des Services per IP und Port prüfen  
   → Funktioniert der Dienst grundsätzlich?

2. DNS-Auflösung des FQDN prüfen  
   → Zeigt der Name auf den Reverse Proxy?

3. Auf dem Reverse Proxy prüfen:
   - Existiert ein Virtual Host für den `server_name`?
   - Existiert ein **eigener HTTPS-Serverblock (Port 443)**?

4. Vergleich:
   - Haben funktionierende Services explizite HTTPS-vHosts?

---

## Wahrscheinliche Ursachen

1. Es existiert **kein HTTPS-Serverblock** (`listen 443 ssl`) für den betroffenen FQDN
2. NGINX fällt bei HTTPS-Anfragen auf einen **anderen aktiven SSL-vHost** zurück
3. Der Fallback-vHost gehört zu einem anderen Dienst (z. B. AdGuard)
4. Ein HTTP-Redirect (80 → 443) ist vorhanden, aber **kein TLS-Endpoint**

---

## Fix (konzeptionell)

- Für den betroffenen FQDN einen **expliziten HTTPS-Virtual-Host** anlegen
- Saubere Trennung:
  - Port 80: ausschließlich Redirect auf HTTPS
  - Port 443: TLS-Terminierung und Proxy auf den Zielservice
- Sicherstellen, dass:
  - `server_name` exakt übereinstimmt
  - die SSL-Konfiguration eingebunden ist

---

## Verifikation

1. Browser-Aufruf des HTTPS-FQDN  
   → Richtige Weboberfläche wird angezeigt

2. Negativtest:
   - Andere FQDNs zeigen weiterhin ihre jeweiligen Services

3. Optional:
   - Vergleich mit einem funktionierenden HTTPS-vHost

---

## Verweise

* [`Reverse Proxy (Betrieb)`](/pages/Betrieb/Reverse-Proxy.md)
* [`Ingress und TLS (Architektur)`](/pages/Architektur/Ingress-und-TLS.md)
* [`Cookbook-Betrieb`](/pages/Betrieb/Cookbook-Betrieb.md)
