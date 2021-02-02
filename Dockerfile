FROM lsiobase/guacgui:amd64-latest

MAINTAINER LawnDoc <doctormay6@gmail.com>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=99
ENV GROUP_ID=100
ENV APPNAME="Firefox"

# Default resolution, change if you like
ENV WIDTH=1920
ENV HEIGHT=1080

# Set path to Firefox side-loading directory
ENV SIDE_LOAD_DIR=/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/

# Rename xpi archive to match application id of extension
ENV PIA_APP_ID={3e4d2037-d300-4e95-859d-3cba866f46d3}.xpi
ENV UBLOCK_APP_ID=uBlock0@raymondhill.net.xpi
#ENV DCTRL_APP_ID=jid1-BoFifL9Vbdl2zQ@jetpack.xpi
#ENV PB_APP_ID=

ENV HOME /nobody
ENV START_URL="https://duckduckgo.com/"

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################

# Install packages needed for app
RUN export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y firefox

# Download add-ons for Firefox and place them in the side-loading directory with the correct naming scheme
RUN curl -sSL https://addons.mozilla.org/firefox/downloads/file/3502793/private_internet_access-2.1.4.2-fx.xpi?src=dp-btn-primary -o $SIDE_LOAD_DIR$PIA_APP_ID && \
    curl -sSL https://addons.mozilla.org/firefox/downloads/file/3027669/ublock_origin-1.20.0-an+fx.xpi?src=collection -o $SIDE_LOAD_DIR$UBLOCK_APP_ID #&& \
#    curl -sSL https://addons.mozilla.org/firefox/downloads/file/3048828/decentaleyes-2.0.12-an+fx.xpi?src=collection -o $SIDE_LOAD_DIR$DCTRL_APP_ID && \
#    curl -sSL https://addons.mozilla.org/firefox/downloads/file/1667956/privacy_badger-2019.1.30-an+fx.xpi?src=dp-btn-primary -o $SIDE_LOAD_DIR$PB_APP_ID

#########################################
##           GUI APP SETUP             ##
#########################################

# Set security
WORKDIR /nobody
RUN mkdir -p /etc/my_init.d && \
    echo 'admin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set start page
RUN echo "pref(\"browser.startup.homepage\", \"$START_URL\");" > /etc/firefox/syspref.js

# Copy X app start script to right location
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh
COPY root /


#########################################
##         EXPORTS AND VOLUMES         ##
#########################################
VOLUME ["/config"]
EXPOSE 3389 8080
