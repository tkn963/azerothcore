#!/bin/bash
ROOT=$(pwd)

CONFIG_FILE="ac.xml"
MYSQL_CONFIG="$ROOT/mysql.cnf"

if [ ! -f $ROOT/$CONFIG_FILE ]; then
    clear
    echo -e "\e[0;33mGenerating default configuration\e[0m"
    echo "<?xml version=\"1.0\"?><config><mysql><hostname>127.0.0.1</hostname> <!-- Hostname --><port>3306</port><username>acore</username><password>acore</password><database><auth>acore_auth</auth><characters>acore_characters</characters><world>acore_world</world></database></mysql><core><directory>/opt/azerothcore</directory></core><world><name>AzerothCore</name><motd>Welcome to AzerothCore!</motd><id>1</id><ip>127.0.0.1</ip><game_type>1</game_type><realm_zone>8</realm_zone><player_limit>1000</player_limit><skip_cinematics>0</skip_cinematics><start_level>1</start_level><start_money>0</start_money><always_max_skill>0</always_max_skill><all_flight_paths>0</all_flight_paths><maps_explored>0</maps_explored><allow_commands>0</allow_commands><quest_ignore_raid>0</quest_ignore_raid><prevent_afk_logout>0</prevent_afk_logout><raf_max_level>60</raf_max_level><preload_map_grids>false</preload_map_grids><set_all_waypoints_active>false</set_all_waypoints_active><allow_lfg_lootmode>false</allow_lfg_lootmode><rates><experience>1</experience><rested_exp>1</rested_exp><reputation>1</reputation><money>1</money><crafting>1</crafting><gathering>1</gathering><weapon_skill>1</weapon_skill><defense_skill>1</defense_skill></rates><gm><login_state>1</login_state><visible>0</visible><chat>0</chat><whisper>0</whisper><gm_list>0</gm_list><who_list>0</who_list><allow_friend>0</allow_friend><allow_invite>0</allow_invite><lower_security>0</lower_security></gm></world><module><ahbot><enabled>false</enabled><enable_seller>0</enable_seller><enable_buyer>0</enable_buyer><account_id>1</account_id><character_guid>1</character_guid><min_items>250</min_items><max_items>250</max_items></ahbot><skip_dk_area><enabled>false</enabled></skip_dk_area><kickstarter><enabled>false</enabled><functions><equipment>1</equipment><gems>1</gems><glyphs>1</glyphs><spells>1</spells><proficiency><enabled>1</enabled><max_skill>1</max_skill></proficiency><mounts>1</mounts><utilities><enabled>1</enabled><name_change>1</name_change><race_change>1</race_change><faction_change>1</faction_change><appearance_change>1</appearance_change></utilities></functions></kickstarter><experienced><enabled>false</enabled></experienced></module></config>" | xmllint --format - > $ROOT/$CONFIG_FILE
    exit 1
fi

AZEROTHCORE_URL="https://github.com/azerothcore/azerothcore-wotlk.git"
AZEROTHCORE_BRANCH="master"
MODULE_AHBOT_URL="https://github.com/azerothcore/mod-ah-bot.git"
MODULE_AHBOT_BRANCH="master"
MODULE_SKIPDKAREA_URL="https://github.com/Crypticaz/SkipDeathKnightStartingArea.git"
MODULE_SKIPDKAREA_BRANCH="master"
MODULE_KICKSTARTER_URL="https://github.com/tkn963/kickstarter.git"
MODULE_KICKSTARTER_BRANCH="main"
MODULE_EXPERIENCED_URL="https://github.com/tkn963/experienced.git"
MODULE_EXPERIENCED_BRANCH="main"

CLIENT_DATA="https://github.com/wowgaming/client-data/releases/download/v10/data.zip"

MYSQL_HOSTNAME="$(echo "cat /config/mysql/hostname/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MYSQL_PORT="$(echo "cat /config/mysql/port/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MYSQL_USERNAME="$(echo "cat /config/mysql/username/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MYSQL_PASSWORD="$(echo "cat /config/mysql/password/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MYSQL_DATABASE_AUTH="$(echo "cat /config/mysql/database/auth/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MYSQL_DATABASE_CHARACTERS="$(echo "cat /config/mysql/database/characters/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MYSQL_DATABASE_WORLD="$(echo "cat /config/mysql/database/world/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"

CORE_DIRECTORY="$(echo "cat /config/core/directory/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"

WORLD_NAME="$(echo "cat /config/world/name/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_MOTD="$(echo "cat /config/world/motd/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_ID="$(echo "cat /config/world/id/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_IP="$(echo "cat /config/world/ip/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_GAME_TYPE="$(echo "cat /config/world/game_type/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_REALM_ZONE="$(echo "cat /config/world/realm_zone/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_EXPANSION="$(echo "cat /config/world/expansion/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_PLAYER_LIMIT="$(echo "cat /config/world/player_limit/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_SKIP_CINEMATICS="$(echo "cat /config/world/skip_cinematics/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_MAX_LEVEL="$(echo "cat /config/world/max_level/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_START_LEVEL="$(echo "cat /config/world/start_level/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_START_MONEY="$(echo "cat /config/world/start_money/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_ALWAYS_MAX_SKILL="$(echo "cat /config/world/always_max_skill/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_ALL_FLIGHT_PATHS="$(echo "cat /config/world/all_flight_paths/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_MAPS_EXPLORED="$(echo "cat /config/world/maps_explored/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_ALLOW_COMMANDS="$(echo "cat /config/world/allow_commands/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_QUEST_IGNORE_RAID="$(echo "cat /config/world/quest_ignore_raid/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_PREVENT_AFK_LOGOUT="$(echo "cat /config/world/prevent_afk_logout/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_RAF_MAX_LEVEL="$(echo "cat /config/world/raf_max_level/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_PRELOAD_MAP_GRIDS="$(echo "cat /config/world/preload_map_grids/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_SET_WAYPOINTS_ACTIVE="$(echo "cat /config/world/set_all_waypoints_active/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_ALLOW_LFG_LOOTMODE="$(echo "cat /config/world/allow_lfg_lootmode/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_RATE_EXPERIENCE="$(echo "cat /config/world/rates/experience/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_RATE_RESTED_EXP="$(echo "cat /config/world/rates/rested_exp/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_RATE_REPUTATION="$(echo "cat /config/world/rates/reputation/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_RATE_MONEY="$(echo "cat /config/world/rates/money/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_RATE_CRAFTING="$(echo "cat /config/world/rates/crafting/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_RATE_GATHERING="$(echo "cat /config/world/rates/gathering/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_RATE_WEAPON_SKILL="$(echo "cat /config/world/rates/weapon_skill/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_RATE_DEFENSE_SKILL="$(echo "cat /config/world/rates/defense_skill/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_GM_LOGIN_STATE="$(echo "cat /config/world/gm/login_state/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_GM_VISIBLE="$(echo "cat /config/world/gm/visible/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_GM_CHAT="$(echo "cat /config/world/gm/chat/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_GM_WHISPER="$(echo "cat /config/world/gm/whisper/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_GM_GM_LIST="$(echo "cat /config/world/gm/gm_list/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_GM_WHO_LIST="$(echo "cat /config/world/gm/who_list/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_GM_ALLOW_FRIEND="$(echo "cat /config/world/gm/allow_friend/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_GM_ALLOW_INVITE="$(echo "cat /config/world/gm/allow_invite/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
WORLD_GM_LOWER_SECURITY="$(echo "cat /config/world/gm/lower_security/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"

MODULE_AHBOT_ENABLED="$(echo "cat /config/module/ahbot/enabled/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_AHBOT_ENABLE_SELLER="$(echo "cat /config/module/ahbot/enable_seller/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_AHBOT_ENABLE_BUYER="$(echo "cat /config/module/ahbot/enable_buyer/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_AHBOT_ACCOUNT_ID="$(echo "cat /config/module/ahbot/account_id/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_AHBOT_CHARACTER_GUID="$(echo "cat /config/module/ahbot/character_guid/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_AHBOT_MIN_ITEMS="$(echo "cat /config/module/ahbot/min_items/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_AHBOT_MAX_ITEMS="$(echo "cat /config/module/ahbot/max_items/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"

MODULE_SKIP_DK_AREA_ENABLED="$(echo "cat /config/module/skip_dk_area/enabled/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"

MODULE_KICKSTARTER_ENABLED="$(echo "cat /config/module/kickstarter/enabled/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_EQUIPMENT="$(echo "cat /config/module/kickstarter/functions/equipment/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_GEMS="$(echo "cat /config/module/kickstarter/functions/gems/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_GLYPHS="$(echo "cat /config/module/kickstarter/functions/glyphs/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_SPELLS="$(echo "cat /config/module/kickstarter/functions/spells/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_PROFICIENCY_ENABLED="$(echo "cat /config/module/kickstarter/functions/proficiency/enabled/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_PROFICIENCY_MAX_SKILL="$(echo "cat /config/module/kickstarter/functions/proficiency/max_skill/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_MOUNTS="$(echo "cat /config/module/kickstarter/functions/mounts/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_ENABLED="$(echo "cat /config/module/kickstarter/functions/utilities/enabled/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_NAME_CHANGE="$(echo "cat /config/module/kickstarter/functions/utilities/name_change/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_RACE_CHANGE="$(echo "cat /config/module/kickstarter/functions/utilities/race_change/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_FACTION_CHANGE="$(echo "cat /config/module/kickstarter/functions/utilities/faction_change/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"
MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_APPEARANCE_CHANGE="$(echo "cat /config/module/kickstarter/functions/utilities/appearance_change/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"

MODULE_EXPERIENCED_ENABLED="$(echo "cat /config/module/experienced/enabled/text()" | xmllint --nocdata --shell $ROOT/$CONFIG_FILE | sed '1d;$d')"

if [[ -z $MYSQL_HOSTNAME ]] || [[ $MYSQL_HOSTNAME == "" ]] || 
   [[ -z $MYSQL_PORT ]] || [[ $MYSQL_PORT == "" ]] || 
   [[ -z $MYSQL_USERNAME ]] || [[ $MYSQL_USERNAME == "" ]] || 
   [[ -z $MYSQL_PASSWORD ]] || [[ $MYSQL_PASSWORD == "" ]] || 
   [[ -z $MYSQL_DATABASE_AUTH ]] || [[ $MYSQL_DATABASE_AUTH == "" ]] || 
   [[ -z $MYSQL_DATABASE_CHARACTERS ]] || [[ $MYSQL_DATABASE_CHARACTERS == "" ]] || 
   [[ -z $MYSQL_DATABASE_WORLD ]] || [[ $MYSQL_DATABASE_WORLD == "" ]] || 
   [[ -z $CORE_DIRECTORY ]] || [[ $CORE_DIRECTORY == "" ]] || 
   [[ -z $WORLD_NAME ]] || [[ $WORLD_NAME == "" ]] || 
   [[ -z $WORLD_MOTD ]] || [[ $WORLD_MOTD == "" ]] || 
   [[ -z $WORLD_ID ]] || [[ $WORLD_ID == "" ]] || 
   [[ -z $WORLD_IP ]] || [[ $WORLD_IP == "" ]] || 
   [[ -z $WORLD_GAME_TYPE ]] || [[ $WORLD_GAME_TYPE == "" ]] || 
   [[ -z $WORLD_REALM_ZONE ]] || [[ $WORLD_REALM_ZONE == "" ]] || 
   [[ -z $WORLD_EXPANSION ]] || [[ $WORLD_EXPANSION == "" ]] || 
   [[ -z $WORLD_PLAYER_LIMIT ]] || [[ $WORLD_PLAYER_LIMIT == "" ]] || 
   [[ -z $WORLD_SKIP_CINEMATICS ]] || [[ $WORLD_SKIP_CINEMATICS == "" ]] || 
   [[ -z $WORLD_MAX_LEVEL ]] || [[ $WORLD_MAX_LEVEL == "" ]] || 
   [[ -z $WORLD_START_LEVEL ]] || [[ $WORLD_START_LEVEL == "" ]] || 
   [[ -z $WORLD_START_MONEY ]] || [[ $WORLD_START_MONEY == "" ]] || 
   [[ -z $WORLD_ALWAYS_MAX_SKILL ]] || [[ $WORLD_ALWAYS_MAX_SKILL == "" ]] || 
   [[ -z $WORLD_ALL_FLIGHT_PATHS ]] || [[ $WORLD_ALL_FLIGHT_PATHS == "" ]] || 
   [[ -z $WORLD_MAPS_EXPLORED ]] || [[ $WORLD_MAPS_EXPLORED == "" ]] || 
   [[ -z $WORLD_ALLOW_COMMANDS ]] || [[ $WORLD_ALLOW_COMMANDS == "" ]] || 
   [[ -z $WORLD_QUEST_IGNORE_RAID ]] || [[ $WORLD_QUEST_IGNORE_RAID == "" ]] || 
   [[ -z $WORLD_PREVENT_AFK_LOGOUT ]] || [[ $WORLD_PREVENT_AFK_LOGOUT == "" ]] || 
   [[ -z $WORLD_RAF_MAX_LEVEL ]] || [[ $WORLD_RAF_MAX_LEVEL == "" ]] || 
   [[ -z $WORLD_PRELOAD_MAP_GRIDS ]] || [[ $WORLD_PRELOAD_MAP_GRIDS == "" ]] || 
   [[ -z $WORLD_SET_WAYPOINTS_ACTIVE ]] || [[ $WORLD_SET_WAYPOINTS_ACTIVE == "" ]] || 
   [[ -z $WORLD_ALLOW_LFG_LOOTMODE ]] || [[ $WORLD_ALLOW_LFG_LOOTMODE == "" ]] || 
   [[ -z $WORLD_RATE_EXPERIENCE ]] || [[ $WORLD_RATE_EXPERIENCE == "" ]] || 
   [[ -z $WORLD_RATE_RESTED_EXP ]] || [[ $WORLD_RATE_RESTED_EXP == "" ]] || 
   [[ -z $WORLD_RATE_REPUTATION ]] || [[ $WORLD_RATE_REPUTATION == "" ]] || 
   [[ -z $WORLD_RATE_MONEY ]] || [[ $WORLD_RATE_MONEY == "" ]] || 
   [[ -z $WORLD_RATE_CRAFTING ]] || [[ $WORLD_RATE_CRAFTING == "" ]] || 
   [[ -z $WORLD_RATE_GATHERING ]] || [[ $WORLD_RATE_GATHERING == "" ]] || 
   [[ -z $WORLD_RATE_WEAPON_SKILL ]] || [[ $WORLD_RATE_WEAPON_SKILL == "" ]] || 
   [[ -z $WORLD_RATE_DEFENSE_SKILL ]] || [[ $WORLD_RATE_DEFENSE_SKILL == "" ]] || 
   [[ -z $WORLD_GM_LOGIN_STATE ]] || [[ $WORLD_GM_LOGIN_STATE == "" ]] || 
   [[ -z $WORLD_GM_VISIBLE ]] || [[ $WORLD_GM_VISIBLE == "" ]] || 
   [[ -z $WORLD_GM_CHAT ]] || [[ $WORLD_GM_CHAT == "" ]] || 
   [[ -z $WORLD_GM_WHISPER ]] || [[ $WORLD_GM_WHISPER == "" ]] || 
   [[ -z $WORLD_GM_GM_LIST ]] || [[ $WORLD_GM_GM_LIST == "" ]] || 
   [[ -z $WORLD_GM_WHO_LIST ]] || [[ $WORLD_GM_WHO_LIST == "" ]] || 
   [[ -z $WORLD_GM_ALLOW_FRIEND ]] || [[ $WORLD_GM_ALLOW_FRIEND == "" ]] || 
   [[ -z $WORLD_GM_ALLOW_INVITE ]] || [[ $WORLD_GM_ALLOW_INVITE == "" ]] || 
   [[ -z $WORLD_GM_LOWER_SECURITY ]] || [[ $WORLD_GM_LOWER_SECURITY == "" ]] || 
   [[ -z $MODULE_AHBOT_ENABLED ]] || [[ $MODULE_AHBOT_ENABLED == "" ]] || 
   [[ -z $MODULE_AHBOT_ENABLE_SELLER ]] || [[ $MODULE_AHBOT_ENABLE_SELLER == "" ]] || 
   [[ -z $MODULE_AHBOT_ENABLE_BUYER ]] || [[ $MODULE_AHBOT_ENABLE_BUYER == "" ]] || 
   [[ -z $MODULE_AHBOT_ACCOUNT_ID ]] || [[ $MODULE_AHBOT_ACCOUNT_ID == "" ]] || 
   [[ -z $MODULE_AHBOT_CHARACTER_GUID ]] || [[ $MODULE_AHBOT_CHARACTER_GUID == "" ]] || 
   [[ -z $MODULE_AHBOT_MIN_ITEMS ]] || [[ $MODULE_AHBOT_MIN_ITEMS == "" ]] || 
   [[ -z $MODULE_AHBOT_MAX_ITEMS ]] || [[ $MODULE_AHBOT_MAX_ITEMS == "" ]] || 
   [[ -z $MODULE_SKIP_DK_AREA_ENABLED ]] || [[ $MODULE_SKIP_DK_AREA_ENABLED == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_ENABLED ]] || [[ $MODULE_KICKSTARTER_ENABLED == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_EQUIPMENT ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_EQUIPMENT == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_GEMS ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_GEMS == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_GLYPHS ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_GLYPHS == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_SPELLS ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_SPELLS == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_PROFICIENCY_ENABLED ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_PROFICIENCY_ENABLED == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_PROFICIENCY_MAX_SKILL ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_PROFICIENCY_MAX_SKILL == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_MOUNTS ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_MOUNTS == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_ENABLED ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_ENABLED == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_NAME_CHANGE ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_NAME_CHANGE == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_RACE_CHANGE ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_RACE_CHANGE == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_FACTION_CHANGE ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_FACTION_CHANGE == "" ]] || 
   [[ -z $MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_APPEARANCE_CHANGE ]] || [[ $MODULE_KICKSTARTER_FUNCTIONS_UTILITIES_APPEARANCE_CHANGE == "" ]] || 
   [[ -z $MODULE_EXPERIENCED_ENABLED ]]; then
    clear
    echo -e "\e[0;31mAtleast one of the configuration options is missing or invalid\e[0m"
    exit 1
fi
