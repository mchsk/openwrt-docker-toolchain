#!/bin/bash

# this is so ugly that i had to leave it here:

cd ../openwrt
sed -i.bak s/CONFIG_boost-libs-all=y/# CONFIG_boost-libs-all is not set/g .config
sed -i.bak s/CONFIG_boost-test-pkg=y/# CONFIG_boost-test-pkg is not set/g .config
sed -i.bak s/CONFIG_boost-graph-parallel=y/# CONFIG_boost-graph-parallel is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-container=m/# CONFIG_PACKAGE_boost-container is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-context=m/# CONFIG_PACKAGE_boost-context is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-coroutine=m/# CONFIG_PACKAGE_boost-coroutine is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-fiber=m/# CONFIG_PACKAGE_boost-fiber is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-graph=m/# CONFIG_PACKAGE_boost-graph is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-log=m/# CONFIG_PACKAGE_boost-log is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-math=m/# CONFIG_PACKAGE_boost-math is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-python=m/# CONFIG_PACKAGE_boost-python is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-python3=m/# CONFIG_PACKAGE_boost-python3 is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-random=m/# CONFIG_PACKAGE_boost-random is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-regex=m/# CONFIG_PACKAGE_boost-regex is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-serialization=m/# CONFIG_PACKAGE_boost-serialization is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-signals=m/# CONFIG_PACKAGE_boost-signals is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-timer=m/# CONFIG_PACKAGE_boost-timer is not set/g .config
sed -i.bak s/CONFIG_PACKAGE_boost-wave=m/# CONFIG_PACKAGE_boost-wave is not set/g .config
sed -i.bak /CONFIG_boost-coroutine2=y/d .config
sed -i.bak /CONFIG_PACKAGE_boost-libs=m/d .config
sed -i.bak /CONFIG_PACKAGE_boost-test=m/d .config
