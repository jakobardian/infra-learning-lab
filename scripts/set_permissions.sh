#!/bin/bash
set -euo pipefail

echo "[4/5] Set permissions"

BASE_DIR="/var/project/learning-demo-app"

sudo chown vanny:developer "$BASE_DIR"
sudo chmod 770 "$BASE_DIR"

echo "Owner: vanny | Group: developer | Permission: 770"
echo "[4/5] Permissions applied"

