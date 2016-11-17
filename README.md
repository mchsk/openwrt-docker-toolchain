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

```
* Installs all the dependencies needed to crosscompie (https://wiki.openwrt.org/doc/howto/buildroot.exigence)
* Downloads the latest Chaos Calmer sources + feeds
* Builds tools with toolchain (needed to crosscompile to different archs)
```
# 😎 How to build a package

1. From your prompt run the container on top of the image:
	`docker run -it mchsk/openwrt-docker-toolchain:chaos_calmer /bin/bash`

3. The commands to work with the package are:
	
	```
	make package/helloworld/compile		// compiles the sources
	make package/helloworld/install		// creates IPK package
	make package/helloworld/clean		// cleans
	--or--
	make package/feeds/packages/helloworld/compile
	make package/feeds/packages/helloworld/install
	make package/feeds/packages/helloworld/clean
	make package/index					//
	```

https://wiki.openwrt.org/doc/howtobuild/single.package