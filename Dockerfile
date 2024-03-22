FROM node:18 AS build

WORKDIR /opt/node_app

RUN yarn config set "strict-ssl" false

COPY package.json yarn.lock ./
RUN yarn

#ARG NODE_ENV=production

COPY . .

WORKDIR /opt/node_app/excalidraw-app
RUN yarn

#ARG NODE_ENV=production

RUN yarn build:app:docker

FROM nginx:1.21-alpine

COPY --from=build /opt/node_app/excalidraw-app/build /usr/share/nginx/html

# default.conf 삭제
RUN rm /etc/nginx/conf.d/default.conf

# 작성한 nginx.conf 복제
COPY nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ssl/server.crt /etc/nginx/ssl/server.crt
COPY ssl/server.key /etc/nginx/ssl/server.key

HEALTHCHECK CMD wget -q -O /dev/null http://localhost || exit 1
