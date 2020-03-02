#!/bin/bash
    echo "[*] Starting mosquitto systemd service"
    sudo systemctl daemon-reload
    sudo systemctl reload mosquitto
    #sudo ufw allow 8883
    #sudo ufw allow 8083
    #sudo ufw allow 8083