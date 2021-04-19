#!/bin/bash

function invalid_arguments()
{
    echo -e "\n\e[0;32mInvalid arguments\e[0m"
    echo -e "\e[0;33mThe supplied arguments are invalid\e[0m"
}

function perform_setup()
{
    clear

    if [ ! -d $CORE_DIRECTORY ]; then
        git clone --recursive --branch $AZEROTHCORE_BRANCH --depth 1 $AZEROTHCORE_URL $CORE_DIRECTORY
        if [ $? -ne 0 ]; then
            exit 1
        fi
    else
        cd $CORE_DIRECTORY

        git fetch --all
        if [ $? -ne 0 ]; then
            exit 1
        fi

        git reset --hard origin/$AZEROTHCORE_BRANCH
        if [ $? -ne 0 ]; then
            exit 1
        fi

        git submodule update
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi

    if [ $MODULE_AHBOT_ENABLED == "true" ]; then
        if [ ! -d $CORE_DIRECTORY/modules/ahbot ]; then
            git clone --recursive --branch $MODULE_AHBOT_BRANCH --depth 1 $MODULE_AHBOT_URL $CORE_DIRECTORY/modules/ahbot
            if [ $? -ne 0 ]; then
                exit 1
            fi
        else
            cd $CORE_DIRECTORY/modules/ahbot

            git fetch --all
            if [ $? -ne 0 ]; then
                exit 1
            fi

            git reset --hard origin/$MODULE_AHBOT_BRANCH
            if [ $? -ne 0 ]; then
                exit 1
            fi

            git submodule update
            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi
    else
        if [ -d $CORE_DIRECTORY/modules/ahbot ]; then
            rm -rf $CORE_DIRECTORY/modules/ahbot

            if [ -d $CORE_DIRECTORY/build ]; then
                rm -rf $CORE_DIRECTORY/build
            fi
        fi
    fi

    if [ $MODULE_SKIP_DK_AREA_ENABLED == "true" ]; then
        if [ ! -d $CORE_DIRECTORY/modules/skipdkarea ]; then
            git clone --recursive --branch $MODULE_SKIPDKAREA_BRANCH --depth 1 $MODULE_SKIPDKAREA_URL $CORE_DIRECTORY/modules/skipdkarea
            if [ $? -ne 0 ]; then
                exit 1
            fi
        else
            cd $CORE_DIRECTORY/modules/skipdkarea

            git fetch --all
            if [ $? -ne 0 ]; then
                exit 1
            fi

            git reset --hard origin/$MODULE_SKIPDKAREA_BRANCH
            if [ $? -ne 0 ]; then
                exit 1
            fi

            git submodule update
            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi
    else
        if [ -d $CORE_DIRECTORY/modules/skipdkarea ]; then
            rm -rf $CORE_DIRECTORY/modules/skipdkarea

            if [ -d $CORE_DIRECTORY/build ]; then
                rm -rf $CORE_DIRECTORY/build
            fi
        fi
    fi

    if [ $MODULE_KICKSTARTER_ENABLED == "true" ]; then
        if [ ! -d $CORE_DIRECTORY/modules/kickstarter ]; then
            git clone --recursive --branch $MODULE_KICKSTARTER_BRANCH --depth 1 $MODULE_KICKSTARTER_URL $CORE_DIRECTORY/modules/kickstarter
            if [ $? -ne 0 ]; then
                exit 1
            fi
        else
            cd $CORE_DIRECTORY/modules/kickstarter

            git fetch --all
            if [ $? -ne 0 ]; then
                exit 1
            fi

            git reset --hard origin/$MODULE_KICKSTARTER_BRANCH
            if [ $? -ne 0 ]; then
                exit 1
            fi

            git submodule update
            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi
    else
        if [ -d $CORE_DIRECTORY/modules/kickstarter ]; then
            rm -rf $CORE_DIRECTORY/modules/kickstarter

            if [ -d $CORE_DIRECTORY/build ]; then
                rm -rf $CORE_DIRECTORY/build
            fi
        fi
    fi

    if [ $MODULE_EXPERIENCED_ENABLED == "true" ]; then
        if [ ! -d $CORE_DIRECTORY/modules/experienced ]; then
            git clone --recursive --branch $MODULE_EXPERIENCED_BRANCH --depth 1 $MODULE_EXPERIENCED_URL $CORE_DIRECTORY/modules/experienced
            if [ $? -ne 0 ]; then
                exit 1
            fi
        else
            cd $CORE_DIRECTORY/modules/experienced

            git fetch --all
            if [ $? -ne 0 ]; then
                exit 1
            fi

            git reset --hard origin/$MODULE_EXPERIENCED_BRANCH
            if [ $? -ne 0 ]; then
                exit 1
            fi

            git submodule update
            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi
    else
        if [ -d $CORE_DIRECTORY/modules/experienced ]; then
            rm -rf $CORE_DIRECTORY/modules/experienced

            if [ -d $CORE_DIRECTORY/build ]; then
                rm -rf $CORE_DIRECTORY/build
            fi
        fi
    fi

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

    echo "#!/bin/bash" > $CORE_DIRECTORY/bin/start.sh
    if [[ $1 == "auth" ]] || [[ $1 == "all" ]]; then
        echo "screen -AmdS auth ./auth.sh" >> $CORE_DIRECTORY/bin/start.sh
    fi
    if [[ $1 == "world" ]] || [[ $1 == "all" ]]; then
        echo "screen -AmdS world ./world.sh" >> $CORE_DIRECTORY/bin/start.sh
    fi

    chmod +x $CORE_DIRECTORY/bin/start.sh

    echo "#!/bin/bash" > $CORE_DIRECTORY/bin/shutdown.sh
    if [[ $1 == "auth" ]] || [[ $1 == "all" ]]; then
        echo "screen -X -S \"auth\" quit" >> $CORE_DIRECTORY/bin/shutdown.sh
    fi
    if [[ $1 == "world" ]] || [[ $1 == "all" ]]; then
        echo "screen -X -S \"world\" quit" >> $CORE_DIRECTORY/bin/shutdown.sh
    fi

    chmod +x $CORE_DIRECTORY/bin/shutdown.sh

    if [[ $1 == "auth" ]] || [[ $1 == "all" ]]; then
        echo "#!/bin/sh" > $CORE_DIRECTORY/bin/auth.sh
        echo "while :; do" >> $CORE_DIRECTORY/bin/auth.sh
        echo "./authserver" >> $CORE_DIRECTORY/bin/auth.sh
        echo "sleep 20" >> $CORE_DIRECTORY/bin/auth.sh
        echo "done" >> $CORE_DIRECTORY/bin/auth.sh

        chmod +x $CORE_DIRECTORY/bin/auth.sh
    else
        if [ -f $CORE_DIRECTORY/bin/auth.sh ]; then
            rm -rf $CORE_DIRECTORY/bin/auth.sh
        fi
    fi

    if [[ $1 == "world" ]] || [[ $1 == "all" ]]; then
        echo "#!/bin/sh" > $CORE_DIRECTORY/bin/world.sh
        echo "while :; do" >> $CORE_DIRECTORY/bin/world.sh
        echo "./worldserver" >> $CORE_DIRECTORY/bin/world.sh
        echo "sleep 20" >> $CORE_DIRECTORY/bin/world.sh
        echo "done" >> $CORE_DIRECTORY/bin/world.sh

        chmod +x $CORE_DIRECTORY/bin/world.sh
    else
        if [ -f $CORE_DIRECTORY/bin/world.sh ]; then
            rm -rf $CORE_DIRECTORY/bin/world.sh
        fi
    fi

    if [[ $1 == "world" ]] || [[ $1 == "all" ]]; then
        if [ ! -d $CORE_DIRECTORY/bin/Cameras ] || [ ! -d $CORE_DIRECTORY/bin/dbc ] || [ ! -d $CORE_DIRECTORY/bin/maps ] || [ ! -d $CORE_DIRECTORY/bin/mmaps ] || [ ! -d $CORE_DIRECTORY/bin/vmaps ]; then
            curl -L $CLIENT_DATA > $CORE_DIRECTORY/bin/data.zip
            if [ $? -ne 0 ]; then
                exit 1
            fi

            unzip -o "$CORE_DIRECTORY/bin/data.zip" -d "$CORE_DIRECTORY/bin/"
            if [ $? -ne 0 ]; then
                exit 1
            fi

            rm -rf $CORE_DIRECTORY/bin/data.zip
            if [ $? -ne 0 ]; then
                exit 1
            fi
        fi
    fi
}

function import_database()
{
    clear

    echo "[client]" > $MYSQL_CONFIG
    echo "host=\"$MYSQL_HOSTNAME\"" >> $MYSQL_CONFIG
    echo "port=\"$MYSQL_PORT\"" >> $MYSQL_CONFIG
    echo "user=\"$MYSQL_USERNAME\"" >> $MYSQL_CONFIG
    echo "password=\"$MYSQL_PASSWORD\"" >> $MYSQL_CONFIG
    echo "[mysqldump]" >> $MYSQL_CONFIG
    echo "column-statistics=0" >> $MYSQL_CONFIG

    if [[ $1 == "auth" ]] || [[ $1 == "all" ]]; then
        if [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names -e "SHOW DATABASES LIKE '$MYSQL_DATABASE_AUTH'"` ]; then
            if [ -d $CORE_DIRECTORY/data/sql/base/db_auth ]; then
                for f in $CORE_DIRECTORY/data/sql/base/db_auth/*.sql; do
                    if [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names $MYSQL_DATABASE_AUTH -e "SHOW TABLES LIKE '$(basename $f .sql)'"` ]; then
                        echo -e "\e[0;33mSkipping "$(basename $f)"\e[0m"
                        continue;
                    fi

                    echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                    mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_AUTH < $f
                    if [ $? -ne 0 ]; then
                        exit 1
                    fi

                    if [ $(basename $f .sql) == "account" ] || [ $(basename $f .sql) == "account_access" ]; then
                        mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_AUTH -e "DELETE FROM $(basename $f .sql)"
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi

                        if [ $(basename $f .sql) == "account" ]; then
                            mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_AUTH -e "ALTER TABLE $(basename $f .sql) AUTO_INCREMENT = 1"
                            if [ $? -ne 0 ]; then
                                exit 1
                            fi
                        fi
                    fi
                done

                if [ -d $CORE_DIRECTORY/data/sql/updates/db_auth ]; then
                    for f in $CORE_DIRECTORY/data/sql/updates/db_auth/*.sql; do
                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_AUTH < $f
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi
                    done
                fi

                if [ -d $ROOT/custom ]; then
                    if [ -d $ROOT/custom/auth ]; then
                        for f in $ROOT/custom/auth/*.sql; do
                            echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                            mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_AUTH < $f
                            if [ $? -ne 0 ]; then
                                exit 1
                            fi
                        done
                    fi
                fi
            fi
        else
            rm -rf $MYSQL_CONFIG
            exit 1
        fi
    fi

    if [[ $1 == "world" ]] || [[ $1 == "all" ]]; then
        if [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names -e "SHOW DATABASES LIKE '$MYSQL_DATABASE_AUTH'"` ] && [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names -e "SHOW DATABASES LIKE '$MYSQL_DATABASE_CHARACTERS'"` ] && [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names -e "SHOW DATABASES LIKE '$MYSQL_DATABASE_WORLD'"` ]; then
            if [ -d $CORE_DIRECTORY/data/sql/base/db_characters ] && [ -d $CORE_DIRECTORY/data/sql/base/db_world ]; then
                for f in $CORE_DIRECTORY/data/sql/base/db_characters/*.sql; do
                    if [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names $MYSQL_DATABASE_CHARACTERS -e "SHOW TABLES LIKE '$(basename $f .sql)'"` ]; then
                        echo -e "\e[0;33mSkipping "$(basename $f)"\e[0m"
                        continue;
                    fi

                    echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                    mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_CHARACTERS < $f
                    if [ $? -ne 0 ]; then
                        exit 1
                    fi
                done

                for f in $CORE_DIRECTORY/data/sql/base/db_world/*.sql; do
                    if [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names $MYSQL_DATABASE_WORLD -e "SHOW TABLES LIKE '$(basename $f .sql)'"` ]; then
                        echo -e "\e[0;33mSkipping "$(basename $f)"\e[0m"
                        continue;
                    fi

                    echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                    mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_WORLD < $f
                    if [ $? -ne 0 ]; then
                        exit 1
                    fi
                done

                if [ -d $CORE_DIRECTORY/data/sql/updates/db_characters ]; then
                    for f in $CORE_DIRECTORY/data/sql/updates/db_characters/*.sql; do
                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_CHARACTERS < $f
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi
                    done
                fi

                if [ -d $CORE_DIRECTORY/data/sql/updates/db_world ]; then
                    for f in $CORE_DIRECTORY/data/sql/updates/db_world/*.sql; do
                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_WORLD < $f
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi
                    done
                fi

                if  [ -d $CORE_DIRECTORY/modules/ahbot/sql/world/base ]; then
                    for f in $CORE_DIRECTORY/modules/ahbot/sql/world/base/*.sql; do
                        if [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names $MYSQL_DATABASE_WORLD -e "SHOW TABLES LIKE '$(basename $f .sql)'"` ]; then
                            echo -e "\e[0;33mSkipping "$(basename $f)"\e[0m"
                            continue;
                        fi

                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_WORLD < $f
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi
                    done
                fi

                if  [ -d $CORE_DIRECTORY/modules/kickstarter/sql/world/base ]; then
                    for f in $CORE_DIRECTORY/modules/kickstarter/sql/world/base/*.sql; do
                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_WORLD < $f
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi
                    done
                fi

                if [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names $MYSQL_DATABASE_WORLD -e "SHOW TABLES LIKE 'mod_auctionhousebot'"` ]; then
                    mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_WORLD -e "UPDATE mod_auctionhousebot SET minitems='$MODULE_AHBOT_MIN_ITEMS', maxitems='$MODULE_AHBOT_MAX_ITEMS'"
                fi

                mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_AUTH -e "DELETE FROM realmlist WHERE id='$WORLD_ID';INSERT INTO realmlist (id, name, address, localAddress, localSubnetMask, port) VALUES ('$WORLD_ID', '$WORLD_NAME', '$WORLD_IP', '$WORLD_IP', '255.255.255.0', '8085')"
                if [ $? -ne 0 ]; then
                    exit 1
                fi
            fi
        else
            rm -rf $MYSQL_CONFIG
            exit 1
        fi
    fi

    rm -rf $MYSQL_CONFIG
}
