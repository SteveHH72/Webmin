#Webmin Docker Ímage
#Created by SteveHH 05/2023
#visit our Discord-Servers:
#https://discord.gg/SE46FDsC  =>> Pentesting & White-Hat-Hacking
#https://discord.gg/9FsgTsSQ  =>> Linux Germany
#
#Use our Synapse/Matrix Server: matrix.digital-world.dev


# Use the latest Ubuntu image as a parent
FROM debian:12-slim
LABEL key="value" "SteveHH" <steve@digital-world.dev>

ENV DEBIAN_FRONTEND=noninteractive TZ=Europe/Berlin

# Initial updates and install core utilities
RUN apt update -qq -y && \
    apt upgrade -y && \
    apt install -y \
       wget \
       curl \
       apt-transport-https \
       lsb-release \
       ca-certificates \
       gnupg2 \
       software-properties-common \
       locales \
       cron \
       nano \
       net-tools \
       bpytop \
       mlocate
    
RUN dpkg-reconfigure locales

# Install Webmin
RUN echo root:password | chpasswd && \
    echo "Acquire::GzipIndexes \"false\"; Acquire::CompressionTypes::Order:: \"gz\";" >/etc/apt/apt.conf.d/docker-gzip-indexes && \
    update-locale LANG=C.UTF-8 && \
    echo deb https://download.webmin.com/download/repository sarge contrib >> /etc/apt/sources.list && \
    wget http://www.webmin.com/jcameron-key.asc && \
    apt-key add jcameron-key.asc && \
    apt-get update && \
    apt-get install -y webmin && \
    apt-get clean

# Bind Port
EXPOSE 10000


ENV LC_ALL C.UTF-8

# Shell in Container
WORKDIR /home
RUN echo "#! /bin/bash" > entrypoint.sh && \
    echo "sed -i 's;ssl=1;ssl=0;' /etc/webmin/miniserv.conf && systemctl enable cron && service webmin start && tail -f /dev/null" >> entrypoint.sh && \
    chmod 755 entrypoint.sh

CMD /home/entrypoint.sh
