# AzerothCore
This is the content I use with my World of Warcraft: Wrath of the Lich King server. The core I use is [AzerothCore](https://github.com/azerothcore/azerothcore-wotlk)

The server is not public, only I play on it and I multibox so things like having group-looted quest items is a must. I use the Bash script to manage the server on a few Proxmox Containers running Ubuntu 20.10. The Authserver and Worldserver are run separately so the script can do this too. I also have a few containers specifically for MySQL-databases, so the script won't handle the MySQL-server

# Commands
Using the script and passing it either auth, world or all will install either or all of the systems. After the selected first parameter, use either install/setup/update, database/db, configuration/config/cfg or all to perform specific actions. Using setup/install/update it will download the source code, compile it and if world or all is used will download and unpack the client data files. The database/db command will import the database files to the specified database server. The configuration/config/cfg command will update the configuration files with the values specified in the xml-file. You may use the parameter all instead to perform all of the actions

For example, to install only the authserver using all functions on the system you use ./ac.sh auth all
To install both the authserver and worldserver, using all functions, you use ./ac.sh all all

There is also ./ac.sh auth/world/all backup - this command will perform a backup of the tables related to the specified parameter and zip it up

# First time
Running the script for the first time will generate a default configuration file called ac.xml that you edit. Make sure to edit it or the script will fail at some point. You can also copy the ac.xml.dist to ac.xml and edit it before running the script

# Extra
I will most likely create Docker/Podman images to handle all of this in the future

# Credit
All respect goes to the amazing people developing the core for us to use

Everyone is free to use this content for themselves or any public server, but I do not want anyone to take credit for creating it
