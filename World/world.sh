#!/bin/bash
ROOT=$(pwd)

MYSQL_HOST=10.0.0.100
MYSQL_PORT=3306
MYSQL_USER=acore
MYSQL_PASS=acore
MYSQL_DATA_AUTH=acore_auth
MYSQL_DATA_CHARACTERS=acore_characters
MYSQL_DATA_WORLD=acore_world

CORE_DIRECTORY=/opt/azerothcore

MODULE_AHBOT_ENABLED=true
MODULE_AHBOT_SELLER=1
MODULE_AHBOT_BUYER=1
MODULE_AHBOT_ACCOUNT=1
MODULE_AHBOT_GUID=1
MODULE_AHBOT_MINITEMS=5000
MODULE_AHBOT_MAXITEMS=10000
MODULE_SKIPDKAREA_ENABLED=false
MODULE_KICKSTARTER_ENABLED=true
MODULE_KICKSTARTER_EQUIPMENT=0
MODULE_KICKSTARTER_GEMS=1
MODULE_KICKSTARTER_GLYPHS=1
MODULE_KICKSTARTER_SPELLS=0
MODULE_KICKSTARTER_PROFICIENCY=0
MODULE_KICKSTARTER_PROFICIENCY_MAX=0
MODULE_KICKSTARTER_MOUNTS=0
MODULE_KICKSTARTER_UTILITIES=1
MODULE_KICKSTARTER_UTILITIES_NAME=1
MODULE_KICKSTARTER_UTILITIES_RACE=1
MODULE_KICKSTARTER_UTILITIES_FACTION=1
MODULE_KICKSTARTER_UTILITIES_APPEARANCE=1

WORLD_NAME="Aurora"
WORLD_MOTD="Welcome to Aurora. This is hosted for those who are truly excellent!"
WORLD_ID=1
WORLD_IP=10.0.0.111
WORLD_GAMETYPE=1
WORLD_REALMZONE=8
WORLD_PLAYERLIMIT=1000
WORLD_SKIPCINEMATICS=2
WORLD_STARTLEVEL=1
WORLD_STARTMONEY=0
WORLD_ALWAYSMAXSKILL=0
WORLD_ALLFLIGHTPATHS=0
WORLD_MAPSEXPLORED=0
WORLD_ALLOWCOMMANDS=0
WORLD_QUESTIGNORERAID=1
WORLD_PREVENTAFKLOGOUT=0

WORLD_RATE_MONEY=3
WORLD_RATE_EXPERIENCE=3
WORLD_RATE_REPUTATION=3
WORLD_RATE_CRAFTING=3
WORLD_RATE_DEFENSE=3
WORLD_RATE_GATHERING=3
WORLD_RATE_WEAPON=3
WORLD_RATE_RESTEXP=3

WORLD_GM_LOGINSTATE=1
WORLD_GM_VISIBLE=0
WORLD_GM_CHAT=0
WORLD_GM_WHISPER=0
WORLD_GM_LIST=0
WORLD_GM_WHO=0
WORLD_GM_ALLOWINVITE=0
WORLD_GM_LOWERSECURITY=0

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

        if [[ $MODULE_AHBOT_ENABLED == "true" ]]; then
            if [[ ! -d $CORE_DIRECTORY/modules/ahbot ]]; then
                git clone --recursive --branch master --depth 1 https://github.com/azerothcore/mod-ah-bot.git $CORE_DIRECTORY/modules/ahbot
                if [ $? -ne 0 ]; then
                    exit 1
                fi
            else
                cd $CORE_DIRECTORY/modules/ahbot

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
        else
            if [[ -d $CORE_DIRECTORY/modules/ahbot ]]; then
                rm -rf $CORE_DIRECTORY/modules/ahbot

                if [[ -d $CORE_DIRECTORY/build ]]; then
                    rm -rf $CORE_DIRECTORY/build
                fi
            fi
        fi

        if [[ $MODULE_SKIPDKAREA_ENABLED == "true" ]]; then
            if [[ ! -d $CORE_DIRECTORY/modules/skipdkarea ]]; then
                git clone --recursive --branch master --depth 1 https://github.com/Crypticaz/SkipDeathKnightStartingArea.git $CORE_DIRECTORY/modules/skipdkarea
                if [ $? -ne 0 ]; then
                    exit 1
                fi
            else
                cd $CORE_DIRECTORY/modules/skipdkarea

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
        else
            if [[ -d $CORE_DIRECTORY/modules/skipdkarea ]]; then
                rm -rf $CORE_DIRECTORY/modules/skipdkarea

                if [[ -d $CORE_DIRECTORY/build ]]; then
                    rm -rf $CORE_DIRECTORY/build
                fi
            fi
        fi

        if [[ $MODULE_KICKSTARTER_ENABLED == "true" ]]; then
            if [[ ! -d $CORE_DIRECTORY/modules/kickstarter ]]; then
                git clone --recursive --branch main --depth 1 https://github.com/tkn963/kickstarter.git $CORE_DIRECTORY/modules/kickstarter
                if [ $? -ne 0 ]; then
                    exit 1
                fi
            else
                cd $CORE_DIRECTORY/modules/kickstarter

                git fetch --all
                if [ $? -ne 0 ]; then
                    exit 1
                fi

                git reset --hard origin/main
                if [ $? -ne 0 ]; then
                    exit 1
                fi

                git submodule update
                if [ $? -ne 0 ]; then
                    exit 1
                fi
            fi
        else
            if [[ -d $CORE_DIRECTORY/modules/kickstarter ]]; then
                rm -rf $CORE_DIRECTORY/modules/kickstarter

                if [[ -d $CORE_DIRECTORY/build ]]; then
                    rm -rf $CORE_DIRECTORY/build
                fi
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
        echo "screen -AmdS world ./world.sh" >> $CORE_DIRECTORY/bin/start.sh

        chmod +x $CORE_DIRECTORY/bin/start.sh

        echo "#!/bin/bash" > $CORE_DIRECTORY/bin/shutdown.sh
        echo "screen -X -S \"world\" quit" >> $CORE_DIRECTORY/bin/shutdown.sh

        chmod +x $CORE_DIRECTORY/bin/shutdown.sh

        echo "#!/bin/sh" > $CORE_DIRECTORY/bin/world.sh
        echo "while :; do" >> $CORE_DIRECTORY/bin/world.sh
        echo "./worldserver" >> $CORE_DIRECTORY/bin/world.sh
        echo "sleep 20" >> $CORE_DIRECTORY/bin/world.sh
        echo "done" >> $CORE_DIRECTORY/bin/world.sh

        chmod +x $CORE_DIRECTORY/bin/world.sh

        if [ ! -d $CORE_DIRECTORY/bin/Cameras ] || [ ! -d $CORE_DIRECTORY/bin/dbc ] || [ ! -d $CORE_DIRECTORY/bin/maps ] || [ ! -d $CORE_DIRECTORY/bin/mmaps ] || [ ! -d $CORE_DIRECTORY/bin/vmaps ]; then
            curl -L https://github.com/wowgaming/client-data/releases/download/v10/data.zip > $CORE_DIRECTORY/bin/data.zip
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

        if [ ! -z `mysql --defaults-extra-file=$ROOT/mysql.cnf --skip-column-names -e "SHOW DATABASES LIKE '$MYSQL_DATA_CHARACTERS'"` ] && [ ! -z `mysql --defaults-extra-file=$ROOT/mysql.cnf --skip-column-names -e "SHOW DATABASES LIKE '$MYSQL_DATA_WORLD'"` ]; then
            if [ -d $CORE_DIRECTORY/data/sql/base/db_characters ] && [ -d $CORE_DIRECTORY/data/sql/base/db_world ]; then
                for f in $CORE_DIRECTORY/data/sql/base/db_characters/*.sql; do
                    if [ ! -z `mysql --defaults-extra-file=$ROOT/mysql.cnf --skip-column-names $MYSQL_DATA_CHARACTERS -e "SHOW TABLES LIKE '$(basename $f .sql)'"` ]; then
                        echo -e "\e[0;33mSkipping "$(basename $f)"\e[0m"
                        continue;
                    fi

                    echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                    mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_CHARACTERS < $f
                    if [ $? -ne 0 ]; then
                        exit 1
                    fi
                done

                for f in $CORE_DIRECTORY/data/sql/base/db_world/*.sql; do
                    if [ ! -z `mysql --defaults-extra-file=$ROOT/mysql.cnf --skip-column-names $MYSQL_DATA_WORLD -e "SHOW TABLES LIKE '$(basename $f .sql)'"` ]; then
                        echo -e "\e[0;33mSkipping "$(basename $f)"\e[0m"
                        continue;
                    fi

                    echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                    mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_WORLD < $f
                    if [ $? -ne 0 ]; then
                        exit 1
                    fi
                done

                if [ -d $CORE_DIRECTORY/data/sql/updates/db_characters ]; then
                    for f in $CORE_DIRECTORY/data/sql/updates/db_characters/*.sql; do
                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_CHARACTERS < $f
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi
                    done
                fi

                if [ -d $CORE_DIRECTORY/data/sql/updates/db_world ]; then
                    for f in $CORE_DIRECTORY/data/sql/updates/db_world/*.sql; do
                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_WORLD < $f
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi
                    done
                fi

                if  [ -d $CORE_DIRECTORY/modules/ahbot/sql/world/base ]; then
                    for f in $CORE_DIRECTORY/modules/ahbot/sql/world/base/*.sql; do
                        if [ ! -z `mysql --defaults-extra-file=$ROOT/mysql.cnf --skip-column-names $MYSQL_DATA_WORLD -e "SHOW TABLES LIKE '$(basename $f .sql)'"` ]; then
                            echo -e "\e[0;33mSkipping "$(basename $f)"\e[0m"
                            continue;
                        fi

                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_WORLD < $f
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi
                    done
                fi

                if  [ -d $CORE_DIRECTORY/modules/kickstarter/sql/world/base ]; then
                    for f in $CORE_DIRECTORY/modules/kickstarter/sql/world/base/*.sql; do
                        echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                        mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_WORLD < $f
                        if [ $? -ne 0 ]; then
                            exit 1
                        fi
                    done
                fi

                if [ -d $ROOT/custom ]; then
                    if [ -d $ROOT/custom/characters ]; then
                        for f in $ROOT/custom/characters/*.sql; do
                            echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                            mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_CHARACTERS < $f
                            if [ $? -ne 0 ]; then
                                exit 1
                            fi
                        done
                    fi

                    if [ -d $ROOT/custom/world ]; then
                        for f in $ROOT/custom/world/*.sql; do
                            echo -e "\e[0;33mImporting "$(basename $f)"\e[0m"
                            mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_WORLD < $f
                            if [ $? -ne 0 ]; then
                                exit 1
                            fi
                        done
                    fi
                fi

                if [ ! -z `mysql --defaults-extra-file=$ROOT/mysql.cnf --skip-column-names $MYSQL_DATA_WORLD -e "SHOW TABLES LIKE 'mod_auctionhousebot'"` ]; then
                    mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_WORLD -e "UPDATE mod_auctionhousebot SET minitems='$MODULE_AHBOT_MINITEMS', maxitems='$MODULE_AHBOT_MAXITEMS'"
                fi

                mysql --defaults-extra-file=$ROOT/mysql.cnf $MYSQL_DATA_AUTH -e "DELETE FROM realmlist WHERE id='$WORLD_ID';INSERT INTO realmlist (id, name, address, localAddress, localSubnetMask, port) VALUES ('$WORLD_ID', '$WORLD_NAME', '$WORLD_IP', '$WORLD_IP', '255.255.255.0', '8085')"
                if [ $? -ne 0 ]; then
                    exit 1
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

    if [ -f $CORE_DIRECTORY/etc/worldserver.conf.dist ]; then
        cp $CORE_DIRECTORY/etc/worldserver.conf.dist $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/LoginDatabaseInfo     =.*/LoginDatabaseInfo     = "'$MYSQL_HOST';'$MYSQL_PORT';'$MYSQL_USER';'$MYSQL_PASS';'$MYSQL_DATA_AUTH'"/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/WorldDatabaseInfo     =.*/WorldDatabaseInfo     = "'$MYSQL_HOST';'$MYSQL_PORT';'$MYSQL_USER';'$MYSQL_PASS';'$MYSQL_DATA_WORLD'"/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/CharacterDatabaseInfo =.*/CharacterDatabaseInfo = "'$MYSQL_HOST';'$MYSQL_PORT';'$MYSQL_USER';'$MYSQL_PASS';'$MYSQL_DATA_CHARACTERS'"/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/Ra.Enable =.*/Ra.Enable = 1/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/RealmID =.*/RealmID = '$WORLD_ID'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/GameType =.*/GameType = '$WORLD_GAMETYPE'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/RealmZone =.*/RealmZone = '$WORLD_REALMZONE'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/PlayerLimit =.*/PlayerLimit = '$WORLD_PLAYERLIMIT'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/StrictPlayerNames =.*/StrictPlayerNames = 3/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/StrictCharterNames =.*/StrictCharterNames = 3/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/StrictPetNames =.*/StrictPetNames = 3/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/Motd =.*/Motd = "'"$WORLD_MOTD"'"/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/SkipCinematics =.*/SkipCinematics = '$WORLD_SKIPCINEMATICS'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/StartPlayerLevel =.*/StartPlayerLevel = '$WORLD_STARTLEVEL'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/StartHeroicPlayerLevel =.*/StartHeroicPlayerLevel = '$WORLD_STARTLEVEL'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/StartPlayerMoney =.*/StartPlayerMoney = '$WORLD_STARTMONEY'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/AllFlightPaths =.*/AllFlightPaths = '$WORLD_ALLFLIGHTPATHS'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/AlwaysMaxSkillForLevel =.*/AlwaysMaxSkillForLevel = '$WORLD_ALWAYSMAXSKILL'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/PlayerStart.MapsExplored =.*/PlayerStart.MapsExplored = '$WORLD_MAPSEXPLORED'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/AllowPlayerCommands =.*/AllowPlayerCommands = '$WORLD_ALLOWCOMMANDS'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/Quests.IgnoreRaid =.*/Quests.IgnoreRaid = '$WORLD_QUESTIGNORERAID'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/PreventAFKLogout =.*/PreventAFKLogout = '$WORLD_PREVENTAFKLOGOUT'/g' $CORE_DIRECTORY/etc/worldserver.conf

        sed -i 's/Rate.Drop.Money                 =.*/Rate.Drop.Money                 = '$WORLD_RATE_MONEY'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/Rate.XP.Kill    =.*/Rate.XP.Kill    = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/Rate.XP.Quest   =.*/Rate.XP.Quest   = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/Rate.XP.Explore =.*/Rate.XP.Explore = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/Rate.XP.Pet     =.*/Rate.XP.Pet     = '$WORLD_RATE_EXPERIENCE'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/Rate.Reputation.Gain =.*/Rate.Reputation.Gain = '$WORLD_RATE_REPUTATION'/g' $CORE_DIRECTORY/etc/worldserver.conf

        sed -i 's/SkillGain.Crafting  =.*/SkillGain.Crafting  = '$WORLD_RATE_CRAFTING'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/SkillGain.Defense   =.*/SkillGain.Defense   = '$WORLD_RATE_DEFENSE'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/SkillGain.Gathering =.*/SkillGain.Gathering = '$WORLD_RATE_GATHERING'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/SkillGain.Weapon    =.*/SkillGain.Weapon    = '$WORLD_RATE_WEAPON'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/Rate.Rest.InGame                 =.*/Rate.Rest.InGame                 = '$WORLD_RATE_RESTEXP'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/Rate.Rest.Offline.InTavernOrCity =.*/Rate.Rest.Offline.InTavernOrCity = '$WORLD_RATE_RESTEXP'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/Rate.Rest.Offline.InWilderness   =.*/Rate.Rest.Offline.InWilderness   = '$WORLD_RATE_RESTEXP'/g' $CORE_DIRECTORY/etc/worldserver.conf

        sed -i 's/GM.LoginState =.*/GM.LoginState = '$WORLD_GM_LOGINSTATE'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/GM.Visible =.*/GM.Visible = '$WORLD_GM_VISIBLE'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/GM.Chat =.*/GM.Chat = '$WORLD_GM_CHAT'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/GM.WhisperingTo =.*/GM.WhisperingTo = '$WORLD_GM_WHISPER'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/GM.InGMList.Level =.*/GM.InGMList.Level = '$WORLD_GM_LIST'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/GM.InWhoList.Level =.*/GM.InWhoList.Level = '$WORLD_GM_WHO'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/GM.StartLevel = .*/GM.StartLevel = '$WORLD_STARTLEVEL'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/GM.AllowInvite =.*/GM.AllowInvite = '$WORLD_GM_ALLOWINVITE'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/GM.AllowFriend =.*/GM.AllowFriend = '$WORLD_GM_ALLOWFRIEND'/g' $CORE_DIRECTORY/etc/worldserver.conf
        sed -i 's/GM.LowerSecurity =.*/GM.LowerSecurity = '$WORLD_GM_LOWERSECURITY'/g' $CORE_DIRECTORY/etc/worldserver.conf

        sed -i 's/Warden.Enabled =.*/Warden.Enabled = 0/g' $CORE_DIRECTORY/etc/worldserver.conf

        if [ -f $CORE_DIRECTORY/etc/modules/mod_ahbot.conf.dist ]; then
            cp $CORE_DIRECTORY/etc/modules/mod_ahbot.conf.dist $CORE_DIRECTORY/etc/modules/mod_ahbot.conf
            sed -i 's/AuctionHouseBot.EnableSeller =.*/AuctionHouseBot.EnableSeller = '$MODULE_AHBOT_SELLER'/g' $CORE_DIRECTORY/etc/modules/mod_ahbot.conf
            sed -i 's/AuctionHouseBot.EnableBuyer =.*/AuctionHouseBot.EnableBuyer = '$MODULE_AHBOT_BUYER'/g' $CORE_DIRECTORY/etc/modules/mod_ahbot.conf
            sed -i 's/AuctionHouseBot.Account =.*/AuctionHouseBot.Account = '$MODULE_AHBOT_ACCOUNT'/g' $CORE_DIRECTORY/etc/modules/mod_ahbot.conf
            sed -i 's/AuctionHouseBot.GUID =.*/AuctionHouseBot.GUID = '$MODULE_AHBOT_GUID'/g' $CORE_DIRECTORY/etc/modules/mod_ahbot.conf
        fi

        if [ -f $CORE_DIRECTORY/etc/modules/SkipDKModule.conf.dist ]; then
            cp $CORE_DIRECTORY/etc/modules/SkipDKModule.conf.dist $CORE_DIRECTORY/etc/modules/SkipDKModule.conf
            sed -i 's/GM.Skip.Deathknight.Starter.Enable =.*/GM.Skip.Deathknight.Starter.Enable = 1/g' $CORE_DIRECTORY/etc/modules/SkipDKModule.conf
            sed -i 's/Skip.Deathknight.Starter.Enable =.*/Skip.Deathknight.Starter.Enable = 1/g' $CORE_DIRECTORY/etc/modules/SkipDKModule.conf
            if [ $WORLD_STARTLEVEL -ge 58 ]; then
                sed -i 's/Skip.Deathknight.Start.Level =.*/Skip.Deathknight.Start.Level = '$WORLD_STARTLEVEL'/g' $CORE_DIRECTORY/etc/modules/SkipDKModule.conf
            else
                sed -i 's/Skip.Deathknight.Start.Level =.*/Skip.Deathknight.Start.Level = 58/g' $CORE_DIRECTORY/etc/modules/SkipDKModule.conf
            fi
        fi

        if [ -f $CORE_DIRECTORY/etc/modules/kickstarter.conf.dist ]; then
            cp $CORE_DIRECTORY/etc/modules/kickstarter.conf.dist $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Equipment =.*/Kickstarter.Equipment = '$MODULE_KICKSTARTER_EQUIPMENT'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Gems =.*/Kickstarter.Gems = '$MODULE_KICKSTARTER_GEMS'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Glyphs =.*/Kickstarter.Glyphs = '$MODULE_KICKSTARTER_GLYPHS'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Spells =.*/Kickstarter.Spells = '$MODULE_KICKSTARTER_SPELLS'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Proficiency =.*/Kickstarter.Proficiency = '$MODULE_KICKSTARTER_PROFICIENCY'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Proficiency.Max =.*/Kickstarter.Proficiency.Max = '$MODULE_KICKSTARTER_PROFICIENCY_MAX'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Mounts =.*/Kickstarter.Mounts = '$MODULE_KICKSTARTER_MOUNTS'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Utilities =.*/Kickstarter.Utilities = '$MODULE_KICKSTARTER_UTILITIES'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Utilities.ChangeName =.*/Kickstarter.Utilities.ChangeName = '$MODULE_KICKSTARTER_UTILITIES_NAME'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Utilities.ChangeRace =.*/Kickstarter.Utilities.ChangeRace = '$MODULE_KICKSTARTER_UTILITIES_RACE'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Utilities.ChangeFaction =.*/Kickstarter.Utilities.ChangeFaction = '$MODULE_KICKSTARTER_UTILITIES_FACTION'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
            sed -i 's/Kickstarter.Utilities.ChangeAppearance =.*/Kickstarter.Utilities.ChangeAppearance = '$MODULE_KICKSTARTER_UTILITIES_APPEARANCE'/g' $CORE_DIRECTORY/etc/modules/kickstarter.conf
        fi
    else
        echo -e "\e[0;31mThe file worldserver.conf.dist is missing\e[0m"
        exit 1
    fi
}

function START {
    clear

    if [ -f $CORE_DIRECTORY/bin/start.sh ] && [ -f $CORE_DIRECTORY/bin/worldserver ]; then
        if ! ps -C "world" > /dev/null; then
            cd $CORE_DIRECTORY/bin && ./start.sh
        fi
    fi
}

function STOP {
    clear

    screen -S world -p 0 -X stuff "saveall^m"

    sleep 3

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

