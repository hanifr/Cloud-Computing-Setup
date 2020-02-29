#!/bin/bash

# printing greetings

echo "${_CYAN}Installation Progress....MQTT Mosquitto :: started${_RESET}"
echo

# Installation of MQTT Mosquitto dependencies
sudo apt install mosquitto mosquitto-clients
sleep 5
systemctl reload mosquitto

# start doing stuff: preparing MQTT Mosquitto
# preparing script background work and work under reboot
echo "[*] Creating mosquitto systemd service"
cat >/etc/mosquitto/conf.d/default.conf <<EOL
allow_anonymous true
#password_file /etc/mosquitto/passwd

listener 1883 localhost
EOL
    echo "[*] Starting mosquitto systemd service"
    sudo systemctl daemon-reload
    sudo systemctl reload mosquitto
#    sudo systemctl status mosquitto
    echo "To see MQTT Mosquitto status run \"sudo systemctl status mosquitto\" command"
echo "${_YELLOW}The apps is now running on background${_RESET}"

echo
echo "${_YELLOW}Please execute \"mosquitto_sub -d -h localhost -t test\" to test the apps.${_RESET}"
echo
echo "${_YELLOW}head to \"cd /etc/mosquitto/conf.d/default.conf\" and change${_RESET}"
echo
echo "${_YELLOW}\"localhost to domain\" if you have one${_RESET}"
echo

echo "${_MAGENTA}Installation Progress....MQTT Mosquitto :: completed${_RESET}"