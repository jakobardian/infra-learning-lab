#!/bin/bash
set -euo pipefail

echo "[1/5] Create groups"

ensure_group() {
  local group="$1"

  if getent group "$group" &>/dev/null; then
    echo "Group '$group' already exists"
  else
    sudo groupadd "$group"
    echo "Group '$group' created"
  fi
}

ensure_group developer
ensure_group database
ensure_group operation

echo "[1/5] Groups created"

