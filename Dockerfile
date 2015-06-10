FROM nginx:1.9.1

##############################################################################
# Copy helper scripts into the container:
##############################################################################
# * clean-up-docker-container: Cleans up logs and other items that use space in the container.
ADD clean-up-docker-container /usr/local/bin/clean-up-docker-container

##############################################################################
# Apply Security Upgrades
##############################################################################
# **This always needs to be the very first step after installing the helper scripts.**
# If you 'date +%s > latest-security-upgrades' and commit it, the latest security updates
# will be appplied, because every later step will be invalidated
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ADD .latest-security-upgrades /.latest-security-upgrades
RUN apt-get update && apt-get -y upgrade && /usr/local/bin/clean-up-docker-container

RUN rm -f /etc/nginx/conf.d/default.conf

# The nginx docker container includes symlinks for access.log and error.log to /dev/null
# while we want useful logs in those locations:
RUN rm -f /var/log/nginx/access.log /var/log/nginx/error.log

COPY /etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY /etc/nginx/conf.d/default-server.conf /etc/nginx/conf.d/default-server.conf

VOLUME /var/log/nginx
