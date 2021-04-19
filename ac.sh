#!/bin/bash
if [ -f "includes/config.sh" ]; then
    source "includes/config.sh"
else
    echo -e "\e[0;33mUnable to access config.sh\e[0m"
    exit 1
fi

if [ -f "includes/distro.sh" ]; then
    source "includes/distro.sh"
else
    echo -e "\e[0;33mUnable to access distro.sh\e[0m"
    exit 1
fi

if [ -f "includes/functions.sh" ]; then
    source "includes/functions.sh"
else
    echo -e "\e[0;33mUnable to access functions.sh\e[0m"
    exit 1
fi

if [ -f "includes/packages.sh" ]; then
    source "includes/packages.sh"
else
    echo -e "\e[0;33mUnable to access packages.sh\e[0m"
    exit 1
fi
