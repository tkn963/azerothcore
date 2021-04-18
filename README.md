# AzerothCore
This is the content I use with my World of Warcraft: Wrath of the Lich King server. The core I use is [AzerothCore](https://github.com/azerothcore/azerothcore-wotlk).

The server is not public, only I play on it and I multibox so things like having group-looted quest items is a must. I use the Bash scripts to manage the server on a few Proxmox Containers running Ubuntu 20.10. The Authserver and Worldserver are run separately so the script is split into two. I also have a few containers specifically for MySQL-databases. They can technically be used on a single machine with some finagling or combined into one for easier use.

While using these Bash scripts and crontab, the server is fully automated. Once a day the server will save and stop, followed by pulling the latest source code, compile it, import the database updates, update the configuration files, import any custom content and then start the server again. The frequency of this happening can be changed by modifying the crontab.

I will create Docker/Podman images to handle all of this in the future.

All respect goes to the amazing people developing the core for us to use.

Everyone is free to use this content for themselves or any public server, but I do not want anyone to take credit for creating it.
