#!/usr/bin/env sh
set -eu

# Persistent dirs (host-mounted via HA add-on: data:rw)
mkdir -p /data/Tachidesk /data/TachideskTmp

# Ensure ownership for runtime user (needed if /data is root-owned)
chown -R suwayomi:suwayomi /data/Tachidesk /data/TachideskTmp

# Replace expected paths with symlinks (must replace directories, not create nested links)
mkdir -p /home/suwayomi/.local/share

rm -rf /home/suwayomi/.local/share/Tachidesk
ln -s /data/Tachidesk /home/suwayomi/.local/share/Tachidesk

rm -rf /tmp/Tachidesk
ln -s /data/TachideskTmp /tmp/Tachidesk

# Drop privileges and run the actual startup script
exec gosu suwayomi /run.sh
