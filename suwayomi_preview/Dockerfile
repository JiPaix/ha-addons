ARG UPSTREAM_TAG=preview
FROM ghcr.io/suwayomi/suwayomi-server:${UPSTREAM_TAG}

ARG BUILD_VERSION="dev"
ARG BUILD_ARCH="unknown"

LABEL \
  io.hass.version="${BUILD_VERSION}" \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}"

USER root

RUN apt-get update \
  && apt-get install -y --no-install-recommends jq ca-certificates curl gosu \
  && rm -rf /var/lib/apt/lists/*

COPY rootfs/run.sh /run.sh
COPY rootfs/entrypoint.sh /entrypoint.sh
RUN chmod 0755 /run.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
