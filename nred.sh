#!/bin/bash

# printing greetings

echo "${_CYAN}Installation Progress....Node-Red :: started${_RESET}"
echo

# Installation of node-red dependencies
. nr_dependencies.sh

# start doing stuff: preparing node-red

echo "[*] Removing previous node-red (if any)"
if sudo -n true 2>/dev/null; then
  sudo systemctl stop nr.service
fi
killall -9 node-red

echo "Node-Red will run automatically on system start, is it OK?$_nred"
                read -p "Enter yes or no: " _nred
c1="yes"
c2="no"
if [ "$_nred" = "$c1" ]; then
# preparing script background work and work under reboot
echo "[*] Creating nr systemd service"
cat >/tmp/nr.service <<EOL
    
    [Unit]
    Description=Node-RED
    After=syslog.target network.target
    [Service]
    ExecStart=/usr/local/bin/node-red-pi --max-old-space-size=128 -v
    Restart=on-failure
    KillSignal=SIGINT

    # log output to syslog as 'node-red'
    SyslogIdentifier=node-red
    StandardOutput=syslog

    # non-root user to run as
    WorkingDirectory=/home/$USER/
    User=$USER
    Group=$USER

    [Install]
    WantedBy=multi-user.target
EOL
    sudo mv /tmp/nr.service /etc/systemd/system/nr.service
    echo "[*] Starting nr systemd service"
    sudo systemctl daemon-reload
    sudo systemctl enable nr.service
    sudo systemctl start nr.service
    echo "To see node-red status run \"sudo systemctl status nr.service \" command"
echo "${_YELLOW}The apps is now running on background${_RESET}"
fi

if [ "$_nred" = "$c2" ]; then
echo
echo "${_YELLOW}Please execute node-red to run the apps.${_RESET}"
echo "${_YELLOW}Enjoy!!!${_RESET}"
echo
fi

echo "${_MAGENTA}Installation Progress....Node-Red :: completed${_RESET}"