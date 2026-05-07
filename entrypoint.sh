#!/bin/sh
set -e

echo "[entrypoint] Generando auth.conf usando AUTH_HTTP_HOST=${AUTH_HTTP_HOST}"
envsubst < /etc/mosquitto/conf.d/auth.conf.template > /etc/mosquitto/conf.d/auth.conf

exec mosquitto -c /etc/mosquitto/mosquitto.conf
