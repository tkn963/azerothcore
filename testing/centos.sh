#!/bin/bash
ROOT=$(pwd)
CORE_DIRECTORY=/opt/azerothcore

if [ $(yum list installed epel-release 2>/dev/null | wc -l) -eq 0 ]; then
    yum install -y epel-release
fi

# Missing packages: libace-6.* libace-dev
PACKAGES=("git"
          "make"
          "gcc"
          "gcc-c++"
          "clang"
          "mysql-devel"
          "mysql"
          "perl"
          "perl-libs"
          "openssl-devel"
          "compat-openssl10"
          "bzip2-devel"
          "readline-devel"
          "ncurses-devel"
          "screen"
          "curl"
          "tar"
          "unzip")

for p in "${PACKAGES[@]}"; do
    if [ $(yum list installed $p 2>/dev/null | wc -l) -eq 0 ]; then
        INSTALL+=($p)
    fi
done

if [ ${#INSTALL[@]} -gt 0 ]; then
    yum install -y ${INSTALL[*]}
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

if ! command -v cmake &> /dev/null; then
    if [[ ! -f $ROOT/cmake-3.16.3.tar.gz ]]; then
        curl -L https://github.com/Kitware/CMake/releases/download/v3.16.3/cmake-3.16.3.tar.gz > $ROOT/cmake-3.16.3.tar.gz
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi

    tar -zxvf $ROOT/cmake-3.16.3.tar.gz
    if [ $? -ne 0 ]; then
        exit 1
    fi

    cd $ROOT/cmake-3.16.3

    ./bootstrap
    if [ $? -ne 0 ]; then
        exit 1
    fi

    make -j $(nproc)
    if [ $? -ne 0 ]; then
        exit 1
    fi

    make install
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

if [ $(yum list installed mpc 2>/dev/null | wc -l) -eq 0 ]; then
    rpm -Uv ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/devel:/libraries:/ACE:/micro/CentOS_7/x86_64/mpc-6.5.4-75.1.x86_64.rpm
    if [ $? -ne 0 ]; then
        exit 1
    fi

    yum install -y mpc
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

if [ $(yum list installed perl-Net-Telnet 2>/dev/null | wc -l) -eq 0 ]; then
    rpm -Uv ftp://ftp.pbone.net/mirror/rnd.rajven.net/centos/8.1.1911/os/x86_64/perl-Net-Telnet-3.04-1cnt8.noarch.rpm
    if [ $? -ne 0 ]; then
        exit 1
    fi

    yum install -y perl-Net-Telnet
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

if [ $(yum list installed ace 2>/dev/null | wc -l) -eq 0 ]; then
    rpm -Uv ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/devel:/libraries:/ACE:/micro/CentOS_7/x86_64/ace-6.5.4-75.1.x86_64.rpm
    if [ $? -ne 0 ]; then
        exit 1
    fi

    yum install -y ace
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

if [ $(yum list installed ace-devel 2>/dev/null | wc -l) -eq 0 ]; then
    rpm -Uv ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/devel:/libraries:/ACE:/micro/CentOS_7/x86_64/ace-devel-6.5.4-75.1.x86_64.rpm
    if [ $? -ne 0 ]; then
        exit 1
    fi

    yum install -y ace-devel
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi
