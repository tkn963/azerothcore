# AzerothCore
This is the content I use with my World of Warcraft: Wrath of the Lich King server. The core I use is [AzerothCore](https://github.com/azerothcore/azerothcore-wotlk).

The server is not public, only I play on it and I multibox so things like having group-looted quest items is a must. I use the Bash script to manage the server on a few Proxmox Containers running Ubuntu 20.10. The Authserver and Worldserver are run separately so the script can do this too. I also have a few containers specifically for MySQL-databases, so the script won't handle the MySQL-server.

# Commands
Using the filename followed by either auth, world or all to select the type to run on the system and then either setup, database, config, start, stop or all will manage the server for you.

For example, to download the source code and compile it for both auth and world you type: ./ac.sh all setup
To perform all steps using both auth and world, you type ./ac.sh all all

# First time
Running the script for the first time will generate a default configuration file called ac.xml that you edit. Make sure to edit it or the script will fail at some point.

# Extra
I will create Docker/Podman images to handle all of this in the future.

# Credit
All respect goes to the amazing people developing the core for us to use.

Everyone is free to use this content for themselves or any public server, but I do not want anyone to take credit for creating it.
