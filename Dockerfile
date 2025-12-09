# Stage 1: Build Angular app
FROM node:16 AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build -- --configuration production --verbose

# Stage 2: Serve using Nginx
FROM nginx:alpine
COPY --from=builder /app/dist/angular-app /usr/share/nginx/html

EXPOSE 80
