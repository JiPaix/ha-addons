#!/usr/bin/env sh
set -eu
mkdir -p /data/Tachidesk /data/TachideskTmp
chown suwayomi:suwayomi /data/Tachidesk /data/TachideskTmp
exec gosu suwayomi /run.sh
