#!/bin/bash

function invalid_arguments()
{
    echo -e "\n\e[0;32mInvalid arguments\e[0m"
    echo -e "\e[0;33mThe supplied arguments are invalid\e[0m"
}

function perform_setup()
{
    clear

    echo -e "\e[0;32mDownloading source code\e[0m"

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

    if [[ $1 == "world" ]] || [[ $1 == "all" ]]; then
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
    fi

    echo -e "\e[0;32mCompiling source code\e[0m"

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

    echo -e "\e[0;32mCreating scripts\e[0m"

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
            echo -e "\n\e[0;32mDownloading data files\e[0m"

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

    echo -e "\e[0;32mImporting database files\e[0m"

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
                        rm -rf $MYSQL_CONFIG
                        exit 1
                    fi

                    if [ $(basename $f .sql) == "account" ] || [ $(basename $f .sql) == "account_access" ]; then
                        mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_AUTH -e "DELETE FROM $(basename $f .sql)"
                        if [ $? -ne 0 ]; then
                            rm -rf $MYSQL_CONFIG
                            exit 1
                        fi

                        if [ $(basename $f .sql) == "account" ]; then
                            mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_AUTH -e "ALTER TABLE $(basename $f .sql) AUTO_INCREMENT = 1"
                            if [ $? -ne 0 ]; then
                                rm -rf $MYSQL_CONFIG
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
                            rm -rf $MYSQL_CONFIG
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
                                rm -rf $MYSQL_CONFIG
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
                        rm -rf $MYSQL_CONFIG
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
                        rm -rf $MYSQL_CONFIG
                        exit 1
                    fi
                done

                if [ -d $CORE_DIRECTORY/data/sql/updates/db_characters ]; then
                    for f in $CORE_DIRECTORY/data/sql/updates/db_characters/*.sql; do
                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_CHARACTERS < $f
                        if [ $? -ne 0 ]; then
                            rm -rf $MYSQL_CONFIG
                            exit 1
                        fi
                    done
                fi

                if [ -d $CORE_DIRECTORY/data/sql/updates/db_world ]; then
                    for f in $CORE_DIRECTORY/data/sql/updates/db_world/*.sql; do
                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_WORLD < $f
                        if [ $? -ne 0 ]; then
                            rm -rf $MYSQL_CONFIG
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
                            rm -rf $MYSQL_CONFIG
                            exit 1
                        fi
                    done
                fi

                if  [ -d $CORE_DIRECTORY/modules/kickstarter/sql/world/base ]; then
                    for f in $CORE_DIRECTORY/modules/kickstarter/sql/world/base/*.sql; do
                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_WORLD < $f
                        if [ $? -ne 0 ]; then
                            rm -rf $MYSQL_CONFIG
                            exit 1
                        fi
                    done
                fi

                if [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names $MYSQL_DATABASE_WORLD -e "SHOW TABLES LIKE 'mod_auctionhousebot'"` ]; then
                    mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_WORLD -e "UPDATE mod_auctionhousebot SET minitems='$MODULE_AHBOT_MIN_ITEMS', maxitems='$MODULE_AHBOT_MAX_ITEMS'"
                fi

                mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_AUTH -e "DELETE FROM realmlist WHERE id='$WORLD_ID';INSERT INTO realmlist (id, name, address, localAddress, localSubnetMask, port) VALUES ('$WORLD_ID', '$WORLD_NAME', '$WORLD_IP', '$WORLD_IP', '255.255.255.0', '8085')"
                if [ $? -ne 0 ]; then
                    rm -rf $MYSQL_CONFIG
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

function update_configuration()
{
    clear

    echo -e "\e[0;32mUpdating configuration files\e[0m"

    if [[ $1 == "auth" ]] || [[ $1 == "all" ]]; then
        if [ -f $CORE_DIRECTORY/etc/authserver.conf.dist ]; then
            echo -e "\e[0;33mUpdating authserver.conf\e[0m"

            cp $CORE_DIRECTORY/etc/authserver.conf.dist $CORE_DIRECTORY/etc/authserver.conf

            sed -i 's/LoginDatabaseInfo =.*/LoginDatabaseInfo = "'$MYSQL_HOSTNAME';'$MYSQL_PORT';'$MYSQL_USERNAME';'$MYSQL_PASSWORD';'$MYSQL_DATABASE_AUTH'"/g' $CORE_DIRECTORY/etc/authserver.conf
        fi
    fi

    if [[ $1 == "world" ]] || [[ $1 == "all" ]]; then
        if [ -f $CORE_DIRECTORY/etc/worldserver.conf.dist ]; then
            echo -e "\e[0;33mUpdating worldserver.conf\e[0m"

            cp $CORE_DIRECTORY/etc/worldserver.conf.dist $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/LoginDatabaseInfo     =.*/LoginDatabaseInfo     = "'$MYSQL_HOSTNAME';'$MYSQL_PORT';'$MYSQL_USERNAME';'$MYSQL_PASSWORD';'$MYSQL_DATABASE_AUTH'"/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/WorldDatabaseInfo     =.*/WorldDatabaseInfo     = "'$MYSQL_HOSTNAME';'$MYSQL_PORT';'$MYSQL_USERNAME';'$MYSQL_PASSWORD';'$MYSQL_DATABASE_WORLD'"/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/CharacterDatabaseInfo =.*/CharacterDatabaseInfo = "'$MYSQL_HOSTNAME';'$MYSQL_PORT';'$MYSQL_USERNAME';'$MYSQL_PASSWORD';'$MYSQL_DATABASE_CHARACTERS'"/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Ra.Enable =.*/Ra.Enable = 1/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/RealmID =.*/RealmID = '$WORLD_ID'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/GameType =.*/GameType = '$WORLD_GAME_TYPE'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/RealmZone =.*/RealmZone = '$WORLD_REALM_ZONE'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/PlayerLimit =.*/PlayerLimit = '$WORLD_PLAYER_LIMIT'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/StrictPlayerNames =.*/StrictPlayerNames = 3/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/StrictCharterNames =.*/StrictCharterNames = 3/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/StrictPetNames =.*/StrictPetNames = 3/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Motd =.*/Motd = "'"$WORLD_MOTD"'"/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/SkipCinematics =.*/SkipCinematics = '$WORLD_SKIP_CINEMATICS'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/StartPlayerLevel =.*/StartPlayerLevel = '$WORLD_START_LEVEL'/g' $CORE_DIRECTORY/etc/worldserver.conf
            if [ $WORLD_START_LEVEL -ge 55 ]; then
                sed -i 's/StartHeroicPlayerLevel =.*/StartHeroicPlayerLevel = '$WORLD_START_LEVEL'/g' $CORE_DIRECTORY/etc/worldserver.conf
            fi
            sed -i 's/StartPlayerMoney =.*/StartPlayerMoney = '$WORLD_START_MONEY'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/AllFlightPaths =.*/AllFlightPaths = '$WORLD_ALL_FLIGHT_PATHS'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/AlwaysMaxSkillForLevel =.*/AlwaysMaxSkillForLevel = '$WORLD_ALWAYS_MAX_SKILL'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/PlayerStart.MapsExplored =.*/PlayerStart.MapsExplored = '$WORLD_MAPS_EXPLORED'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/AllowPlayerCommands =.*/AllowPlayerCommands = '$WORLD_ALLOW_COMMANDS'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Quests.IgnoreRaid =.*/Quests.IgnoreRaid = '$WORLD_QUEST_IGNORE_RAID'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/PreventAFKLogout =.*/PreventAFKLogout = '$WORLD_PREVENT_AFK_LOGOUT'/g' $CORE_DIRECTORY/etc/worldserver.conf

            sed -i 's/Rate.Drop.Money                 =.*/Rate.Drop.Money                 = '$WORLD_RATE_MONEY'/g' $CORE_DIRECTORY/etc/worldserver.conf
            if [[ $MODULE_EXPERIENCED_ENABLED == "true" ]]; then
                sed -i 's/Rate.XP.Kill    =.*/Rate.XP.Kill    = 1/g' $CORE_DIRECTORY/etc/worldserver.conf
                sed -i 's/Rate.XP.Quest   =.*/Rate.XP.Quest   = 1/g' $CORE_DIRECTORY/etc/worldserver.conf
                sed -i 's/Rate.XP.Explore =.*/Rate.XP.Explore = 1/g' $CORE_DIRECTORY/etc/worldserver.conf
                sed -i 's/Rate.XP.Pet     =.*/Rate.XP.Pet     = 1/g' $CORE_DIRECTORY/etc/worldserver.conf
                sed -i 's/Rate.Reputation.Gain =.*/Rate.Reputation.Gain = 1/g' $CORE_DIRECTORY/etc/worldserver.conf
            else
                sed -i 's/Rate.XP.Kill    =.*/Rate.XP.Kill    = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
                sed -i 's/Rate.XP.Quest   =.*/Rate.XP.Quest   = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
                sed -i 's/Rate.XP.Explore =.*/Rate.XP.Explore = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
                sed -i 's/Rate.XP.Pet     =.*/Rate.XP.Pet     = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
                sed -i 's/Rate.Reputation.Gain =.*/Rate.Reputation.Gain = '$WORLD_RATE_REPUTATION'/g' $CORE_DIRECTORY/etc/worldserver.conf
            fi

            sed -i 's/SkillGain.Crafting  =.*/SkillGain.Crafting  = '$WORLD_RATE_CRAFTING'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/SkillGain.Defense   =.*/SkillGain.Defense   = '$WORLD_RATE_DEFENSE_SKILL'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/SkillGain.Gathering =.*/SkillGain.Gathering = '$WORLD_RATE_GATHERING'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/SkillGain.Weapon    =.*/SkillGain.Weapon    = '$WORLD_RATE_WEAPON_SKILL'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Rate.Rest.InGame                 =.*/Rate.Rest.InGame                 = '$WORLD_RATE_RESTED_EXP'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Rate.Rest.Offline.InTavernOrCity =.*/Rate.Rest.Offline.InTavernOrCity = '$WORLD_RATE_RESTED_EXP'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Rate.Rest.Offline.InWilderness   =.*/Rate.Rest.Offline.InWilderness   = '$WORLD_RATE_RESTED_EXP'/g' $CORE_DIRECTORY/etc/worldserver.conf

            sed -i 's/GM.LoginState =.*/GM.LoginState = '$WORLD_GM_LOGIN_STATE'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/GM.Visible =.*/GM.Visible = '$WORLD_GM_VISIBLE'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/GM.Chat =.*/GM.Chat = '$WORLD_GM_CHAT'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/GM.WhisperingTo =.*/GM.WhisperingTo = '$WORLD_GM_WHISPER'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/GM.InGMList.Level =.*/GM.InGMList.Level = '$WORLD_GM_GM_LIST'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/GM.InWhoList.Level =.*/GM.InWhoList.Level = '$WORLD_GM_WHO_LIST'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/GM.StartLevel = .*/GM.StartLevel = '$WORLD_START_LEVEL'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/GM.AllowInvite =.*/GM.AllowInvite = '$WORLD_GM_ALLOW_INVITE'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/GM.AllowFriend =.*/GM.AllowFriend = '$WORLD_GM_ALLOW_FRIEND'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/GM.LowerSecurity =.*/GM.LowerSecurity = '$WORLD_GM_LOWER_SECURITY'/g' $CORE_DIRECTORY/etc/worldserver.conf

            sed -i 's/Warden.Enabled =.*/Warden.Enabled = 0/g' $CORE_DIRECTORY/etc/worldserver.conf

            if [ -f $CORE_DIRECTORY/etc/modules/mod_ahbot.conf.dist ]; then
                echo -e "\e[0;33mUpdating mod_ahbot.conf\e[0m"

                cp $CORE_DIRECTORY/etc/modules/mod_ahbot.conf.dist $CORE_DIRECTORY/etc/modules/mod_ahbot.conf
                sed -i 's/AuctionHouseBot.EnableSeller =.*/AuctionHouseBot.EnableSeller = '$MODULE_AHBOT_ENABLE_SELLER'/g' $CORE_DIRECTORY/etc/modules/mod_ahbot.conf
                sed -i 's/AuctionHouseBot.EnableBuyer =.*/AuctionHouseBot.EnableBuyer = '$MODULE_AHBOT_ENABLE_BUYER'/g' $CORE_DIRECTORY/etc/modules/mod_ahbot.conf
                sed -i 's/AuctionHouseBot.Account =.*/AuctionHouseBot.Account = '$MODULE_AHBOT_ACCOUNT_ID'/g' $CORE_DIRECTORY/etc/modules/mod_ahbot.conf
                sed -i 's/AuctionHouseBot.GUID =.*/AuctionHouseBot.GUID = '$MODULE_AHBOT_CHARACTER_GUID'/g' $CORE_DIRECTORY/etc/modules/mod_ahbot.conf
            fi

            if [ -f $CORE_DIRECTORY/etc/modules/SkipDKModule.conf.dist ]; then
                echo -e "\e[0;33mUpdating SkipDKModule.conf\e[0m"

                cp $CORE_DIRECTORY/etc/modules/SkipDKModule.conf.dist $CORE_DIRECTORY/etc/modules/SkipDKModule.conf
                sed -i 's/GM.Skip.Deathknight.Starter.Enable =.*/GM.Skip.Deathknight.Starter.Enable = 1/g' $CORE_DIRECTORY/etc/modules/SkipDKModule.conf
                sed -i 's/Skip.Deathknight.Starter.Enable =.*/Skip.Deathknight.Starter.Enable = 1/g' $CORE_DIRECTORY/etc/modules/SkipDKModule.conf
                if [ $WORLD_START_LEVEL -ge 58 ]; then
                    sed -i 's/Skip.Deathknight.Start.Level =.*/Skip.Deathknight.Start.Level = '$WORLD_START_LEVEL'/g' $CORE_DIRECTORY/etc/modules/SkipDKModule.conf
                else
                    sed -i 's/Skip.Deathknight.Start.Level =.*/Skip.Deathknight.Start.Level = 58/g' $CORE_DIRECTORY/etc/modules/SkipDKModule.conf
                fi
            fi

            if [ -f $CORE_DIRECTORY/etc/modules/kickstarter.conf.dist ]; then
                echo -e "\e[0;33mUpdating kickstarter.conf\e[0m"

                cp $CORE_DIRECTORY/etc/modules/kickstarter.conf.dist $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Equipment =.*/Kickstarter.Equipment = '$MODULE_KICKSTARTER_FUNCTIONS_EQUIPMENT'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Gems =.*/Kickstarter.Gems = '$MODULE_KICKSTARTER_FUNCTIONS_GEMS'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Glyphs =.*/Kickstarter.Glyphs = '$MODULE_KICKSTARTER_FUNCTIONS_GLYPHS'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Spells =.*/Kickstarter.Spells = '$MODULE_KICKSTARTER_FUNCTIONS_SPELLS'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Proficiency =.*/Kickstarter.Proficiency = '$MODULE_KICKSTARTER_FUNCTIONS_PROFICIENCY'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Proficiency.Max =.*/Kickstarter.Proficiency.Max = '$MODULE_KICKSTARTER_FUNCTIONS_PROFICIENCY_MAX_SKILL'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Mounts =.*/Kickstarter.Mounts = '$MODULE_KICKSTARTER_FUNCTIONS_MOUNTS'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Utilities =.*/Kickstarter.Utilities = '$MODULE_KICKSTARTER_UTILITIES_ENABLED'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Utilities.ChangeName =.*/Kickstarter.Utilities.ChangeName = '$MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_NAME_CHANGE'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Utilities.ChangeRace =.*/Kickstarter.Utilities.ChangeRace = '$MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_RACE_CHANGE'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Utilities.ChangeFaction =.*/Kickstarter.Utilities.ChangeFaction = '$MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_FACTION_CHANGE'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
                sed -i 's/Kickstarter.Utilities.ChangeAppearance =.*/Kickstarter.Utilities.ChangeAppearance = '$MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_APPEARANCE_CHANGE'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            fi
        fi
    fi
}

function start_server()
{
    clear

    echo -e "\e[0;32mStarting server\e[0m"

    if [[ -z `screen -list | grep -E "auth"` ]] && [[ -z `screen -list | grep -E "world"` ]]; then
        if [ -f $CORE_DIRECTORY/bin/start.sh ]; then
            echo -e "\e[0;33mStarting the server process\e[0m"

            cd $CORE_DIRECTORY/bin && ./start.sh
        fi
    else
        echo -e "\e[0;33mThe server is already running\e[0m"
    fi
}

function stop_server()
{
    clear

    echo -e "\e[0;32mStopping server\e[0m"

    if [[ $1 == "world" ]] || [[ $1 == "all" ]]; then
        if [[ ! -z `screen -list | grep -E "world"` ]]; then
            echo -e "\e[0;33mSending command saveall to the world server\e[0m"

            screen -S world -p 0 -X stuff "saveall^m"

            sleep 3
        fi
    fi

    if [[ ! -z `screen -list | grep -E "auth"` ]] || [[ ! -z `screen -list | grep -E "world"` ]]; then
        if [ -f $CORE_DIRECTORY/bin/shutdown.sh ]; then
            echo -e "\e[0;33mStopping the server process\e[0m"

            cd $CORE_DIRECTORY/bin && ./shutdown.sh
        fi
    else
        echo -e "\e[0;33mNo running server found\e[0m"
    fi
}
