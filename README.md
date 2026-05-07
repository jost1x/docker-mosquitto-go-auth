# Mosquitto Go-Auth Plugin

Docker image for [Mosquitto MQTT broker](https://mosquitto.org/) with the [mosquitto-go-auth](https://github.com/iegomez/mosquitto-go-auth) plugin, using HTTP as the authentication backend and Redis/Valkey for caching.

## Quick Start

1. Copy the example environment file and adjust it:

```bash
cp .env.example .env
```

2. Edit `.env` with your HTTP auth backend host, Valkey password, and other settings.

3. Start the services:

```bash
docker compose up -d
```

## Configuration

### Environment Variables

| Variable | Description | Default |
|---|---|---|
| `VALKEY_PASSWORD` | Password for the Valkey/Redis cache | _(required)_ |
| `AUTH_HTTP_HOST` | HTTP backend host for auth | `auth-api` |
| `AUTH_HTTP_PORT` | HTTP backend port | `8000` |
| `AUTH_HTTP_GET_USER_URI` | Auth endpoint URI | `/mqtt/auth` |
| `AUTH_HTTP_SUPER_USER_URI` | Superuser endpoint URI | `/mqtt/auth/superuser` |
| `AUTH_HTTP_ACL_URI` | ACL check endpoint URI | `/mqtt/auth/acl` |
| `AUTH_OPT_CACHE` | Enable caching | `true` |
| `AUTH_OPT_CACHE_TYPE` | Cache backend type | `redis` |
| `AUTH_OPT_CACHE_HOST` | Cache host | `valkey` |
| `AUTH_OPT_CACHE_PORT` | Cache port | `6379` |
| `AUTH_OPT_CACHE_DB` | Cache database number | `3` |
| `AUTH_OPT_AUTH_CACHE_SECONDS` | Auth cache TTL | `30` |
| `AUTH_OPT_ACL_CACHE_SECONDS` | ACL cache TTL | `30` |
| `AUTH_OPT_AUTH_JITTER_SECONDS` | Auth cache jitter | `3` |
| `AUTH_OPT_ACL_JITTER_SECONDS` | ACL cache jitter | `3` |

### Mosquitto Config

Main configuration is in `config/mosquitto.conf`. Auth settings are generated from `config/conf.d/auth.conf.template` at container startup.

## Building

### Debian-based (default)

```bash
docker build -t mosquitto-go-auth .
```

### Alpine-based

```bash
docker build -f Dockerfile.alpine -t mosquitto-go-auth:alpine .
```

### With custom versions

```bash
docker build \
  --build-arg MOSQUITTO_VERSION=2.1.2 \
  --build-arg GOAUTH_VERSION=3.0.0 \
  --build-arg GOAUTH_ARCH=linux-amd64 \
  -t mosquitto-go-auth .
```

## Ports

| Port | Protocol |
|---|---|
| 1883 | MQTT |
| 1884 | MQTT over WebSockets |

## Project Structure

```
├── config/
│   ├── mosquitto.conf          # Main Mosquitto config
│   └── conf.d/
│       ├── auth.conf.template  # Auth config template (envsubst)
│       ├── log.conf            # Logging config
│       └── persistence.conf    # Persistence config
├── .env.example                # Environment template (safe to commit)
├── .env                        # Actual secrets (git-ignored)
├── docker-compose.yml
├── Dockerfile                  # Debian-based image
├── Dockerfile.alpine           # Alpine-based image
└── entrypoint.sh
```

## License

See the licenses of [Mosquitto](https://github.com/eclipse/mosquitto) and [mosquitto-go-auth](https://github.com/iegomez/mosquitto-go-auth).
