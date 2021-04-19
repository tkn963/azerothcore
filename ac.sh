#!/bin/bash
INCLUDES=("config" "distro" "functions" "packages")

for ((i = 0 ; i < ${#INCLUDES[@]} ; i+=1)); do
    if [ -f "includes/${INCLUDES[i]}.sh" ]; then
        source "includes/${INCLUDES[i]}.sh"
    else
        echo -e "\e[0;33mUnable to access includes/${INCLUDES[i]}.sh\e[0m"
        exit 1
    fi
done
