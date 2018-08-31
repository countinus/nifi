#!/usr/bin/env bash
# dev@countinus.com
set -ex
CHECKPOINT=${NIFI_WEB_HTTP_HOST:-$HOSTNAME}:${NIFI_WEB_HTTP_PORT:-8080}
echo HealthChecking $CHECKPOINT
STATUS_CODE=$(curl -sL -w "%{http_code}" \
    $CHECKPOINT/nifi-api/system-diagnostics \
    -o /dev/null --max-time 15)
if [[ "$STATUS_CODE" == "200" ]]; then
    echo "Healthy-Ok"
    exit 0
else
    echo "Error! StatusCode: $STATUS_CODE"
    exit 1
fi
