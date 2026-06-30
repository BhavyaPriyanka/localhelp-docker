FROM node:20-alpine

# Install nginx
RUN apk add --no-cache nginx

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source
COPY . .

# Build React app
RUN npm run build

# Create nginx web root and copy build files
RUN mkdir -p /usr/share/nginx/html && \
    rm -rf /usr/share/nginx/html/* && \
    cp -a build/. /usr/share/nginx/html/

# Expose nginx port
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]