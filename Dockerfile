FROM nginx:latest

COPY ./index.html /usr/share/nginx/html/

COPY ./app.conf /etc/nginx/conf.d/default.conf

EXPOSE 80