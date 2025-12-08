# ---------- Stage 1: Build Angular App ----------
FROM node:18-alpine AS build     # ✔ Use LTS node, not node:latest
WORKDIR /app

COPY package*.json ./
RUN npm install --legacy-peer-deps

COPY . .
RUN npm run build --configuration production   # ✔ Correct build command


# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine
COPY --from=build /app/dist/* /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
