#!/bin/bash
if [[ $OS == "ubuntu" ]] || [[ $OS == "debian" ]]; then
    if [ $(dpkg-query -W -f='${Status}' libxml2-utils 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        apt-get --yes update
        if [ $? -ne 0 ]; then
            exit 1
        fi

        apt-get --yes install libxml2-utils
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi
fi

function install_build_packages()
{
    PACKAGES=("git" 
              "make" 
              "gcc" 
              "g++" 
              "clang" 
              "libssl-dev" 
              "libbz2-dev" 
              "libreadline-dev" 
              "libncurses-dev" 
              "libace-6.*" 
              "libace-dev" 
              "screen" 
              "wget" 
              "unzip")

    if [[ $OS == "ubuntu" ]]; then
        PACKAGES+=("cmake" "libmysqlclient-dev" "mysql-client")
    elif [[ $OS == "debian" ]]; then
        if [ $(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
            PACKAGES+=("libmysqlclient-dev" "mysql-client" "zlib1g-dev")
        else
            PACKAGES+=("default-libmysqlclient-dev" "default-mysql-client")
        fi
    fi

    for p in "${PACKAGES[@]}"; do
        if [ $(dpkg-query -W -f='${Status}' $p 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
            INSTALL+=($p)
        fi
    done

    if [ ${#INSTALL[@]} -gt 0 ]; then
        apt-get --yes update
        if [ $? -ne 0 ]; then
            exit 1
        fi

        apt-get --yes install ${INSTALL[*]}
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi

    if [[ $OS == "debian" ]]; then
        if ! command -v cmake &> /dev/null; then
            if [[ ! -f cmake-3.16.3.tar.gz ]]; then
                wget https://github.com/Kitware/CMake/releases/download/v3.16.3/cmake-3.16.3.tar.gz $ROOT/cmake-3.16.3.tar.gz
                if [ $? -ne 0 ]; then
                    exit 1
                fi
            fi

            tar -zxvf $ROOT/cmake-3.16.3.tar.gz
            if [ $? -ne 0 ]; then
                exit 1
            fi

            rm -rf $ROOT/cmake-3.16.3.tar.gz
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

            rm -rf $ROOT/cmake-3.16.3
        fi
    fi
}

function install_database_packages()
{
    if [[ $OS == "ubuntu" ]]; then
        PACKAGE="mysql-client"
    elif [[ $OS == "debian" ]]; then
        if [ $(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
            PACKAGE="mysql-client"
        else
            PACKAGE="default-mysql-client"
        fi
    fi

    if [ $(dpkg-query -W -f='${Status}' $PACKAGE 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        apt-get --yes update
        if [ $? -ne 0 ]; then
            exit 1
        fi

        apt-get --yes install $PACKAGE
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi
}
