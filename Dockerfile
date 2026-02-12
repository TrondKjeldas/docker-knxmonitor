# syntax=docker/dockerfile:1
##
## knxmonitor
##

FROM python:2.7.18-alpine

# Select branch
ARG BRANCH=master

# Copy entrypoint
COPY entrypoint.sh /

# Working directory
WORKDIR /knxlogs
VOLUME /knxlogs

# Install git, clone repo, install, create user, cleanup
RUN --mount=type=cache,target=/var/cache/apk \
    apk add --no-cache git build-base \
    && git clone -b $BRANCH --single-branch https://github.com/TrondKjeldas/knxmonitor.git \
    && cd knxmonitor \
    && python setup.py install \
    && addgroup -g 1000 -S knxmon \
    && adduser -D -S -s /sbin/nologin -u 1000 -G knxmon knxmon \
    && chmod a+x /entrypoint.sh \
    && apk del git build-base

# Use non-root user
USER knxmon

ENTRYPOINT ["/entrypoint.sh"]

# Optional: healthcheck
HEALTHCHECK --interval=60s --timeout=10s --start-period=30s \
  CMD pgrep -f knxmonitor || exit 1
