#!/bin/bash

# Install the software requirements

echo "${_GREEN}INSTALL DEPENDS STARTED${_RESET}"
    sudo apt-get install nodejs
    sudo apt-get install npm
    sudo npm install -g --unsafe-perm node-red node-red-admin
    sleep 5
echo "${_CYAN} Now I will set open port 1880${_RESET}"
	sudo ufw allow 1880
    sleep 5
echo "${_CYAN}INSTALL DEPENDS STOPPED${_RESET}"