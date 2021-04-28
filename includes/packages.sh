#!/bin/bash
if [[ $OS == "centos" ]]; then
    if [ $(yum list installed libxml2 2>/dev/null | wc -l) -eq 0 ]; then
        yum install -y libxml2
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi
elif [[ $OS == "debian" ]] || [[ $OS == "ubuntu" ]]; then
    if [ $(dpkg-query -W -f='${Status}' libxml2-utils 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        apt-get update -y
        if [ $? -ne 0 ]; then
            exit 1
        fi

        apt-get install -y libxml2-utils
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi
fi

function install_build_packages()
{
    if [[ $OS == "centos" ]]; then
        if [ $(yum list installed epel-release 2>/dev/null | wc -l) -eq 0 ]; then
            yum install -y epel-release
            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi
    fi

    PACKAGES=("git" "make" "gcc" "clang" "screen" "curl" "unzip")

    if [[ $OS == "debian" ]] || [[ $OS == "ubuntu" ]]; then
        PACKAGES+=("g++" "libssl-dev" "libbz2-dev" "libreadline-dev" "libncurses-dev" "libace-6.*" "libace-dev")
    fi

    if [[ $OS == "centos" ]]; then
        PACKAGES+=("gcc-c++" "mysql" "mysql-devel" "perl" "perl-libs" "openssl-devel" "compat-openssl10" "bzip2-devel" "readline-devel" "ncurses-devel" "tar")
    elif [[ $OS == "ubuntu" ]]; then
        PACKAGES+=("cmake" "libmysqlclient-dev" "mysql-client")
    elif [[ $OS == "debian" ]]; then
        if [ $(dpkg-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
            PACKAGES+=("libmysqlclient-dev" "mysql-client" "zlib1g-dev")
        else
            PACKAGES+=("default-libmysqlclient-dev" "default-mysql-client")
        fi
    fi

    for p in "${PACKAGES[@]}"; do
        if [[ $OS == "centos" ]]; then
            if [ $(yum list installed $p 2>/dev/null | wc -l) -eq 0 ]; then
                INSTALL+=($p)
            fi
        elif [[ $OS == "debian" ]] || [[ $OS == "ubuntu" ]]; then
            if [ $(dpkg-query -W -f='${Status}' $p 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
                INSTALL+=($p)
            fi
        fi
    done

    if [ ${#INSTALL[@]} -gt 0 ]; then
        if [[ $OS == "centos" ]]; then
            yum install -y ${INSTALL[*]}
            if [ $? -ne 0 ]; then
                exit 1
            fi
        elif [[ $OS == "debian" ]] || [[ $OS == "ubuntu" ]]; then
            apt-get update -y
            if [ $? -ne 0 ]; then
                exit 1
            fi

            apt-get install -y ${INSTALL[*]}
            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi
    fi

    if [[ $OS == "centos" ]] || [[ $OS == "debian" ]]; then
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
    fi

    if [[ $OS == "centos" ]]; then
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
            rpm -Uv http://download.opensuse.org/repositories/devel:/libraries:/ACE:/micro/CentOS_8/x86_64/ace-7.0.1-86.4.x86_64.rpm
            if [ $? -ne 0 ]; then
                exit 1
            fi

            yum install -y ace
            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi

        if [ $(yum list installed ace-devel 2>/dev/null | wc -l) -eq 0 ]; then
            rpm -Uv http://download.opensuse.org/repositories/devel:/libraries:/ACE:/micro/CentOS_8/x86_64/ace-devel-7.0.1-86.4.x86_64.rpm
            if [ $? -ne 0 ]; then
                exit 1
            fi

            yum install -y ace-devel
            if [ $? -ne 0 ]; then
                exit 1
            fi
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

    if [[ $OS == "centos" ]]; then
        if [ $(yum list installed mysql-client 2>/dev/null | wc -l) -eq 0 ]; then
            yum install -y mysql-client
            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi
    elif [[ $OS == "debian" ]] || [[ $OS == "ubuntu" ]]; then
        if [ $(dpkg-query -W -f='${Status}' $PACKAGE 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
            apt-get update -y
            if [ $? -ne 0 ]; then
                exit 1
            fi

            apt-get install -y $PACKAGE
            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi
    fi
}
