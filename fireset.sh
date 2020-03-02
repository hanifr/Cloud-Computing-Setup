#!/bin/bash

# printing greetings

echo "${_CYAN}Installation Progress....securing the droplet :: started${_RESET}"
echo
echo "${_YELLOW}Now the firewall is enabled.${_RESET}"
echo

sudo ufw enable
sudo ufw allow OpenSSH
sudo ufw allow 1880
sudo ufw allow 1883
echo
echo "${_YELLOW} Ports OpenSSH, 1880, and 1883 are all active.${_RESET}"
echo "${_MAGENTA}Installation Progress....securing the droplet :: completed${_RESET}"