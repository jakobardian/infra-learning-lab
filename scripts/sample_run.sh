#!/bin/bash
set -euo pipefail

echo "=== Infrastructure Setup Started ==="

./scripts/create_group.sh
./scripts/add_user.sh
./scripts/setup_directory.sh
./scripts/set_permissions.sh

echo "=== Infrastructure Setup Completed ==="

