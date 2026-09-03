# Tool Registry

Stand: AP0.12 – Phase 2A (Tool Registry inventarisiert)

## Statistik

| Kennzahl | Wert |
|----------|------|
| Gesamtzahl Tools | 10 |
| Connector docker | 5 |
| Connector homeassistant | 5 |

## Vollständige Tool-Tabelle

| Tool ID | Connector | Kategorie | Permission | Timeout | Beschreibung |
|---------|-----------|-----------|------------|---------|--------------|
| docker.container.count | docker | facts | READ | 10 | Return the number of running Docker containers. |
| docker.container.list | docker | facts | READ | 10 | Return Docker container metadata. |
| docker.image.list | docker | facts | READ | 10 | Return Docker image metadata. |
| docker.network.list | docker | facts | READ | 10 | Return Docker network metadata. |
| docker.volume.list | docker | facts | READ | 10 | Return Docker volume metadata. |
| ha.area.list | homeassistant | facts | READ | 10 | Return Home Assistant area registry. |
| ha.device.list | homeassistant | facts | READ | 10 | Return Home Assistant device registry. |
| ha.entity.attributes | homeassistant | facts | READ | 10 | Return attributes of one Home Assistant entity. |
| ha.entity.list | homeassistant | facts | READ | 10 | Return Home Assistant entities optionally filtered by domain. |
| ha.entity.state | homeassistant | facts | READ | 10 | Return state metadata for one Home Assistant entity. |

## Gruppierung nach Connector

### docker

| Tool ID | Kategorie | Permission | Timeout |
|---------|-----------|------------|---------|
| docker.container.count | facts | READ | 10 |
| docker.container.list | facts | READ | 10 |
| docker.image.list | facts | READ | 10 |
| docker.network.list | facts | READ | 10 |
| docker.volume.list | facts | READ | 10 |

### homeassistant

| Tool ID | Kategorie | Permission | Timeout |
|---------|-----------|------------|---------|
| ha.area.list | facts | READ | 10 |
| ha.device.list | facts | READ | 10 |
| ha.entity.attributes | facts | READ | 10 |
| ha.entity.list | facts | READ | 10 |
| ha.entity.state | facts | READ | 10 |
