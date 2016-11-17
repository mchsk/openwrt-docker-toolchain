# openwrt-docker-toolchain

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

The purpose of this docker image is to provide  environment for creating IPK packages which are used in OpenWrt package management system. Similarly, DEB packages are used in Debian-based operating systems.

#### Quick platforms refs (in case someone needs rough platform overview):

[Docker](http://www.docker.com) is an open platform for developers and sysadmins to build, ship, and run distributed applications, whether on laptops, data center VMs, or the cloud.

[OpenWrt](https://openwrt.org) is a GNU/Linux based firmware program for embedded devices such as residential gateways and routers.

[OPKG](http://git.yoctoproject.org/cgit/cgit.cgi/opkg/) is a lightweight package management system.

#### Docker image built on top of:
[Debian Jessie](https://www.debian.org/releases/jessie/) -- source Docker image, a linux platform, marked **stable** as of now (end of 2016).

[OpenWrt Chaos Calmer](https://forum.openwrt.org/viewtopic.php?id=63415) -- a codebase of the **stable** OpenWrt release.

### What is the image dealing with for you?


* Installs all the dependencies needed to crosscompie (https://wiki.openwrt.org/doc/howto/buildroot.exigence)
* Downloads the latest Chaos Calmer sources + feeds
* Builds tools with toolchain (needed to crosscompile to different archs)

# 😎 How to build an OpenWrt package

* ###Create your docker container:

	`docker run -p 8022:22 -it mchsk/openwrt-docker-toolchain:chaos_calmer`
	
	**You can change *8022* to any other port you would like to be able to connect to with a SFTP Client. If it is convenient to use files in GUI, use it. In terms of using the Docker this is an antipatern though! But yeah, it was rly painful to use Volumes on mac.**
	
	SFTP credentials: username: `dev` password `dev`.

	
	Ok, so once you run the `docker run ...^` command, you will end up being in the `/home/dev` directory, logged in as `dev` user. Use `dev` password when using sudo. When you `ls`, you will notice an `openwrt` directory. These are Chaos Calmer sources, with built toolchain and with updated all the feeds. Basically, these steps were executed:
	
	`sudo apt-get update/upgrade/install -y %all_the_packages%`
	
	`git clone -b chaos_calmer git://github.com/openwrt/openwrt.git`
	
	`cd openwrt`
	
	`scripts/feeds update -a`
	
	`scripts/feeds install -a`
	
	`(selecting target ar71xx)`
	
	`make defconfig`

	`make prereq`
	
	`make tools/install`
	
	`make toolchain/install`
	
	`cd ~`
	
* ###Prepare package, dependencies, eventually patches and create the Makefile:
	I was considering to write my own guide, but I believe that is not necessary, just head over to the original sources from OpenWrt community:
	*	[https://wiki.openwrt.org/doc/howtobuild/single.package](https://wiki.openwrt.org/doc/howtobuild/single.package)
	*	[https://forum.openwrt.org/viewtopic.php?id=44846](https://forum.openwrt.org/viewtopic.php?id=44846)
	

# Build & Profit.
☺ Pull requests are welcome.
