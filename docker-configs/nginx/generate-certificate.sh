#!/bin/bash

# generate a self-signed certificate
openssl genpkey -algorithm RSA -out /etc/nginx/certs/nginx.key
# generate a Certificate Signing Request
openssl req -new -key /etc/nginx/certs/nginx.key -out /etc/nginx/certs/nginx.csr -subj "/CN=$NGINX_SERVER_NAME"
# sign the certificate with the private key
openssl x509 -req -days 365 -in /etc/nginx/certs/nginx.csr -signkey /etc/nginx/certs/nginx.key -out /etc/nginx/certs/nginx.crt

# copy the nginx configuration file
cp /app/nginx.conf /etc/nginx/conf.d/default.conf