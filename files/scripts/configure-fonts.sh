#!/usr/bin/env bash
set -euo pipefail

echo "==> Configuring font rendering..."
mkdir -p /etc/fonts
cp /tmp/config/files/etc/fonts/local.conf /etc/fonts/local.conf

# Rebuild font cache
fc-cache -f

echo "==> Font rendering configured."
