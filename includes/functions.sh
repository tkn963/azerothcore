#!/bin/bash

function invalid_arguments()
{
    clear
    echo -e "\e[0;32mInvalid arguments\e[0m"
    echo -e "\e[0;33mThe supplied arguments are invalid\e[0m"
}

function build_server()
{
    install_build_packages

    clear

    echo -e "\e[0;32mDownloading source code\e[0m"

    if [ ! -d $CORE_DIRECTORY ]; then
        git clone --recursive --branch $AZEROTHCORE_BRANCH $AZEROTHCORE_URL $CORE_DIRECTORY
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

    if [ "$GIT_COMMIT" != "main" ]; then
        cd $CORE_DIRECTORY
        git reset $GIT_COMMIT
        if [ $? -ne 0 ]; then
            exit 1
        fi
    elif [ "$PULL_REQUEST" != "none" ]; then
        cd $CORE_DIRECTORY
        git checkout -b pr-$PULL_REQUEST
        if [ $? -ne 0 ]; then
            exit 1
        fi

        git pull origin pull/$PULL_REQUEST/head
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi

    if [[ $1 == "world" ]] || [[ $1 == "all" ]]; then
        if [ $MODULE_ELUNA_ENABLED == "true" ]; then
            if [ ! -d $CORE_DIRECTORY/modules/eluna ]; then
                git clone --recursive --branch $MODULE_ELUNA_BRANCH $MODULE_ELUNA_URL $CORE_DIRECTORY/modules/eluna
                if [ $? -ne 0 ]; then
                    exit 1
                fi
            else
                cd $CORE_DIRECTORY/modules/eluna

                git fetch --all
                if [ $? -ne 0 ]; then
                    exit 1
                fi

                git reset --hard origin/$MODULE_ELUNA_BRANCH
                if [ $? -ne 0 ]; then
                    exit 1
                fi

                git submodule update
                if [ $? -ne 0 ]; then
                    exit 1
                fi
            fi
        else
            if [ -d $CORE_DIRECTORY/modules/eluna ]; then
                rm -rf $CORE_DIRECTORY/modules/eluna

                if [ -d $CORE_DIRECTORY/build ]; then
                    rm -rf $CORE_DIRECTORY/build
                fi
            fi
        fi

        if [ $MODULE_AHBOT_ENABLED == "true" ]; then
            if [ ! -d $CORE_DIRECTORY/modules/ahbot ]; then
                git clone --recursive --branch $MODULE_AHBOT_BRANCH $MODULE_AHBOT_URL $CORE_DIRECTORY/modules/ahbot
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
                git clone --recursive --branch $MODULE_SKIPDKAREA_BRANCH $MODULE_SKIPDKAREA_URL $CORE_DIRECTORY/modules/skipdkarea
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
    fi

    if [ $WORLD_ALLOW_LFG_LOOTMODE == "true" ]; then
        sed -i 's/    if (!group->IsLeader(GetPlayer()->GetGUID()) || group->isLFGGroup())/    if (!group->IsLeader(GetPlayer()->GetGUID()))/g' $CORE_DIRECTORY/src/server/game/Handlers/GroupHandler.cpp
    fi

    clear

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

    clear

    echo -e "\e[0;32mCreating scripts\e[0m"

    echo "#!/bin/bash" > $CORE_DIRECTORY/bin/start.sh
    echo "#!/bin/bash" > $CORE_DIRECTORY/bin/shutdown.sh

    if [[ $1 == "auth" ]] || [[ $1 == "all" ]]; then
        echo "screen -AmdS auth ./auth.sh" >> $CORE_DIRECTORY/bin/start.sh
        echo "screen -X -S \"auth\" quit" >> $CORE_DIRECTORY/bin/shutdown.sh

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
        echo "screen -AmdS world ./world.sh" >> $CORE_DIRECTORY/bin/start.sh
        echo "screen -X -S \"world\" quit" >> $CORE_DIRECTORY/bin/shutdown.sh

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

    chmod +x $CORE_DIRECTORY/bin/start.sh
    chmod +x $CORE_DIRECTORY/bin/shutdown.sh

    if [[ $1 == "world" ]] || [[ $1 == "all" ]]; then
        if [ ! -d $CORE_DIRECTORY/bin/dbc ] || [ ! -d $CORE_DIRECTORY/bin/maps ] || [ ! -d $CORE_DIRECTORY/bin/mmaps ] || [ ! -d $CORE_DIRECTORY/bin/vmaps ]; then
            clear

            echo -e "\e[0;32mDownloading data files\e[0m"

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
    install_database_packages

    clear

    echo -e "\e[0;32mImporting database files\e[0m"

    echo "[client]" > $MYSQL_CONFIG
    echo "host=\"$MYSQL_HOSTNAME\"" >> $MYSQL_CONFIG
    echo "port=\"$MYSQL_PORT\"" >> $MYSQL_CONFIG
    echo "user=\"$MYSQL_USERNAME\"" >> $MYSQL_CONFIG
    echo "password=\"$MYSQL_PASSWORD\"" >> $MYSQL_CONFIG

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

                if [ -d $ROOT/custom/auth ]; then
                    if [[ ! -z "$(ls -A $ROOT/custom/auth/)" ]]; then
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

                if [[ -d $ROOT/custom/world ]]; then
                    if [[ ! -z "$(ls -A $ROOT/custom/world/)" ]]; then
                        for f in $ROOT/custom/world/*; do
                            if [ -d "$f" ]; then
                                if [[ ! -z "$(ls -A $f)" ]]; then
                                    for d in $f/*.sql; do
                                        echo -e "\e[0;33mImporting "$(basename $d)"\e[0m"
                                        mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_WORLD < $d
                                        if [ $? -ne 0 ]; then
                                            exit 1
                                        fi
                                    done
                                fi
                            else
                                echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                                mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_WORLD < $f
                                if [ $? -ne 0 ]; then
                                    exit 1
                                fi
                            fi
                        done
                    fi
                fi

                if [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names $MYSQL_DATABASE_WORLD -e "SHOW TABLES LIKE 'mod_auctionhousebot'"` ]; then
                    mysql --defaults-extra-file=$MYSQL_CONFIG $MYSQL_DATABASE_WORLD -e "UPDATE mod_auctionhousebot SET minitems='$MODULE_AHBOT_MIN_ITEMS', maxitems='$MODULE_AHBOT_MAX_ITEMS'"
                    if [ $? -ne 0 ]; then
                        rm -rf $MYSQL_CONFIG
                        exit 1
                    fi
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
            sed -i 's/Expansion =.*/Expansion = '$WORLD_EXPANSION'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/PlayerLimit =.*/PlayerLimit = '$WORLD_PLAYER_LIMIT'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/StrictPlayerNames =.*/StrictPlayerNames = 3/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/StrictCharterNames =.*/StrictCharterNames = 3/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/StrictPetNames =.*/StrictPetNames = 3/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Motd =.*/Motd = "'"$WORLD_MOTD"'"/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/SkipCinematics =.*/SkipCinematics = '$WORLD_SKIP_CINEMATICS'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/MaxPlayerLevel =.*/MaxPlayerLevel = '$WORLD_MAX_LEVEL'/g' $CORE_DIRECTORY/etc/worldserver.conf
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
            sed -i 's/RecruitAFriend.MaxLevel =.*/RecruitAFriend.MaxLevel = '$WORLD_RAF_MAX_LEVEL'/g' $CORE_DIRECTORY/etc/worldserver.conf

            sed -i 's/PreloadAllNonInstancedMapGrids =.*/PreloadAllNonInstancedMapGrids = '$WORLD_PRELOAD_MAP_GRIDS'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/SetAllCreaturesWithWaypointMovementActive =.*/SetAllCreaturesWithWaypointMovementActive = '$WORLD_SET_WAYPOINTS_ACTIVE'/g' $CORE_DIRECTORY/etc/worldserver.conf

            sed -i 's/Rate.Drop.Money                 =.*/Rate.Drop.Money                 = '$WORLD_RATE_MONEY'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Rate.XP.Kill    =.*/Rate.XP.Kill    = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Rate.XP.Quest   =.*/Rate.XP.Quest   = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Rate.XP.Explore =.*/Rate.XP.Explore = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Rate.XP.Pet     =.*/Rate.XP.Pet     = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
            sed -i 's/Rate.Reputation.Gain =.*/Rate.Reputation.Gain = '$WORLD_RATE_REPUTATION'/g' $CORE_DIRECTORY/etc/worldserver.conf

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

            if [ -f $CORE_DIRECTORY/etc/modules/mod_LuaEngine.conf.dist ]; then
                echo -e "\e[0;33mUpdating mod_LuaEngine.conf\e[0m"

                cp $CORE_DIRECTORY/etc/modules/mod_LuaEngine.conf.dist $CORE_DIRECTORY/etc/modules/mod_LuaEngine.conf
            fi

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
        else
            echo -e "\e[0;33mUnable to locate the required executable\e[0m"

            exit 1
        fi
    else
        echo -e "\e[0;33mThe server is already running\e[0m"
    fi
}

function stop_server()
{
    clear

    echo -e "\e[0;32mStopping server\e[0m"

    if [[ ! -z `screen -list | grep -E "world"` ]]; then
        echo -e "\e[0;33mTelling the world server to save\e[0m"

        screen -S world -p 0 -X stuff "saveall^m"

        sleep 3
    fi

    if [[ ! -z `screen -list | grep -E "auth"` ]] || [[ ! -z `screen -list | grep -E "world"` ]]; then
        if [ -f $CORE_DIRECTORY/bin/shutdown.sh ]; then
            echo -e "\e[0;33mStopping the server process\e[0m"

            cd $CORE_DIRECTORY/bin && ./shutdown.sh
        else
            echo -e "\e[0;33mUnable to locate the required executable\e[0m"

            exit 1
        fi
    else
        echo -e "\e[0;33mNo running server found\e[0m"
    fi
}

function backup_server()
{
    install_database_packages

    clear

    echo "[client]" > $MYSQL_CONFIG
    echo "host=\"$MYSQL_HOSTNAME\"" >> $MYSQL_CONFIG
    echo "port=\"$MYSQL_PORT\"" >> $MYSQL_CONFIG
    echo "user=\"$MYSQL_USERNAME\"" >> $MYSQL_CONFIG
    echo "password=\"$MYSQL_PASSWORD\"" >> $MYSQL_CONFIG

    BACKUP_DATE=$(date +"%Y-%m-%d_%H-%M")

    echo -e "\e[0;32mBacking up database\e[0m"

    if [[ $1 == "auth" ]] || [[ $1 == "all" ]]; then
        if [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names -e "SHOW DATABASES LIKE '$MYSQL_DATABASE_AUTH'"` ]; then
            mkdir -p $ROOT/backup/$BACKUP_DATE/$MYSQL_DATABASE_AUTH

            for t in `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names -e "SHOW TABLES FROM $MYSQL_DATABASE_AUTH"`; do
                echo -e "\e[0;33mExporting table $t\e[0m"
                mysqldump --defaults-extra-file=$MYSQL_CONFIG --hex-blob $MYSQL_DATABASE_AUTH $t > $ROOT/backup/$BACKUP_DATE/$MYSQL_DATABASE_AUTH/$t.sql
            done
        fi
    fi

    if [[ $1 == "world" ]] || [[ $1 == "all" ]]; then
        if [ ! -z `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names -e "SHOW DATABASES LIKE '$MYSQL_DATABASE_CHARACTERS'"` ]; then
            mkdir -p $ROOT/backup/$BACKUP_DATE/$MYSQL_DATABASE_CHARACTERS

            for t in `mysql --defaults-extra-file=$MYSQL_CONFIG --skip-column-names -e "SHOW TABLES FROM $MYSQL_DATABASE_CHARACTERS"`; do
                echo -e "\e[0;33mExporting table $t\e[0m"
                mysqldump --defaults-extra-file=$MYSQL_CONFIG --hex-blob $MYSQL_DATABASE_CHARACTERS $t > $ROOT/backup/$BACKUP_DATE/$MYSQL_DATABASE_CHARACTERS/$t.sql
            done
        fi
    fi

    if [ -d $ROOT/backup/$BACKUP_DATE ]; then
        cd $ROOT/backup/$BACKUP_DATE
        tar -czvf $ROOT/backup/$BACKUP_DATE.tar.gz * > /dev/null 2>&1
        rm -rf $ROOT/backup/$BACKUP_DATE
    fi

    rm -rf $MYSQL_CONFIG
}
