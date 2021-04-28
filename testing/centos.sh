#!/bin/bash
ROOT=$(pwd)

if [ $(yum list installed epel-release 2>/dev/null | wc -l) -eq 0 ]; then
    dnf install --yes epel-release
fi

# Missing packages: libace-6.* libace-dev
PACKAGES=("git"
          "make"
          "gcc"
          "gcc-c++"
          "clang"
          "mysql-devel"
          "mysql"
          "openssl-devel"
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
    dnf --yes install ${INSTALL[*]}
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
