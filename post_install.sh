#!/bin/sh
set -eu

VERSION='2.7.3'

export PREFIX=/usr/local

export RSLSYNC_USER=rslsync
export RSLSYNC_GROUP=rslsync
export CONF="${PREFIX}/etc/rslsync.conf"
export COMMAND="${PREFIX}/bin/rslsync"

# Create user and group


# Setup service file
envsubst '$COMMAND:$CONF:$RSL_USER:$RSL_GROUP' \
    <"${PREFIX}/etc/rslsync/rc.d.template" \
    >"${PREFIX}/etc/rc.d/rslsync"

chmod +x "${PREFIX}/etc/rc.d/rslsync"

# Download
SRC='resilio-sync_freebsd_x64.tar.gz'
SRCDST="/tmp/${SRC}"
fetch -o "$SRCDEST" \
    "https://download-cdn.resilio.com/${VERSION}/FreeBSD-x64/${SRC}"

# Install
tar xjf "$SRCDEST" -C "$(dirname "${COMMAND}")"
chmod +x "$COMMAND"

# Generate config
CONF="${PREFIX}/etc/rslsync/rslsync.conf.sample"
"$COMMAND" --nodaemon --storage /tmp --dump-sample-config >"$CONF"
sed -i -e 's;^//\([[:space:]]*"storage_path"[[:space:]]*:[[:space:]]*\)"/.*",$$;\1"/var/db/rslsync",;' \
       -e 's;^//\([[:space:]]*"pid_file"[[:space:]]*:[[:space:]]*\)"/.*",$$;\1"/var/run/rslsync/rslsync.pid",;' \
    "$CONF"

chown "$RSL_USER":"$RSL_GROUP" "$CONF"

mkdir -p /var/db/rslsync

# Enable the service
sysrc -f /etc/rc.conf rslsync_enable="YES"

# Start the service
service rslsync start 2>/dev/null
