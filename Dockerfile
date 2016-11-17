# docker run -p 8022:22 -it mchsk/openwrt-docker-toolchain:chaos_calmer

FROM debian:jessie

MAINTAINER Marek Sedlak <bodka.zavinac@gmail.com>

# System update
RUN apt-get update && apt-get -y upgrade

# Prerequisites needed to play with OpenWrt (ref: https://wiki.openwrt.org/doc/howto/buildroot.exigence). Haven't checked the packages one by one,... this command is responsible for huge increase in size. Sorry :-)
RUN apt-get -y install sudo asciidoc bash bc binutils bzip2 fastjar flex git-core gcc util-linux gawk libgtk2.0-dev intltool jikespg zlib1g-dev  make genisoimage libncurses5-dev libssl-dev patch perl-modules rsync ruby sdcc unzip wget gettext xsltproc zlib1g-dev libboost1.55-dev libxml-parser-perl libusb-dev bin86 bcc sharutils perl-modules python2.7-dev git git-core build-essential libssl-dev libncurses5-dev unzip gawk subversion mercurial openjdk-7-jdk openssh-sftp-server
# openjdk-8-jdk available via jessie-backports

# Creating dev:dev user with sudo priviledges
RUN useradd -m dev && echo "dev:dev" | chpasswd && adduser dev sudo
USER dev
WORKDIR /home/dev

# OpenWrt CC sources
RUN git clone -b chaos_calmer git://github.com/openwrt/openwrt.git
WORKDIR /home/dev/openwrt

# OpenWrt feeds
RUN scripts/feeds update -a && scripts/feeds install -a

# Prepare build config (def target ar71xx)
RUN echo "CONFIG_TARGET_ar71xx=y" > .config && make defconfig && make prereq

# OpenWrt toolchain compilation 
RUN make tools/install && make toolchain/install

# Back to "root", as a root, we need to start ssh server. I know this is kinda antipatern, but the reason is SFTP. I had hard (and long) time working with Volumes https://github.com/docker/docker/issues/5489. Now the end-user is able to connect with dev acc to the directory and edit files. My grandmother would call this a convenience.
USER root
CMD service ssh start && cd /home/dev && su -s /bin/bash dev

