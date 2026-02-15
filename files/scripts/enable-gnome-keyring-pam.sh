#!/usr/bin/env bash
set -euo pipefail

# Ensure PAM profile is GNOME and includes keyring bits (authselect-managed systems)
if command -v authselect >/dev/null 2>&1; then
  authselect select gnome --force || true
  authselect apply-changes || true
fi

# Helpful diagnostics at build time
rpm -q gnome-keyring gnome-keyring-pam libsecret || true
