FROM node:16 as build

WORKDIR /app

COPY package.json /app/

RUN yarn

COPY . /app/

RUN yarn build


FROM nginx:latest

COPY --from=build /app/build /usr/share/nginx/html

COPY --from=build /app/nginx.conf /etc/nginx/conf.d/default.conf
