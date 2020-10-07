# Use the official image as a parent image.
FROM nuntz/telegraf-snmp

LABEL maintainer="Stephan Hochhaus" \
      com.example.version=0.0.1-beta \
      vendor1=yauh \
      com.example.release-date=2020-10-07 \
      com.example.version.is-production=False

RUN export DEBIAN_FRONTEND=noninteractive && export DEBIAN_RELEASE=$(awk -F'[" ]' '/VERSION=/{print $3}' /etc/os-release | tr -cd '[[:alnum:]]._-' ) && echo "remove main from /etc/apt/sources.list" && sed -i '/main/d' /etc/apt/sources.list && echo "remove contrib from /etc/apt/sources.list" && sed -i '/contrib/d' /etc/apt/sources.list && echo "remove non-free from /etc/apt/sources.list" && sed -i '/non-free/d' /etc/apt/sources.list && echo "deb http://httpredir.debian.org/debian ${DEBIAN_RELEASE} main contrib non-free" >> /etc/apt/sources.list && echo "deb http://httpredir.debian.org/debian ${DEBIAN_RELEASE}-updates main contrib non-free" >> /etc/apt/sources.list && echo "deb http://security.debian.org ${DEBIAN_RELEASE}/updates main contrib non-free" >> /etc/apt/sources.list && set -x && apt-get update && apt-get -y install snmp iputils-ping procps snmp-mibs-downloader unzip wget && rm -r /var/lib/apt/lists/*
RUN wget https://global.download.synology.com/download/Document/Software/DeveloperGuide/Firmware/DSM/All/enu/Synology_MIB_File.zip && unzip Synology_MIB_File.zip && mv /Synology_MIB_File/* /usr/share/snmp/mibs/ && rm -rf Synology_MIB_File.zip && rm -rf /Synology_MIB_File && wget https://www.juniper.net/documentation/software/junos/junos174/juniper-mibs-17.4R2.4.zip -O juniper-mibs-17.4R2.4.zip && unzip juniper-mibs-17.4R2.4.zip && mv JuniperMibs/* /usr/share/snmp/mibs/ && download-mibs
