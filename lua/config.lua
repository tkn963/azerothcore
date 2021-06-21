-- Enabled features
ENABLE_ASSISTANT_EQUIPMENT              = false -- Enable obtaining a full set of green, quest equivalent, equipment for a specific specalization using the .assistant command
ENABLE_ASSISTANT_EQUIPMENT_LEVEL_UP     = false -- If ENABLE_EQUIPMENT is set to true, this lets the player level up to 80 before accessing equipment
ENABLE_ASSISTANT_EQUIPMENT_MAX_SKILL    = false -- If ENABLE_EQUIPMENT is set to true, this sets skills that are gained through the equipment feature to their max value
ENABLE_ASSISTANT_HEIRLOOMS              = false -- Enable obtaining heirlooms using the .assistant command
ENABLE_ASSISTANT_GLYPHS                 = false -- Enable obtaining glyphs using the .assistant command
ENABLE_ASSISTANT_GEMS                   = false -- Enable obtaining gems using the .assistant command
ENABLE_ASSISTANT_CONTAINERS             = false -- Enable obtaining containers using the .assistant command
ENABLE_ASSISTANT_UTILITIES              = false -- Enable obtaining utilities from the .assistant command. The utilities are rename, customize, faction change and race change
ENABLE_ASSISTANT_MISCELLANEOUS          = false -- Enable obtaining miscellaneous features from the .assistant command. Currently this is just a way for shamans to get their totems
ENABLE_PLAYER_LEVEL_MONEY_REWARD        = false -- Give players reward money for reaching specific levels
ENABLE_SPELLS_ON_LEVEL_UP               = false -- Automatically learn new spells when leveling up
ENABLE_TALENTS_ON_LEVEL_UP              = false -- Automatically learn new ranks of talents when leveling up
ENABLE_PROFICIENCY_ON_LEVEL_UP          = false -- Automatically learn new weapon and armor skills when leveling up
ENABLE_MAX_SKILL_ON_LEVEL               = false -- Set weapon skills to thier maximum value when leveling up
MAX_SKILL_MAX_LEVEL                     = 70 -- Last level when a players skills will be set to their maximum value
ENABLE_EXPERIENCE_MULTIPLIER            = false -- Enable the experience multiplier
ENABLE_REPUTATION_MULTIPLIER            = false -- Enable the reputation multiplier
ENABLE_MONEY_LOOT_MULTIPLIER            = false -- Enable the money loot multiplier
ENABLE_WEEKEND_MULTIPLIER               = false -- Changes the multiplier on friday, saturday and sunday
MULTIPLIER_WEEKEND                      = 2 -- Multiplier for all rates on weekends

-- The container that a player obtains via the assistant
ASSISTANT_CONTAINER_BAG                 = 23162 -- Foror's Crate of Endless Resist Gear Storage (36 slot)

-- Required money to perform utilities with the assistant
ASSISTANT_UTILITIES_COST_RENAME         = 10 -- Money required in gold to perform a name change
ASSISTANT_UTILITIES_COST_CUSTOMIZE      = 50 -- Money required in gold to perform a customization
ASSISTANT_UTILITIES_COST_FACTION_CHANGE = 1000 -- Money required in gold to perform a faction change
ASSISTANT_UTILITIES_COST_RACE_CHANGE    = 500 -- Money required in gold to perform a race change

-- Set level and amount of money rewarded. It's modular so you can set your own values
PLAYER_LEVEL_MONEY_REWARD               = {
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

-- Multiplier for specific levels. It's modular so you can set your own level ranges
RATE_MULTIPLIER                         = {
--    Min level  Max level  Multiplier
    { 1,         59,        4 },
    { 60,        69,        3 },
    { 70,        79,        2 },
    { 80,        80,        1 },
}
