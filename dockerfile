# Stage 1: Build aplikasi Vue
FROM node:18 AS build-stage

# Tentukan working directory
WORKDIR /app

# Copy file package.json dan install dependensi
COPY package.json package-lock.json ./
RUN npm install

# Copy semua file proyek ke dalam container
COPY . .

# Build aplikasi Vue
RUN npm run build

# Stage 2: Serve menggunakan NGINX
FROM nginx:stable-alpine AS production-stage

# Copy output build Vue ke direktori NGINX
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

COPY mime.types /etc/nginx/mime.types

# Tidak perlu EXPOSE, Cloud Run akan menangani port

# Gunakan entrypoint script untuk mengatur port dinamis
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]