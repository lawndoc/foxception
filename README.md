# Foxception

## Browser in a browser

This docker container runs a web server that opens up a Firefox instance in your browser when you navigate to it. It runs xRDP over Apache Guacamole that is locked into a Firefox window.

![](foxception.png)

This project was inspired by [this blog post](http://ivo2u.nl/Yo). IvoNet's creation is really cool, but I thought I would build my own and add some improvements. First, I updated the apache guacamole image to a more current one. Then I switched the browser to Firefox and figured out how to sideload extensions so that they are already baked into the browser when you build the image.

## Installation / running the image

This image includes Firefox and the following extensions: PIA vpn. The Dockerfile also has commented out lines for uBlock Origin, Decentraleyes, and Privacy Badger. They have been commented out to help with stability, but you can easily uncomment them to suit your needs. This image is published on DockerHub, and you can run it with the command:

`$ docker run -d --rm --shm-size=1G --ipc=host --name foxception lawndoc/foxception:Privacy`

It is important to include all of the flags in order for this docker container to run and close properly. I recommend you read up on all of the flags being used and what they mean (see IMPORTANT NOTE below).

## Choosing your own extensions

To pick your own default extensions, you need to add the xpi archive to the directory /usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/

The archive must be named &lt;app id>.xpi where &lt;app id> is the application id of the add-on. For example, {ec8030f7-c20a-464f-9b0e-13a3a9e97384} is the app id of Firefox, and is the name of the directory that you should add the xpi archives to. You can find the app/extension id of any add-on that you already have by going to about:debugging in your local Firefox browser.

To download an extension, just do a curl like in the Dockerfile. You can get the download url of the add-on's xpi archive by going to the Firefox add-ons website and hovering over or right-clicking the "Add to Firefox" button.

## IMPORTANT NOTE:

Depending on your setup, this browser may be exposed to the internet. Since it is running on your network, anything that is done on the browser will be tied back to the host network. Therefore, make sure you know where it is accessible from and control access with firewalls, htpasswd, etc...
