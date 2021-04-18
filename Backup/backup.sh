#!/bin/bash
ROOT=$(pwd)

LOG_FILE=$ROOT/backup.log

BACKUP_DATE=$(date +"%Y-%m-%d_%H-%M")
BACKUP_DIRECTORY=$ROOT/azerothcore

DATABASE_CNF=$ROOT/mysql.cnf
DATABASE_HOSTNAME=10.0.0.100
DATABASE_PORT=3306
DATABASE_USERNAME="backup"
DATABASE_PASSWORD="backup"
DATABASE_NAME=("acore_auth" "acore_characters")

PACKAGES=("mysql-client-8.0" 
          "zip")

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

if [ -x "$(command -v mysql)" ] && [ -x "$(command -v mysqldump)" ] && [ -x "$(command -v zip)" ]; then
    if [ ! -d $BACKUP_DIRECTORY/$BACKUP_DATE ]; then
        clear

        echo "[$(date +"%Y-%m-%d_%H-%M-%S")] Initializing backup" >> $LOG_FILE

        echo -e "\e[0;32mBacking up all databases\e[0;33m"
        echo -e "\e[0;33mInitializing...\e[0;33m"

        echo "[client]" > $DATABASE_CNF
        echo "host=\"$DATABASE_HOSTNAME\"" >> $DATABASE_CNF
        echo "port=\"$DATABASE_PORT\"" >> $DATABASE_CNF
        echo "user=\"$DATABASE_USERNAME\"" >> $DATABASE_CNF
        echo "password=\"$DATABASE_PASSWORD\"" >> $DATABASE_CNF
        echo "[mysqldump]" >> $DATABASE_CNF
        echo "column-statistics=0" >> $DATABASE_CNF

        for D in ${DATABASE_NAME[@]}; do
            if [ -z `mysql --defaults-extra-file=$DATABASE_CNF --skip-column-names -e "SHOW DATABASES LIKE '$D'"` ]; then
                echo "[$(date +"%Y-%m-%d_%H-%M-%S")] Unable to access the database $D" >> $LOG_FILE

                echo -e "\e[0;31mUnable to access the database $D\e[0m"
                exit 1
            else
                echo -e "\n\e[0;32mExporting database $D\e[0m"

                mkdir -p $BACKUP_DIRECTORY/$BACKUP_DATE/$D

                TABLE_COUNT=`mysql --defaults-extra-file=$DATABASE_CNF --skip-column-names -e "SELECT count(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='$D'"`
                echo "[$(date +"%Y-%m-%d_%H-%M-%S")] Exporting $TABLE_COUNT tables from $D" >> $LOG_FILE

                for T in `mysql --defaults-extra-file=$DATABASE_CNF --skip-column-names -e "SHOW TABLES FROM $D"`; do
                    echo -e "\e[0;33mExporting table $T\e[0m"
                    mysqldump --defaults-extra-file=$DATABASE_CNF --hex-blob $D $T > $BACKUP_DIRECTORY/$BACKUP_DATE/$D/$T.sql
                done

                echo "[$(date +"%Y-%m-%d_%H-%M-%S")] Export finished" >> $LOG_FILE
            fi
        done

        rm -rf $DATABASE_CNF

        cd $BACKUP_DIRECTORY/$BACKUP_DATE
        zip -q -r -9 $BACKUP_DIRECTORY/$BACKUP_DATE.zip *
        echo "[$(date +"%Y-%m-%d_%H-%M-%S")] Backup finished" >> $LOG_FILE
        rm -rf $BACKUP_DIRECTORY/$BACKUP_DATE      
    fi
fi
