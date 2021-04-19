#!/bin/bash
INCLUDES=("distro" "packages" "config" "functions")

for i in "${INCLUDES[@]}"; do
    if [ -f "includes/$i.sh" ]; then
        source "includes/$i.sh"
    else
        echo -e "\e[0;33mUnable to access includes/$i.sh\e[0m"
        exit 1
    fi
done

if [ $# -eq 2 ]; then
    if [[ $1 == "all" ]] || [[ $1 == "auth" ]] || [[ $1 == "world" ]]; then
        if [[ $2 == "setup" ]] || [[ $2 == "update" ]]; then
            echo "$1 $2"
        elif [[ $2 == "database" ]] || [[ $2 == "db" ]]; then
            echo "$1 $2"
        elif [[ $2 == "configuration" ]] || [[ $2 == "config" ]] || [[ $2 == "cfg" ]]; then
            echo "$1 $2"
        elif [ $2 == "start" ]; then
            echo "$1 $2"
        elif [ $2 == "stop" ]; then
            echo "$1 $2"
        else
            invalid_arguments
        fi
    else
        invalid_arguments
    fi
else
    invalid_arguments
fi
