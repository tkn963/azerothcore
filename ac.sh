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
