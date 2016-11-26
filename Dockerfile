# docker run -p 8022:22 -it mchsk/openwrt-docker-toolchain:chaos_calmer

FROM debian:jessie

# we define the git version (this can be updated later to more latest version and the image can be rebuilt and update if everything succeeds)
ENV CC_COMMIT 1b6dc2e48ce654a004a7d0b98d7070a515424595
ENV N2N_COMMIT be9543f98234264d7cbd31de23302c3b2d262f70


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
RUN git checkout $CC_COMMIT

# OpenWrt feeds
RUN scripts/feeds update -a && scripts/feeds install -a

# Prepare build config (def target ar71xx)
RUN echo "CONFIG_TARGET_ar71xx=y" > .config && make defconfig && make prereq

# OpenWrt toolchain compilation 
RUN make tools/install && make toolchain/install

# Adding n2n
WORKDIR /home/dev/
RUN git clone https://github.com/RomanHargrave/openwrt-n2n
WORKDIR /home/dev/openwrt-n2n
RUN git checkout $N2N_COMMIT

# Copying n2n, freelan into the openwrt directory to build it
WORKDIR /home/dev/

# Getting current openwrt p2p data from my repo
ENV DCKR_COMMIT 794613b09d086fcfd6800df24945baa0c9781bc4
RUN git clone https://github.com/mchsk/openwrt-docker-toolchain && cd openwrt-docker-toolchain %% git checkout $DCKR_COMMIT

# Adding Roman's n2n package
RUN mkdir -p openwrt-docker-toolchain/openwrt/package/network/services/n2n
RUN cp -r openwrt-n2n/* openwrt-docker-toolchain/openwrt/package/network/services/n2n

# Copy over upstream data, remove old data first
RUN rm -rf feeds/packages/multimedia/ffmpeg
RUN rm -rf feeds/packages/multimedia/minidlna
RUN rm -rf feeds/packages/multimedia/mjpg-streamer
RUN rm -rf feeds/packages/multimedia/motion
RUN cp -r openwrt-docker-toolchain/openwrt .

WORKDIR /home/dev/openwrt
# Adding tvheadend
RUN cd package/feeds/packages && ln -s ../../../feeds/packages/multimedia/tvheadend tvheadend
RUN make defconfig

# Packages which rely on OpenSSL fail to build when building separately before the OpenSSL is compiled -> do it :)
RUN make package/openssl/compile && make package/openssl/install

WORKDIR /home/dev/openwrt

# Copy over the custom default config
RUN cp -r ../openwrt-docker-toolchain/custom.config .config


# Back to "root", as a root, we need to start ssh server. I know this is kinda antipatern, but the reason is SFTP. I had hard (and long) time working with Volumes https://github.com/docker/docker/issues/5489. Now the end-user is able to connect with dev acc to the directory and edit files. My grandmother would call this a convenience.
USER root
CMD service ssh start && cd /home/dev && su -s /bin/bash dev && cd openwrt && echo "run 'make menuconfig' to reconfigure :)"




