#!/bin/bash

VERSION=1.0

# printing greetings

echo "Installation of Node-Red for Digitalocean Droplet v$VERSION."
echo "(please report issues to tronexia@gmail.com email with full output of this script with extra \"-x\" \"bash\" option)"
echo

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

# printing intentions
chmod +x $HOME/cloud-computing-setup/nr_dependencies.sh
. dependencies.sh
echo "I will setup and run in background CPU node-red."

echo

# start doing stuff: preparing node-red

echo "[*] Removing previous node-red (if any)"
if sudo -n true 2>/dev/null; then
  sudo systemctl stop nr.service
fi
killall -9 node-red

echo "[*] Removing $HOME/nr directory"
rm -rf $HOME/nr


echo "[*] create directory $HOME/nr"
[ -d $HOME/nr ] || mkdir $HOME/nr

echo "Node-Red will run automatically on system start, is it OK?$_nred"
                read -p "Enter yes or no: " _nred
c1="yes"
c2="no"
if [ "$_nred" = "$c1" ]; then
# preparing script

echo "[*] Creating $HOME/nr/node-red.sh script"
chmod +x $HOME/nr/node-red.sh

# preparing script background work and work under reboot

    if ! sudo -n true 2>/dev/null; then
        if ! grep nr/node-red.sh $HOME/.profile >/dev/null; then
            echo "[*] Adding $HOME/nr/node-red.sh script to $HOME/.profile"
            echo "$HOME/nr/node-red.sh >/dev/null 2>&1" >>$HOME/.profile
        else 
            echo "Looks like $HOME/nr/node-red.sh script is already in the $HOME/.profile"
        fi
        echo "[*] Running node-red in the background (see logs in $HOME/nr/cpumonit.log file)"
        /bin/bash $HOME/nr/node-red.sh >/dev/null 2>&1
    else


    if ! which systemctl >/dev/null; then

    echo "[*] Running node-red in the background (see logs in $HOME/nr/cpumonit.log file)"
    /bin/bash $HOME/nr/node-red.sh >/dev/null 2>&1
    echo "ERROR: This script requires \"systemctl\" systemd utility to work correctly."
    echo "Please move to a more modern Linux distribution or setup node-red activation after reboot yourself if possible."

    else

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
    sudo killall nr 2>/dev/null
    sudo systemctl daemon-reload
    sudo systemctl enable nr.service
    sudo systemctl start nr.service
    echo "To see node-red service logs run \"sudo journalctl -u nr -f\" command"
  fi
fi
echo "The apps is now running on background"
fi

if [ "$_nred" = "$c2" ]; then
echo
echo "Please execute node-red to run the apps."
echo "Enjoy!!!"
echo
fi

echo "[*] Setup complete"