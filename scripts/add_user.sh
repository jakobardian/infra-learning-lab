#!/bin/bash
set -euo pipefail

echo "[2/5] Add users"

ensure_user() {
  local user="$1"
  local group="$2"
  local shell="/bin/bash"

  if id "$user" &>/dev/null; then
    echo "User '$user' already exists"
  else
    sudo useradd -m -s "$shell" -g "$group" "$user"
    echo "User '$user' created (group: $group)"
  fi
}

ensure_user vanny developer
ensure_user grace database
ensure_user stacey operation

echo "[2/5] Users created"

