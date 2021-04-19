#!/bin/bash
INCLUDES=("distro" "packages" "config" "functions")

clear
echo -e "\e[0;32mInitializing...\e[0m"

for i in "${INCLUDES[@]}"; do
    if [ -f "includes/$i.sh" ]; then
        echo -e "\e[0;33mLoading includes/$i.sh\e[0m"
        source "includes/$i.sh"
    else
        echo -e "\e[0;33mUnable to access includes/$i.sh\e[0m"
        exit 1
    fi
done

if [ $# -eq 2 ]; then
    if [[ $1 == "all" ]] || [[ $1 == "auth" ]] || [[ $1 == "world" ]]; then
        if [[ $2 == "setup" ]] || [[ $2 == "install" ]] || [[ $2 == "update" ]]; then
            perform_setup $1
        elif [[ $2 == "database" ]] || [[ $2 == "db" ]]; then
            import_database $1
        elif [[ $2 == "configuration" ]] || [[ $2 == "config" ]] || [[ $2 == "cfg" ]]; then
            echo "$1 $2"
        elif [ $2 == "start" ]; then
            echo "$1 $2"
        elif [ $2 == "stop" ]; then
            echo "$1 $2"
        elif [ $2 == "all" ]; then
            perform_setup $1
            import_database $1
        else
            invalid_arguments
        fi
    else
        invalid_arguments
    fi
else
    invalid_arguments
fi
