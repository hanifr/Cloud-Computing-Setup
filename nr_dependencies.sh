#!/bin/bash

# Install the software requirements

echo "${_GREEN}INSTALL DEPENDS STARTED${_RESET}"
    # Install NodeJS
    sudo apt-get update
    #curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
    #sudo bash nodesource_setup.sh

    sudo apt-get upgrade -y
    sleep 5
    sudo apt install nodejs
    sudo apt-get install npm
    
    #  Install Node-RED
    sudo apt install build-essential git curl
    bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered) --node14
    sudo npm install -g --unsafe-perm node-red node-red-admin
    sleep 5
echo "${_CYAN} Now I will set open port 1880${_RESET}"
	sudo ufw allow 1880
    sleep 5
echo "${_CYAN}INSTALL DEPENDS STOPPED${_RESET}"


