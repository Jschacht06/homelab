#!/usr/bin/env bash
set -e



echo "[+] Updating package information..."

apt-get update


echo "[+] Installing dependencies..."

apt-get install -y curl gnupg apt-transport-https


echo "[+] Installing GPG Keys..."

curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg





echo "[+] Adding the repositories & Updating package information..."

echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list

apt-get update



echo "[+] Installing the agent..."

WAZUH_MANAGER="192.168.50.107" apt-get install -y wazuh-agent


echo "[+] Enabling and Starting the agent..."

systemctl daemon-reload

systemctl enable wazuh-agent

systemctl start wazuh-agent




echo "[+] Disabling automatic updates..."

sed -i "s/^deb/#deb/" /etc/apt/sources.list.d/wazuh.list

apt-get update


echo "[+] Done."