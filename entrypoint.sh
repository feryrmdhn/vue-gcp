#!/bin/sh
# Ganti port NGINX sesuai variabel lingkungan
envsubst '${PORT}' < /etc/nginx/nginx.conf > /tmp/nginx.conf
mv /tmp/nginx.conf /etc/nginx/nginx.conf

# Jalankan NGINX
exec nginx -g "daemon off;"