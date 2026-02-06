#!/usr/bin/env sh
set -eu

CONFIG_PATH="/data/options.json"

# Read nested option via dot-path (max depth 2 here)
opt() {
  # usage: opt "general.t_oct" is invalid; use "general.tz"
  jq -r --arg p "$1" '
    def getpathstr($p):
      ($p | split(".")) as $a
      | getpath($a);
    (getpathstr($p) // "")
    | if . == null then "" else tostring end
  ' "$CONFIG_PATH" 2>/dev/null || echo ""
}

# General
export TZ="$(opt general.tz)"
export BIND_IP="$(opt general.bind_ip)"
export BIND_PORT="$(opt general.bind_port)"

# SOCKS proxy
export SOCKS_PROXY_ENABLED="$(opt socks_proxy.enabled)"
export SOCKS_PROXY_VERSION="$(opt socks_proxy.version)"
export SOCKS_PROXY_HOST="$(opt socks_proxy.host)"
export SOCKS_PROXY_PORT="$(opt socks_proxy.port)"
export SOCKS_PROXY_USERNAME="$(opt socks_proxy.username)"
export SOCKS_PROXY_PASSWORD="$(opt socks_proxy.password)"

# Download / CBZ
export DOWNLOAD_AS_CBZ="$(opt downloads.download_as_cbz)"

# Auth
export AUTH_MODE="$(opt auth.mode)"
export AUTH_USERNAME="$(opt auth.username)"
export AUTH_PASSWORD="$(opt auth.password)"
export JWT_AUDIENCE="$(opt auth.jwt_audience)"
export JWT_TOKEN_EXPIRY="$(opt auth.jwt_token_expiry)"
export JWT_REFRESH_EXPIRY="$(opt auth.jwt_refresh_expiry)"

# Logging
export DEBUG="$(opt logging.debug)"
export MAX_LOG_FILES="$(opt logging.max_log_files)"
export MAX_LOG_FILE_SIZE="$(opt logging.max_log_file_size)"
export MAX_LOG_FOLDER_SIZE="$(opt logging.max_log_folder_size)"

# Web UI
export WEB_UI_ENABLED="$(opt webui.enabled)"
export WEB_UI_FLAVOR="$(opt webui.flavor)"
export WEB_UI_CHANNEL="$(opt webui.channel)"
export WEB_UI_UPDATE_INTERVAL="$(opt webui.update_interval)"

# Auto-download + conversions + extensions
export AUTO_DOWNLOAD_CHAPTERS="$(opt downloads.auto_download_chapters)"
export AUTO_DOWNLOAD_EXCLUDE_UNREAD="$(opt downloads.auto_download_exclude_unread)"
export AUTO_DOWNLOAD_NEW_CHAPTERS_LIMIT="$(opt downloads.auto_download_new_chapters_limit)"
export AUTO_DOWNLOAD_IGNORE_REUPLOADS="$(opt downloads.auto_download_ignore_reuploads)"
export DOWNLOAD_CONVERSIONS="$(opt downloads.download_conversions)"
export SERVE_CONVERSIONS="$(opt downloads.serve_conversions)"
export EXTENSION_REPOS="$(opt downloads.extension_repos)"
export MAX_SOURCES_IN_PARALLEL="$(opt downloads.max_sources_in_parallel)"

# Updates
export UPDATE_EXCLUDE_UNREAD="$(opt updates.exclude_unread)"
export UPDATE_EXCLUDE_STARTED="$(opt updates.exclude_started)"
export UPDATE_EXCLUDE_COMPLETED="$(opt updates.exclude_completed)"
export UPDATE_INTERVAL="$(opt updates.interval_hours)"
export UPDATE_MANGA_INFO="$(opt updates.update_manga_info)"

# Backup
export BACKUP_TIME="$(opt backup.time)"
export BACKUP_INTERVAL="$(opt backup.interval_days)"
export BACKUP_TTL="$(opt backup.ttl_days)"
export AUTO_BACKUP_INCLUDE_MANGA="$(opt backup.include_manga)"
export AUTO_BACKUP_INCLUDE_CATEGORIES="$(opt backup.include_categories)"
export AUTO_BACKUP_INCLUDE_CHAPTERS="$(opt backup.include_chapters)"
export AUTO_BACKUP_INCLUDE_TRACKING="$(opt backup.include_tracking)"
export AUTO_BACKUP_INCLUDE_HISTORY="$(opt backup.include_history)"
export AUTO_BACKUP_INCLUDE_CLIENT_DATA="$(opt backup.include_client_data)"
export AUTO_BACKUP_INCLUDE_SERVER_SETTINGS="$(opt backup.include_server_settings)"

# FlareSolverr
export FLARESOLVERR_ENABLED="$(opt flaresolverr.enabled)"
export FLARESOLVERR_URL="$(opt flaresolverr.url)"
export FLARESOLVERR_TIMEOUT="$(opt flaresolverr.timeout_seconds)"
export FLARESOLVERR_SESSION_NAME="$(opt flaresolverr.session_name)"
export FLARESOLVERR_SESSION_TTL="$(opt flaresolverr.session_ttl_minutes)"
export FLARESOLVERR_RESPONSE_AS_FALLBACK="$(opt flaresolverr.response_as_fallback)"

# OPDS
export OPDS_USE_BINARY_FILE_SIZES="$(opt opds.use_binary_file_sizes)"
export OPDS_ITEMS_PER_PAGE="$(opt opds.items_per_page)"
export OPDS_ENABLE_PAGE_READ_PROGRESS="$(opt opds.enable_page_read_progress)"
export OPDS_MARK_AS_READ_ON_DOWNLOAD="$(opt opds.mark_as_read_on_download)"
export OPDS_SHOW_ONLY_UNREAD_CHAPTERS="$(opt opds.show_only_unread_chapters)"
export OPDS_SHOW_ONLY_DOWNLOADED_CHAPTERS="$(opt opds.show_only_downloaded_chapters)"
export OPDS_CHAPTER_SORT_ORDER="$(opt opds.chapter_sort_order)"
export OPDS_CBZ_MIME_TYPE="$(opt opds.cbz_mime_type)"

# KOReader sync
export KOREADER_SYNC_CHECKSUM_METHOD="$(opt koreader.sync_checksum_method)"
export KOREADER_SYNC_PERCENTAGE_TOLERANCE="$(opt koreader.sync_percentage_tolerance)"
export KOREADER_SYNC_STRATEGY_FORWARD="$(opt koreader.sync_strategy_forward)"
export KOREADER_SYNC_STRATEGY_BACKWARD="$(opt koreader.sync_strategy_backward)"

# Database
export DATABASE_TYPE="$(opt database.type)"
export DATABASE_URL="$(opt database.url)"
export DATABASE_USERNAME="$(opt database.username)"
export DATABASE_PASSWORD="$(opt database.password)"
export USE_HIKARI_CONNECTION_POOL="$(opt database.use_hikari_connection_pool)"

mkdir -p /home/suwayomi/.local/share
ln -sfn /data/Tachidesk /home/suwayomi/.local/share/Tachidesk
ln -sfn /data/TachideskTmp /tmp/Tachidesk

exec /home/suwayomi/startup_script.sh
