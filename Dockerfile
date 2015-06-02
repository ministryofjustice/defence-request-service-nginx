FROM nginx:1.9.1

RUN rm -f /etc/nginx/conf.d/default.conf

COPY /etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY /etc/nginx/conf.d/default-server.conf /etc/nginx/conf.d/default-server.conf

VOLUME /var/log/nginx
