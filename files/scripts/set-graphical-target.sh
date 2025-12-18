#!/usr/bin/env bash
# Set systemd default target to graphical
set -euo pipefail

echo "==> Setting default target to graphical.target..."
systemctl set-default graphical.target

echo "==> Default target set."
