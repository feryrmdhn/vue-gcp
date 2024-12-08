#!/bin/sh
# Ganti port di konfigurasi NGINX dengan PORT dari environment variable
sed -i "s/listen \$PORT/listen ${PORT:-8080}/" /etc/nginx/nginx.conf

# Jalankan NGINX
nginx -g 'daemon off;'