#!/usr/bin/env bash
# Enable CRB and EPEL for CentOS Stream 9
set -euo pipefail

echo "==> Enabling CRB repository..."
dnf config-manager --set-enabled crb || true

echo "==> Installing EPEL release packages..."
dnf -y install \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
    https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-9.noarch.rpm \
    || true

echo "==> Enabling Budgie COPR repositories..."
dnf -y copr enable stenstorp/budgie-dependencies || true
dnf -y copr enable stenstorp/budgie || true

# Verify
echo "==> Enabled repositories:"
dnf repolist enabled

echo "==> Repos configured successfully."
