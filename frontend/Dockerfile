FROM node:20-alpine

# Install nginx
RUN apk add --no-cache nginx

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

RUN ls -l /usr/share/nginx

COPY . .

# Build React app
RUN npm run build

# Copy build output to nginx's web root
RUN rm -rf /usr/share/nginx/html/*

RUN mkdir -p /usr/share/nginx/html

RUN  cp -r build/* /usr/share/nginx/html/

# Expose HTTP port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
