#!/usr/bin/env bash
set -euo pipefail

SCRIPT_URL="https://raw.githubusercontent.com/Jschacht06/homelab/main/scripts/wazuh-agent-install.sh"

CTIDS=(
  102
  103
  104
  106
  110
  160
)

for CTID in "${CTIDS[@]}"; do
  echo "======================================"
  echo "[+] Installing Wazuh agent on CT ${CTID}"
  echo "======================================"

  pct exec "$CTID" -- bash -c "
    set -e
    apt-get update
    apt-get install -y curl ca-certificates
    curl -fsSL -o /tmp/wazuh-agent-install.sh '${SCRIPT_URL}'
    bash /tmp/wazuh-agent-install.sh
  "

  echo "[+] Done with CT ${CTID}"
done

echo "[+] Finished all containers."

echo "[+] Deleting script..."

rm -- "$0"

echo "[+] Done..."

