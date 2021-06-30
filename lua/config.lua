ENABLE_ASSISTANT                             = false -- Enable the assistant. If this is set to false, all variables related to the assistant are obsolete
ENABLE_ASSISTANT_EQUIPMENT                   = false -- Enable obtaining a full set of green, quest equivalent, equipment for a specific specalization using the .assistant command
ENABLE_ASSISTANT_EQUIPMENT_LEVEL_UP          = false -- If ENABLE_EQUIPMENT is set to true, this lets the player level up to 80 before accessing equipment
ENABLE_ASSISTANT_EQUIPMENT_MAX_SKILL         = false -- If ENABLE_EQUIPMENT is set to true, this sets skills that are gained through the equipment feature to their max value
ENABLE_ASSISTANT_HEIRLOOMS                   = false -- Enable obtaining heirlooms using the .assistant command
ENABLE_ASSISTANT_GLYPHS                      = false -- Enable obtaining glyphs using the .assistant command
ENABLE_ASSISTANT_GEMS                        = false -- Enable obtaining gems using the .assistant command
ENABLE_ASSISTANT_CONTAINERS                  = false -- Enable obtaining containers using the .assistant command
ASSISTANT_CONTAINER_BAG                      = 23162 -- The container that a player obtains via the assistant
ENABLE_ASSISTANT_UTILITIES                   = false -- Enable obtaining utilities from the .assistant command. The utilities are rename, customize, faction change and race change
ASSISTANT_UTILITIES_COST_RENAME              = 10 -- Utilities: Money required in gold to perform a name change
ASSISTANT_UTILITIES_COST_CUSTOMIZE           = 50 -- Utilities: Money required in gold to perform a customization
ASSISTANT_UTILITIES_COST_FACTION_CHANGE      = 1000 -- Utilities: Money required in gold to perform a faction change
ASSISTANT_UTILITIES_COST_RACE_CHANGE         = 500 -- Utilities: Money required in gold to perform a race change
ENABLE_ASSISTANT_MISCELLANEOUS               = false -- Enable obtaining miscellaneous features from the .assistant command.
ENABLE_MISCELLANOUS_TOTEMS                   = false -- Enable obtaining shaman totems from the miscellaneous option
ENABLE_MISCELLANOUS_UNBIND_INSTANCES         = false -- Enable unbinding 5-man dungeon instances using the .assistant command
INSTANCE_MAP_ID = {
--    Map ID, Difficulty, Name,                                  Allow unbind
    { 574,    1,          "Utgarde Keep",                        false },
    { 575,    1,          "Utgarde Pinnacle",                    false },
    { 576,    1,          "The Nexus",                           false },
    { 578,    1,          "The Oculus",                          false },
    { 595,    1,          "The Culling of Stratholme",           false },
    { 599,    1,          "Halls of Stone",                      false },
    { 600,    1,          "Drak'Tharon Keep",                    false },
    { 601,    1,          "Azjol-Nerub",                         false },
    { 602,    1,          "Halls of Lightning",                  false },
    { 604,    1,          "Gundrak",                             false },
    { 608,    1,          "Violet Hold",                         false },
    { 619,    1,          "Ahn'kahet: The Old Kingdom",          false },
    { 632,    1,          "The Forge of Souls",                  false },
    { 650,    1,          "Trial of the Champion",               false },
    { 658,    1,          "Pit of Saron",                        false },
    { 668,    1,          "Halls of Reflection",                 false },

    { 533,    0,          "Naxxramas 10-Man",                    false },
    { 533,    1,          "Naxxramas 25-Man",                    false },
    { 603,    0,          "Ulduar 10-Man",                       false },
    { 603,    1,          "Ulduar 25-Man",                       false },
    { 615,    0,          "The Obsidian Sanctum 10-Man",         false },
    { 615,    1,          "The Obsidian Sanctum 25-Man",         false },
    { 616,    0,          "The Eye of Eternity 10-Man",          false },
    { 616,    1,          "The Eye of Eternity 25-Man",          false },
    { 624,    0,          "Vault of Archavon 10-Man",            false },
    { 624,    1,          "Vault of Archavon 25-Man",            false },
    { 631,    0,          "Icecrown Citadel 10-Man",             false },
    { 631,    1,          "Icecrown Citadel 25-Man",             false },
    { 631,    2,          "Icecrown Citadel Heroic 10-Man",      false },
    { 631,    3,          "Icecrown Citadel Heroic 25-Man",      false },
    { 649,    0,          "Trial of the Crusader 10-Man",        false },
    { 649,    1,          "Trial of the Crusader 25-Man",        false },
    { 649,    2,          "Trial of the Crusader Heroic 10-Man", false },
    { 649,    3,          "Trial of the Crusader Heroic 25-Man", false },
    { 724,    0,          "The Ruby Sanctum 10-Man",             false },
    { 724,    1,          "The Ruby Sanctum 25-Man",             false },
    { 724,    2,          "The Ruby Sanctum Heroic 10-Man",      false },
    { 724,    3,          "The Ruby Sanctum Heroic 25-Man",      false }
}

ENABLE_PLAYER_LEVEL_MONEY_REWARD             = false -- Give players reward money for reaching specific levels
PLAYER_LEVEL_MONEY_REWARD                    = {
--    Level  Money        Text sent to the player
    { 10,    10 * 10000,  "Congratulations on reaching level 10! Take this gift of gold, let it aid you in your travels." },
    { 20,    25 * 10000,  "Congratulations on reaching level 20! Take this gift of gold, let it aid you in your travels." },
    { 30,    40 * 10000,  "Congratulations on reaching level 30! Take this gift of gold, let it aid you in your travels." },
    { 40,    55 * 10000,  "Congratulations on reaching level 40! Take this gift of gold, let it aid you in your travels." },
    { 50,    70 * 10000,  "Congratulations on reaching level 50! Take this gift of gold, let it aid you in your travels." },
    { 60,    85 * 10000,  "Congratulations on reaching level 60! Take this gift of gold, let it aid you in your travels." },
    { 70,    100 * 10000, "Congratulations on reaching level 70! Take this gift of gold, let it aid you in your travels." },
    { 80,    250 * 10000, "Congratulations on reaching level 80! Take this gift of gold, let it aid you in your travels." },
}

ENABLE_SET_SPAWN_POINT                       = false -- Set spawn point and hearthstone to stormwind for alliance and orgrimmar for horde. Does not include death knight
SET_SPAWN_POINT                              = {
--   X             Y             Z          Orientation Map Area
    {-8830.438477, 626.666199,   93.982887, 0.682076,   0,  1519}, -- Alliance
    {1630.776001,  -4412.993652, 16.567701, 0.080535,   1,  1637} -- Horde
}

ENABLE_SPELLS_ON_LEVEL_UP                    = false -- Automatically learn new spells when leveling up
ENABLE_TALENTS_ON_LEVEL_UP                   = false -- Automatically learn new ranks of talents when leveling up
ENABLE_PROFICIENCY_ON_LEVEL_UP               = false -- Automatically learn new weapon and armor skills when leveling up
ENABLE_APPRENTICE_MOUNT_ON_LEVEL_UP          = false -- Automatically learn 60% riding skill and mount
ENABLE_JOURNEYMAN_MOUNT_ON_LEVEL_UP          = false -- Automatically learn 100% riding skill and mount
ENABLE_EXPERT_MOUNT_ON_LEVEL_UP              = false -- Automatically learn 150% riding skill and mount
ENABLE_ARTISAN_MOUNT_ON_LEVEL_UP             = false -- Automatically learn 300% riding skill and mount
ENABLE_COLD_WEATHER_FLYING_ON_LEVEL_UP       = false -- Automatically learn cold weather flying
ENABLE_MAX_SKILL_ON_LEVEL                    = false -- Set weapon skills to thier maximum value when leveling up
MAX_SKILL_MAX_LEVEL                          = 70 -- Last level when a players skills will be set to their maximum value

ENABLE_EXPERIENCE_MULTIPLIER                 = false -- Enable the experience multiplier
ENABLE_REPUTATION_MULTIPLIER                 = false -- Enable the reputation multiplier
ENABLE_MONEY_LOOT_MULTIPLIER                 = false -- Enable the money loot multiplier
ENABLE_WEEKEND_MULTIPLIER                    = false -- Changes the multiplier on friday, saturday and sunday
WEEKEND_MULTIPLIER                           = 2 -- Multiplier for all rates on weekends
RATE_MULTIPLIER                              = {
--    Min level  Max level  Multiplier
    { 1,         59,        4 },
    { 60,        69,        3 },
    { 70,        79,        2 },
    { 80,        80,        1 },
}
