#!/bin/sh
set -eu

# Fetch the necessary ports
portsnap fetch
portsnap extract Mk
portsnap extract ports-mgmt/pkg
portsnap extract net-p2p/rslsync

# Build and install rslsync
cd /usr/ports/net-p2p/rslsync/
make install clean

# Enable the service
sysrc -f /etc/rc.conf rslsync_enable="YES"

# Start the service
service rslsync start 2>/dev/null
