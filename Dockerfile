FROM nginx:1.9.2

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

# Remove the default config file. This is replaced at start time by the "run-nginx" command,
# which substitutes in environment variables
RUN rm -f /etc/nginx/conf.d/default.conf
RUN mkdir -p /etc/nginx/conf.d-templates/

COPY /etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY etc/nginx/conf.d-templates/default-server.conf.template /etc/nginx/conf.d-templates/

VOLUME /var/log/nginx

COPY run-nginx /usr/local/bin/run-nginx
CMD /usr/local/bin/run-nginx
