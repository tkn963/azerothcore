#!/bin/bash
if [[ $OS == "ubuntu" ]]; then
    if [[ $VERSION == "20.04" ]] || [[ $VERSION == "20.10" ]]; then
        PACKAGES=("git" 
                  "cmake" 
                  "make" 
                  "gcc" 
                  "g++" 
                  "clang" 
                  "libmysqlclient-dev" 
                  "libssl-dev" 
                  "libbz2-dev" 
                  "libreadline-dev" 
                  "libncurses-dev" 
                  "libace-6.*" 
                  "libace-dev" 
                  "screen" 
                  "mysql-client" 
                  "libxml2-utils" 
                  "curl" 
                  "unzip"
                  "libxml2-utils")

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
    fi
fi
