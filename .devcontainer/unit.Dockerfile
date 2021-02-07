# keep our base image as small as possible
FROM nginx/unit:1.21.0-minimal

# same as "working_directory" in config.json
COPY www/app1.js /www/app.js

# add NGINX Unit and Node.js repos
RUN apt update                                                                \
    && apt install -y apt-transport-https gnupg1 lsb-release                  \
    && curl https://nginx.org/keys/nginx_signing.key | apt-key add -          \
    && echo "deb https://packages.nginx.org/unit/debian/ `lsb_release -cs` unit"  \
         > /etc/apt/sources.list.d/unit.list                                  \
    && echo "deb-src https://packages.nginx.org/unit/debian/ `lsb_release -cs` unit"  \
         >> /etc/apt/sources.list.d/unit.list                                 \
    && curl https://deb.nodesource.com/setup_12.x | bash -                    \
# install build chain
    && apt update                                                             \
    && apt install -y build-essential nodejs unit-dev=$UNIT_VERSION           \
# add global dependencies
    && npm install -g --unsafe-perm unit-http                                 \
# add app dependencies locally
    && cd /www && npm link unit-http && npm install express                   \
# final cleanup
    && apt remove -y build-essential unit-dev apt-transport-https             \
           gnupg1 lsb-release                                                 \
    && apt autoremove --purge -y                                              \
    && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/*.list

# port used by the listener in config.json
EXPOSE 8080
