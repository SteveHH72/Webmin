# Webmin
Webmin Dockerfile with some Tools

This Dockerfile includes some usable Tools linke net-tools, bpytop, mlocate and nano. 

# Description of Webmin

Webmin is a web-based system administration tool for Unix-like servers, and services with about 1,000,000 yearly installations worldwide. Using it, it is possible to configure operating system internals, such as users, disk quotas, services or configuration files, as well as modify, and control open-source apps, such as BIND DNS Server, Apache HTTP Server, PHP, MySQL, and many more.


# Install

To start the Container use 

docker run -it -d -p 10000 digital-world.dev:webmin

Webmin uses Port 10000 - if Port 10000 is in use you have to forward your free port to the port 10000 at the docker container, e.g. 3679:1000
