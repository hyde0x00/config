#!/bin/sh

# https://amnezia.org/downloads
# https://github.com/amnezia-vpn/amnezia-client/issues/1268#issuecomment-2700796935

cp amnezia-vpn-monitor "$HOME/bin/amnezia-vpn-monitor"
chmod +x "$HOME/bin/amnezia-vpn-monitor"

cp amnezia-vpn-monitor.service "$HOME/.config/systemd/user/amnezia-vpn-monitor.service"

sudo cp amnezia-vpn "/usr/lib/systemd/system-sleep/amnezia-vpn"
sudo chmod +x "/usr/lib/systemd/system-sleep/amnezia-vpn"

systemctl --user daemon-reload
systemctl --user enable --now amnezia-vpn-monitor.service
