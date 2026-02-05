#!/usr/bin/env sh
set -eu

CONFIG_PATH="/data/options.json"

opt() {
  jq -r --arg k "$1" '(.[$k] // "") | if . == null then "" else tostring end' "$CONFIG_PATH" 2>/dev/null || echo ""
}

export TZ="$(opt tz)"
export BIND_IP="$(opt bind_ip)"
export BIND_PORT="$(opt bind_port)"

export SOCKS_PROXY_ENABLED="$(opt socks_proxy_enabled)"
export DOWNLOAD_AS_CBZ="$(opt download_as_cbz)"

export AUTH_MODE="$(opt auth_mode)"
export AUTH_USERNAME="$(opt auth_username)"
export AUTH_PASSWORD="$(opt auth_password)"

export DEBUG="$(opt debug)"
export MAX_LOG_FILES="$(opt max_log_files)"
export MAX_LOG_FILE_SIZE="$(opt max_log_file_size)"
export MAX_LOG_FOLDER_SIZE="$(opt max_log_folder_size)"

export WEB_UI_ENABLED="$(opt web_ui_enabled)"
export WEB_UI_FLAVOR="$(opt web_ui_flavor)"
export WEB_UI_CHANNEL="$(opt web_ui_channel)"
export WEB_UI_UPDATE_INTERVAL="$(opt web_ui_update_interval)"

export AUTO_DOWNLOAD_CHAPTERS="$(opt auto_download_chapters)"
export AUTO_DOWNLOAD_EXCLUDE_UNREAD="$(opt auto_download_exclude_unread)"
export AUTO_DOWNLOAD_NEW_CHAPTERS_LIMIT="$(opt auto_download_new_chapters_limit)"
export AUTO_DOWNLOAD_IGNORE_REUPLOADS="$(opt auto_download_ignore_reuploads)"

export MAX_SOURCES_IN_PARALLEL="$(opt max_sources_in_parallel)"

export UPDATE_EXCLUDE_UNREAD="$(opt update_exclude_unread)"
export UPDATE_EXCLUDE_STARTED="$(opt update_exclude_started)"
export UPDATE_EXCLUDE_COMPLETED="$(opt update_exclude_completed)"
export UPDATE_INTERVAL="$(opt update_interval)"
export UPDATE_MANGA_INFO="$(opt update_manga_info)"

export BACKUP_TIME="$(opt backup_time)"
export BACKUP_INTERVAL="$(opt backup_interval)"
export BACKUP_TTL="$(opt backup_ttl)"

export FLARESOLVERR_ENABLED="$(opt flaresolverr_enabled)"
export FLARESOLVERR_URL="$(opt flaresolverr_url)"
export FLARESOLVERR_TIMEOUT="$(opt flaresolverr_timeout)"
export FLARESOLVERR_RESPONSE_AS_FALLBACK="$(opt flaresolverr_response_as_fallback)"

export KOREADER_SYNC_STRATEGY_FORWARD="$(opt koreader_sync_strategy_forward)"
export KOREADER_SYNC_STRATEGY_BACKWARD="$(opt koreader_sync_strategy_backward)"

export DATABASE_TYPE="$(opt database_type)"
export DATABASE_URL="$(opt database_url)"

exec /home/suwayomi/startup_script.sh
