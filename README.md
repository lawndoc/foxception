# Foxception

## Browser in a browser

This docker container runs a web server that opens up a Firefox instance in your browser when you navigate to it. It runs xRDP over Apache Guacamole that is locked into a Firefox window.

This project was inspired by [this blog post](http://ivo2u.nl/Yo). I've extended IvoNet's already awesome creation by switching the browser to Firefox and figuring out how to sideload extensions so that they are already baked into the browser when you build the image.

## Choosing extensions

To pick your own default extensions, you need to add the xpi archive to the directory /usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/

The archive must be named &lt;app id>.xpi where &lt;app id> is the application id of the add-on. For example, {ec8030f7-c20a-464f-9b0e-13a3a9e97384} is the app id of Firefox, and is the name of the directory that you should add the xpi archives to. You can get the url of the xpi archive for your extension by going to the Firefox add-ons website and hovering over or right-clicking the "Add to Firefox" button.

## IMPORTANT NOTE:

Depending on your setup, this browser may be exposed to the internet. Since it is running on your network, anything that is done on the browser will be tied back to the host network. Therefore, make sure you know where it is accessible from and control access with firewalls, htpasswd, etc...
