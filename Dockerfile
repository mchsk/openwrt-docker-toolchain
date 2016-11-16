FROM debian:jessie
CMD /bin/bash

# prepare apt with czech repo 
RUN echo "deb http://debian.ignum.cz/debian jessie-updates main\ndeb http://debian.ignum.cz/debian/ jessie main\ndeb-src http://debian.ignum.cz/debian/ jessie main\ndeb http://security.debian.org/ jessie/updates main\n deb-src http://security.debian.org/ jessie/updates main" > /etc/apt/sources.list
RUN apt-get update && apt-get -y upgrade && apt-get -y install apt-utils

# install prereq for openwrt buildsystem
RUN apt-get -y install asciidoc bash bc binutils bzip2 fastjar flex git-core gcc util-linux gawk libgtk2.0-dev intltool jikespg zlib1g-dev  make genisoimage libncurses5-dev libssl-dev patch perl-modules rsync ruby sdcc unzip wget gettext xsltproc zlib1g-dev libboost1.55-dev libxml-parser-perl libusb-dev bin86 bcc sharutils perl-modules python2.7-dev git git-core build-essential libssl-dev libncurses5-dev unzip gawk subversion mercurial openjdk-7-jdk

# adding docker user
#RUN useradd -m docker && echo "docker:docker" | chpasswd
#USER docker

RUN git clone -b chaos_calmer git://github.com/openwrt/openwrt.git
RUN cd openwrt && scripts/feeds update -a && scripts/feeds install -a
RUN cd openwrt && make prereq
RUN cd openwrt && make defconfig && make tools/install && make toolchain/install



