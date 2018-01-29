#!/bin/bash

git clone https://github.com/json-c/json-c.git
git clone git://git.openwrt.org/project/libubox.git
git clone git://git.openwrt.org/project/ubus.git
git clone https://github.com/gvzhang/uhttpd.git
git clone https://github.com/mirrorer/afl.git


yum install cmake
yum install autoconf
yum install automake
yum install libtool
yum install lua-devel
yum install json-devel
yum install json-c-devel
yum install openssl-devel
yum install wget

cd afl
make && make install


cd ../json-c
./autogen.sh --configure
make && make install

cd ../libubox
cmake .
make && make install

cd ../ubus
cmake .
make && make install

cd ../uhttpd
rm -f uhttpd.c
rm -f CMakeLists.txt
wget https://raw.githubusercontent.com/windyware/disfuzz-afl/master/cache/CMakeLists.txt
wget https://raw.githubusercontent.com/windyware/disfuzz-afl/master/cache/uhttpd.c
cmake .
make

mkdir input output
echo "11111111" > ./input/test

export LD_LIBRARY_PATH=/usr/local/lib

afl-fuzz -i input -o output ./uhttpd -f -p 127.0.0.1:8080 -h ./ @@

