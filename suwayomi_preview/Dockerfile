ARG UPSTREAM_TAG=stable
FROM ghcr.io/suwayomi/suwayomi-server:${UPSTREAM_TAG}

ARG BUILD_VERSION="dev"
ARG BUILD_ARCH="unknown"

LABEL \
  io.hass.version="${BUILD_VERSION}" \
  io.hass.type="addon" \
  io.hass.arch="${BUILD_ARCH}"

USER root

# Ensure jq exists to read /data/options.json
RUN apt-get update \
  && apt-get install -y --no-install-recommends jq ca-certificates curl \
  && rm -rf /var/lib/apt/lists/*

COPY rootfs/run.sh /run.sh
RUN chmod a+x /run.sh

USER suwayomi
CMD ["/run.sh"]
