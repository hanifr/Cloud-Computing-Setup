
#!/bin/bash

# Install CERTBOT for SSL Security
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:certbot/certbot
# Install Certbot's Nginx package
#sudo apt install python-certbot-nginx
sudo apt install python3-certbot-nginx

echo "${_CYAN}Please Enter your domain_name${_RESET} $_domain"
                read -p "Enter your Domain_name or localhost: " _domain
echo
echo "${_CYAN}You have entered $_domain for your domain name${_RESET}"
echo

# Securing Node-RED website
#sudo certbot certonly --standalone --preferred-challenges http -d $_domain

sudo certbot --nginx -d $_domain

sudo ufw allow 80

sudo ufw allow 443

sudo ufw allow 'Nginx HTTP'

sudo cat >/etc/nginx/sites-available/$_domain <<EOL 
server {
    listen 80;
    listen 443 ssl http2;
    server_name $_domain;
    ssl_certificate /etc/letsencrypt/live/$_domain/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$_domain/privkey.pem;
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
        proxy_pass http://localhost:1880;
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
sudo ln -s /etc/nginx/sites-available/$_domain /etc/nginx/sites-enabled/

sudo rm -rf /etc/nginx/sites-available/default

sudo rm -rf /etc/nginx/sites-enabled/default

sudo systemctl daemon-reload

sudo nginx -t

sudo systemctl reload nginx
sleep 5
sudo systemctl start nr
echo "${_MAGENTA}Installation Progress....Node-Red :: completed${_RESET}"
echo
echo "${_RED}To secure node-red, run \"./nr_secure.sh\"${_RESET}"
echo