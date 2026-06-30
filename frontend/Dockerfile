FROM node:20-alpine

# Install nginx
RUN apk add --no-cache nginx

WORKDIR /app

# Install dependencies
COPY code/package*.json ./
RUN npm install

# Copy source
COPY code/ .

# Build React app
RUN npm run build

# Create nginx web root and copy build files
RUN mkdir -p /usr/share/nginx/html && \
    rm -rf /usr/share/nginx/html/* && \
    cp -a build/. /usr/share/nginx/html/

COPY localhelp.conf /etc/nginx/http.d/default.conf

# Expose nginx port
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]