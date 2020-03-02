#!/bin/bash
# Colors
_CYAN=`tput setaf 1`
_GREEN=`tput setaf 2`
_YELLOW=`tput setaf 3`
_BLUE=`tput setaf 4`
_MAGENTA=`tput setaf 5`
_CYAN=`tput setaf 6`
_RESET=`tput sgr0`

VERSION=1.0

echo "Installation of Node-Red, Mosquitto and security setup for Digitalocean Droplet v$VERSION."
echo "${_GREEN}(please report issues to tronexia@gmail.com email with full output of this script with extra \"-x\" \"bash\" option)${_RESET}"

if [ "$(id -u)" == "0" ]; then
  echo "WARNING: Generally it is not adviced to run this script under root"
fi

if [ -z $HOME ]; then
  echo "ERROR: Please define HOME environment variable to your home directory"
  exit 1
fi

if [ ! -d $HOME ]; then
  echo "ERROR: Please make sure HOME directory $HOME exists"
  exit 1
fi

echo "${_CYAN}Installation Progress....${_RESET}"

# Adding privilage to setup files
chmod +x $HOME/Cloud-Computing-Setup/nred.sh
chmod +x $HOME/Cloud-Computing-Setup/nr_dependencies.sh
chmod +x $HOME/Cloud-Computing-Setup/mosq.sh
chmod +x $HOME/Cloud-Computing-Setup/fireset.sh

. nred.sh
sleep 5
. mosq.sh
sleep 5
. fireset.sh
echo 
echo "${_CYAN}Installation Progress....Node-Red, Mosquitto, and Firewall are all completed${_RESET}"
echo
echo "${_CYAN}Do you want delete the setup files?${_RESET} $_setfile"
                read -p "Enter yes or no: " _setfile
c1="yes"
        if [ "$_setfile" = "$c1" ]; then
        rm -rf $HOME/Cloud-Computing-Setup
        echo "The setup files have been deleted"
        fi