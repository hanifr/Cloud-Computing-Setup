
#!/bin/bash

# Install CERTBOT for SSL Security
sudo add-apt-repository ppa:certbot/certbot

sudo apt-get update

sudo apt-get install python-certbot-nginx

# Securing Node-RED website
sudo certbot certonly --standalone --preferred-challenges http -d node-red.example.com

# sudo certbot --nginx -d node-red.example.com

cat >/etc/nginx/sites-available/node-red.example.com <<EOL 
server {
    listen 80;
    listen 443 ssl http2;
    server_name node-red.example.com;
    ssl_certificate /etc/letsencrypt/live/node-red.example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/node-red.example.com/privkey.pem;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;
    ssl_prefer_server_ciphers On;
    ssl_session_cache shared:SSL:128m;
    ssl_stapling on;
    ssl_stapling_verify on;
    resolver 8.8.8.8;

    location / {
        if ($scheme = http) {
            return 301 https://$server_name$request_uri;
        }
        proxy_pass http://127.0.0.1:1880;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    location '/.well-known/acme-challenge' {
        root /var/www/html;
    }
}
EOL
sudo ln -s /etc/nginx/sites-available/node-red.example.com /etc/nginx/sites-enabled/
sudo systemctl reload nginx
sleep 5
sudo systemctl start nr
echo "${_MAGENTA}Installation Progress....Node-Red :: completed${_RESET}"