#!/bin/bash
ROOT=$(pwd)

MYSQL_HOST=10.0.0.100
MYSQL_PORT=3306
MYSQL_USER=acore
MYSQL_PASS=acore
MYSQL_DATA_AUTH=acore_auth

CORE_DIRECTORY=/opt/azerothcore

DISTRIBUTION=("ubuntu20.04" "ubuntu20.10")

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VERSION=$VERSION_ID

    if [[ ! " ${DISTRIBUTION[@]} " =~ " ${OS}${VERSION} " ]]; then
        echo -e "\e[0;31mThis distribution is not supported\e[0m"
        exit 1
    fi
fi

clear

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
          "unzip")

for ((i = 0 ; i < ${#PACKAGES[@]} ; i+=1)); do
    sleep 0.1

    if [ $(dpkg-query -W -f='${Status}' ${PACKAGES[i]} 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        INSTALL+=(${PACKAGES[i]})
    fi
done

if [ ${#INSTALL[@]} -gt 0 ]; then
    apt-get -y update
    if [ $? -ne 0 ]; then
        exit 1
    fi

    apt-get -y install ${INSTALL[*]}
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

function INSTALL {
    clear

    if [ -x "$(command -v git)" ]; then
        if [ ! -d $CORE_DIRECTORY ]; then
            git clone --recursive --branch master --depth 1 https://github.com/azerothcore/azerothcore-wotlk.git $CORE_DIRECTORY
            if [ $? -ne 0 ]; then
                exit 1
            fi
        else
            cd $CORE_DIRECTORY

            git fetch --all
            if [ $? -ne 0 ]; then
                exit 1
            fi

            git reset --hard origin/master
            if [ $? -ne 0 ]; then
                exit 1
            fi

            git submodule update
            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi
        if [ -x "$(command -v cmake)" ] && [ -x "$(command -v make)" ]; then
            mkdir -p $CORE_DIRECTORY/build && cd $_

            cmake ../ -DCMAKE_INSTALL_PREFIX=$CORE_DIRECTORY -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DWITH_WARNINGS=1 -DTOOLS=0 -DSCRIPTS=1
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

        echo "#!/bin/bash" > $CORE_DIRECTORY/bin/start.sh
        echo "screen -AmdS auth ./auth.sh" >> $CORE_DIRECTORY/bin/start.sh

        chmod +x $CORE_DIRECTORY/bin/start.sh

        echo "#!/bin/bash" > $CORE_DIRECTORY/bin/shutdown.sh
        echo "screen -X -S \"auth\" quit" >> $CORE_DIRECTORY/bin/shutdown.sh

        chmod +x $CORE_DIRECTORY/bin/shutdown.sh

        echo "#!/bin/sh" > $CORE_DIRECTORY/bin/auth.sh
        echo "while :; do" >> $CORE_DIRECTORY/bin/auth.sh
        echo "./authserver" >> $CORE_DIRECTORY/bin/auth.sh
        echo "sleep 20" >> $CORE_DIRECTORY/bin/auth.sh
        echo "done" >> $CORE_DIRECTORY/bin/auth.sh

        chmod +x $CORE_DIRECTORY/bin/auth.sh
    fi
}

function DATABASE {
    clear

    if [ -x "$(command -v mysql)" ]; then
        echo "[client]" > $ROOT/mysql.cnf
        echo "host=\"$MYSQL_HOST\"" >> $ROOT/mysql.cnf
        echo "port=\"$MYSQL_PORT\"" >> $ROOT/mysql.cnf
        echo "user=\"$MYSQL_USER\"" >> $ROOT/mysql.cnf
        echo "password=\"$MYSQL_PASS\"" >> $ROOT/mysql.cnf
        echo "[mysqldump]" >> $ROOT/mysql.cnf
        echo "column-statistics=0" >> $ROOT/mysql.cnf

        if [ ! -z `mysql --defaults-extra-file=$ROOT/mysql.cnf --skip-column-names -e "SHOW DATABASES LIKE '$MYSQL_DATA_AUTH'"` ]; then
            if [ -d $CORE_DIRECTORY/data/sql/base/db_auth ]; then
                for f in $CORE_DIRECTORY/data/sql/base/db_auth/*.sql; do
                    if [ ! -z `mysql --defaults-extra-file=$ROOT/mysql.cnf --skip-column-names $MYSQL_DATA_AUTH -e "SHOW TABLES LIKE '$(basename $f .sql)'"` ]; then
                        echo -e "\e[0;33mSkipping "$(basename $f)"\e[0m"
                        continue;
                    fi

                    echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                    mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_AUTH < $f
                    if [ $? -ne 0 ]; then
                        exit 1
                    fi

                    if [ $(basename $f .sql) == "account" ] || [ $(basename $f .sql) == "account_access" ]; then
                        mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_AUTH -e "DELETE FROM $(basename $f .sql)"
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi

                        if [ $(basename $f .sql) == "account" ]; then
                            mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_AUTH -e "ALTER TABLE $(basename $f .sql) AUTO_INCREMENT = 1"
                            if [ $? -ne 0 ]; then
                                exit 1
                            fi
                        fi
                    fi
                done

                if [ -d $CORE_DIRECTORY/data/sql/updates/db_auth ]; then
                    for f in $CORE_DIRECTORY/data/sql/updates/db_auth/*.sql; do
                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_AUTH < $f
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi
                    done
                fi

                if [ -d $ROOT/custom ]; then
                    if [ -d $ROOT/custom/auth ]; then
                        for f in $ROOT/custom/auth/*.sql; do
                            echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                            mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_AUTH < $f
                            if [ $? -ne 0 ]; then
                                exit 1
                            fi
                        done
                    fi
                fi
            else
                echo -e "\e[0;31mThe database files are missing\e[0m"
                exit 1
            fi
        else
            echo -e "\e[0;31mCan't connect to the database server\e[0m"

            exit 1
        fi

        rm -rf $ROOT/mysql.cnf
    fi
}

function CONFIGURATION {
    clear

    if [ -f $CORE_DIRECTORY/etc/authserver.conf.dist ]; then
        cp $CORE_DIRECTORY/etc/authserver.conf.dist $CORE_DIRECTORY/etc/authserver.conf
        sed -i 's/LoginDatabaseInfo =.*/LoginDatabaseInfo = "'$MYSQL_HOST';'$MYSQL_PORT';'$MYSQL_USER';'$MYSQL_PASS';'$MYSQL_DATA_AUTH'"/g' $CORE_DIRECTORY/etc/authserver.conf
    else
        echo -e "\e[0;31mThe file authserver.conf.dist is missing\e[0m"
        exit 1
    fi
}

function START {
    clear

    if [ -f $CORE_DIRECTORY/bin/start.sh ] && [ -f $CORE_DIRECTORY/bin/authserver ]; then
        if ! ps -C "auth" > /dev/null; then
            cd $CORE_DIRECTORY/bin && ./start.sh
        fi
    fi
}

function STOP {
    clear

    if [ -f $CORE_DIRECTORY/bin/shutdown.sh ]; then
        cd $CORE_DIRECTORY/bin && ./shutdown.sh
    fi
}

function ALL {
    STOP
    INSTALL
    DATABASE
    CONFIGURATION
    START
}

if [ $# == 1 ]; then
    case $1 in
        "all") ALL;;
        "setup" | "install" | "update") INSTALL;;
        "import" | "database" | "db") DATABASE;;
        "configuration" | "config" | "conf" | "cfg") CONFIGURATION;;
        "start") START;;
        "stop") STOP;;
    esac
fi

