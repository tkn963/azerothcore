#!/bin/bash
ROOT=$(pwd)
BACKUP_DATE=$(date +"%Y-%m-%d_%H-%M")

CONFIG_FILE="backup.xml"
MYSQL_CONFIG="$ROOT/mysql.cnf"

if [ ! -f $ROOT/$CONFIG_FILE ]; then
    clear
    echo -e "\e[0;33mGenerating default configuration\e[0m"
    echo "<?xml version="1.0"?><config><mysql><hostname>127.0.0.1</hostname><port>3306</port><username>acore</username><password>acore</password></mysql></config>" | xmllint --format - > $ROOT/$CONFIG_FILE
    exit 1
fi

MYSQL_HOSTNAME="$(echo "cat /config/mysql/hostname/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MYSQL_PORT="$(echo "cat /config/mysql/port/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MYSQL_USERNAME="$(echo "cat /config/mysql/username/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MYSQL_PASSWORD="$(echo "cat /config/mysql/password/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"

if [[ -z $MYSQL_HOSTNAME ]] || [[ $MYSQL_HOSTNAME == "" ]] || 
   [[ -z $MYSQL_PORT ]] || [[ $MYSQL_PORT == "" ]] || 
   [[ -z $MYSQL_USERNAME ]] || [[ $MYSQL_USERNAME == "" ]] || 
   [[ -z $MYSQL_PASSWORD ]] || [[ $MYSQL_PASSWORD == "" ]]; then
    clear
    echo -e "\e[0;31mAtleast one of the configuration options is missing or invalid\e[0m"
    exit 1
fi
