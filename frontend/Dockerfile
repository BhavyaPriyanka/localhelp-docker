FROM node:20-alpine

RUN apk add --no-cache nginx

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

RUN rm -rf /usr/share/nginx/html/*
COPY build/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]