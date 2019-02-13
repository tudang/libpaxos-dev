#!/bin/bash -e

LIBDIR=$HOME/libraries
mkdir -p $LIBDIR

if [ -f /etc/debian_version ]; then
    OS="Debian"
    VER=$(cat /etc/debian_version)
    sudo apt-get update && sudo apt-get install -y build-essential git cmake libevent-dev
elif [ -f /etc/redhat-release ]; then
    OS="Red Hat"
    VER=$(cat /etc/redhat-release)
    sudo yum install -y libevent libevent-devel
fi

cd $LIBDIR && git clone https://github.com/msgpack/msgpack-c.git msgpack
cd msgpack
git checkout -b 1.4.1 cpp-1.4.1
mkdir -p build
cd build
cmake ..
make
sudo make install
sudo ldconfig
