# Stage 1: Build aplikasi Vue
FROM node:latest as build-stage

# Tentukan working directory
WORKDIR /app

# Copy file package.json dan install dependensi
COPY package*.json ./
RUN npm install

# Copy semua file proyek ke dalam container
COPY . .

# Build aplikasi Vue
RUN npm run build

# Stage 2: Serve menggunakan NGINX
FROM nginx:stable-alpine AS production-stage

RUN mkdir /app

# Copy output build Vue ke direktori NGINX
COPY --from=build-stage /app/dist /app

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

COPY mime.types /etc/nginx/mime.types