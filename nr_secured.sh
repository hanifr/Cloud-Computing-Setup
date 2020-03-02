#!/bin/bash
# Colors
_RED=`tput setaf 1`
_GREEN=`tput setaf 2`
_YELLOW=`tput setaf 3`
_BLUE=`tput setaf 4`
_MAGENTA=`tput setaf 5`
_CYAN=`tput setaf 6`
_RESET=`tput sgr0`
echo "${_CYAN}Begin Securing Node-Red Apps. ${_RESET}"
echo
echo "${_CYAN}Please Copy the following encrypted text.${_RESET}"
echo
sleep 10
echo "${_CYAN}Then, Uncomment the following lines in \"~/.node-red/settings.js\"${_RESET}"
echo
echo "adminAuth: {"
echo "   type: \"credentials\","
echo "   users: [{"
echo "   username: \"username\","
echo "   password: \"paste here\","
echo "   permissions: \"*\""
echo "   }]"
echo " },"

node-red-admin hash-pw

echo "${_CYAN} By execute \"nano ~/.node-red/settings.js\"${_RESET}"
echo
sleep 5
sudo ufw deny 1880
sudo systemctl restart nr
echo "${_CYAN} Now Your Node-Red is secured.${_RESET}"
echo

