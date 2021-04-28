# AzerothCore
This is the content I use with my World of Warcraft: Wrath of the Lich King server. The core I use is [AzerothCore](https://github.com/azerothcore/azerothcore-wotlk).

The server is not public, only I play on it and I multibox so things like having group-looted quest items for me is a must. I use the Bash script to manage the server on a few Proxmox Containers running Debian 10. The Authserver and Worldserver are run separately so the script has to handle that too. I also have a few containers specifically for MySQL-databases, so the script won't handle the MySQL-server.

The script currently supports CentOS 8, Debian 10, Ubuntu 20.04 and Ubuntu 20.10.

I never run the script as anything other than root so I unfortunately will not be adding support for non-root users.

I should note that everything is tested on Containers (LXC) and might not work properly on a regular installation. If something causes a problem, I'll look into fixing it.

# Commands
Using the script and passing it either auth, world or all will install either or all of the systems.

After the selected first parameter, use either install/setup/update, database/db, configuration/config/cfg or all to perform specific actions.
The setup/install/update command will download the source code, compile it and if world or all is used will download and unpack the client data files.
The database/db command will import the database files to the specified database server.
The configuration/config/cfg command will update the configuration files with the values specified in the xml-file.
The backup command will perform a full backup of the specified type.
You can use the parameter all instead to perform all, except backup, of the actions.

# First time
Running the script for the first time will generate a default configuration file called ac.xml that you edit. Make sure to edit it or the script will fail at some point. You can also copy the ac.xml.dist to ac.xml and edit it before running the script.

# Credit
All respect goes to the amazing people developing the core for us to use.

Anyone is free to use this content for themselves or on a public server, but do not take credit for the code.
