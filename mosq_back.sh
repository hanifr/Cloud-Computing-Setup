#!/bin/bash

sudo cat >/etc/mosquitto/conf.d/default.conf <<EOL
allow_anonymous true
#password_file /etc/mosquitto/passwd

listener 1883 localhost

#listener 8883
#certfile /etc/letsencrypt/live/example.com/cert.pem
#cafile /etc/letsencrypt/live/example.com/chain.pem
#keyfile /etc/letsencrypt/live/example.com/privkey.pem
        
#listener 8080
#protocol websockets
        
#listener 8083
#protocol websockets
#certfile /etc/letsencrypt/live/example.com/cert.pem
#cafile /etc/letsencrypt/live/example.com/chain.pem
#keyfile /etc/letsencrypt/live/example.com/privkey.pem
EOL
    echo "[*] Starting mosquitto systemd service"
    sudo systemctl daemon-reload
    sudo systemctl reload mosquitto
    #sudo ufw allow 8883
    #sudo ufw allow 8083
    #sudo ufw allow 8083