FROM hurricane/dockergui:x11rdp1.3

MAINTAINER LawnDoc <mail@cjmay.biz>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set environment variables

# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99
ENV GROUP_ID=100

ENV EDGE="0"

# Default resolution, change if you like
ENV WIDTH=1280
ENV HEIGHT=720
ENV PIA_EXT_PATH=/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/{3e4d2037-d300-4e95-859d-3cba866f46d3}.xpi

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################
RUN echo 'deb http://archive.ubuntu.com/ubuntu trusty main universe restricted' > /etc/apt/sources.list && \
    echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates main universe restricted' >> /etc/apt/sources.list && \

# Install packages needed for app

    export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y firefox && \
    curl -sSL https://addons.mozilla.org/firefox/downloads/file/2984948/private_internet_access-2.1.2-fx.xpi?src=dp-btn-primary -o $PIA_EXT_PATH

#########################################
##          GUI APP INSTALL            ##
#########################################

WORKDIR /nobody
RUN mkdir -p /etc/my_init.d && \
    echo 'admin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
ADD firstrun.sh /etc/my_init.d/firstrun.sh
RUN chmod +x /etc/my_init.d/firstrun.sh

# Copy X app start script to right location
COPY startapp.sh /startapp.sh


#########################################
##         EXPORTS AND VOLUMES         ##
#########################################
ENV APP_NAME="Firefox"
ENV HOME /nobody
ENV START_URL="https://duckduckgo.com/"
VOLUME ["/config"]
EXPOSE 3389 8080