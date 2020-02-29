#!/bin/bash

# printing greetings

echo "${_CYAN}Installation Progress....MQTT Mosquitto :: started${_RESET}"
echo

# Installation of MQTT Mosquitto dependencies
sudo apt install mosquitto mosquitto-clients
sleep 5
systemctl restart mosquitto
echo "${_MAGENTA}Please do the following${_RESET}"
echo "${_CYAN}\"sudo mosquitto_passwd -c /etc/mosquitto/passwd your_username\"${_RESET}"
echo
echo "${_CYAN}\"then enter your password\"${_RESET}"
echo
echo "${_CYAN}Now MQTT Mosquitto will be according to your domain_name${_RESET}"

# start doing stuff: preparing MQTT Mosquitto
# preparing script background work and work under reboot
echo "[*] Creating mosquitto systemd service"
#cat >/tmp/mosquitto.service <<EOL
#[Unit]
#Description=Mosquitto MQTT Broker
#Documentation=man:mosquitto(8)
#Documentation=man:mosquitto.conf(5)
#ConditionPathExists=/etc/mosquitto/mosquitto.conf
#After=xdk-daemon.service

#[Service]
#ExecStart=/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf
#ExecReload=/bin/kill -HUP $MAINPID
#User=mosquitto
#Restart=on-failure
#RestartSec=10

#[Install]
#WantedBy=multi-user.target
#EOL
#    sudo mv /tmp/mosquitto.service /etc/systemd/system/mosquitto.service
#    echo "[*] Starting mosquitto systemd service"
#    sudo systemctl daemon-reload
#    sudo systemctl enable mosquitto.service
#    sudo systemctl start mosquitto.service

. mosq_back.sh

echo "To see MQTT Mosquitto status run \"sudo systemctl status mosquitto\" command"
echo "${_YELLOW}The apps is now running on background${_RESET}"

echo
echo "${_YELLOW}Please execute \"mosquitto_sub -d -h localhost -t test\" to test the apps.${_RESET}"
echo
echo "${_YELLOW}head to \"cd /etc/mosquitto/conf.d/default.conf\" and change${_RESET}"
echo
echo "${_YELLOW}\"localhost to domain\" if you have one${_RESET}"
echo
echo "${_YELLOW}Execute \"sudo systemctl status mosquitto\" to check the operation status${_RESET}"
echo
echo "${_MAGENTA}Installation Progress....MQTT Mosquitto :: completed${_RESET}"
