#!/bin/sh
set -eu

# Fetch the necessary ports
portsnap fetch
for path in Mk UIDs GIDs Keywords Templates ports-mgmt/pkg net-p2p/rslsync; do
    portsnap extract "$path"
done

# Build and install rslsync
cd /usr/ports/net-p2p/rslsync/
make install clean

# Enable the service
sysrc -f /etc/rc.conf rslsync_enable="YES"

# Start the service
service rslsync start 2>/dev/null
