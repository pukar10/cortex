# --- Build stage ---
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# --- Production stage ---
FROM nginx:alpine
# React build output
COPY --from=builder /app/dist /usr/share/nginx/html
# Your nginx config (replaces the default)
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
