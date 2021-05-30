-- Features
local ENABLE_GLYPHS                   = true
local ENABLE_GEMS                     = true
local ENABLE_HEIRLOOMS                = true
local ENABLE_UTILITIES                = true

-- Events
local EVENT_ON_LOGIN                  = 3
local EVENT_ON_GIVE_XP                = 12
local EVENT_ON_MONEY_CHANGE           = 14
local EVENT_ON_REPUTATION_CHANGE      = 15
local EVENT_ON_FIRST_LOGIN            = 30
local EVENT_ON_COMMAND                = 42

-- Teams
local TEAM_ALLIANCE                   = 0
local TEAM_HORDE                      = 1

-- Races
local RACE_HUMAN                      = 1
local RACE_ORC                        = 2
local RACE_DWARF                      = 3
local RACE_NIGHTELF                   = 4
local RACE_UNDEAD                     = 5
local RACE_TAUREN                     = 6
local RACE_GNOME                      = 7
local RACE_TROLL                      = 8
local RACE_BLOODELF                   = 10
local RACE_DRAENEI                    = 11

-- Classes
local CLASS_WARRIOR                   = 1
local CLASS_PALADIN                   = 2
local CLASS_HUNTER                    = 3
local CLASS_ROGUE                     = 4
local CLASS_PRIEST                    = 5
local CLASS_DEATH_KNIGHT              = 6
local CLASS_SHAMAN                    = 7
local CLASS_MAGE                      = 8
local CLASS_WARLOCK                   = 9
local CLASS_DRUID                     = 11

-- Login flags
local AT_LOGIN_RENAME                 = 0x01
local AT_LOGIN_CUSTOMIZE              = 0x08
local AT_LOGIN_CHANGE_FACTION         = 0x40
local AT_LOGIN_CHANGE_RACE            = 0x80

-- Bag slots
local EQUIPMENT_SLOT_BAG1             = 19
local EQUIPMENT_SLOT_BAG2             = 20
local EQUIPMENT_SLOT_BAG3             = 21
local EQUIPMENT_SLOT_BAG4             = 22

-- Gossip icons
local GOSSIP_ICON_CHAT                = 0 -- white chat bubble
local GOSSIP_ICON_VENDOR              = 1 -- brown bag
local GOSSIP_ICON_TAXI                = 2 -- flightmarker (paperplane)
local GOSSIP_ICON_TRAINER             = 3 -- brown book (trainer)
local GOSSIP_ICON_INTERACT_1          = 4 -- golden interaction wheel
local GOSSIP_ICON_MONEY_BAG           = 6 -- brown bag (with gold coin in lower corner)
local GOSSIP_ICON_TALK                = 7 -- white chat bubble (with "..." inside)
local GOSSIP_ICON_TABARD              = 8 -- white tabard
local GOSSIP_ICON_BATTLE              = 9 -- two crossed swords
local GOSSIP_ICON_DOT                 = 10 -- yellow dot/point

-- Bag all characters start with
local INVENTORY_CONTAINER             = 23162

-- Experience, money and reputation rates
local MULTIPLIER_1                    = 4 -- Multiplier for rates level 1-59
local MULTIPLIER_2                    = 3 -- Multiplier for rates level 60-69
local MULTIPLIER_3                    = 2 -- Multiplier for rates level 70-79
local MULTIPLIER_4                    = 1 -- Mutliplier for rates at level 80

-- Required copper values
local COPPER_UTILITIES_RENAME         = 100000 -- Money required in copper to perform a name change
local COPPER_UTILITIES_CUSTOMIZE      = 500000 -- Money required in copper to perform a change of appearance
local COPPER_UTILITIES_FACTION_CHANGE = 10000000 -- Money required in copper to perform a faction change
local COPPER_UTILITIES_RACE_CHANGE    = 5000000 -- Money required in copper to perform a race change

-- Gossip (Select)
local INT_GLYPHS                      = 100
local INT_GEMS                        = 300
local INT_HEIRLOOMS                   = 400
local INT_UTILITIES                   = 500
local INT_RETURN                      = 600

-- When a character enters the world
function onLogin(event, player)
    player:SendBroadcastMessage("This server uses an assistant to aid players. Type .assistant to access this feature.")
end

RegisterPlayerEvent(EVENT_ON_LOGIN, onLogin)

-- When a character gains experience
function onGiveXP(event, player, amount, victim)
    if (player:GetLevel() < 60) then
        return amount * MULTIPLIER_1
    elseif (player:GetLevel() < 70) then
        return amount * MULTIPLIER_2
    elseif (player:GetLevel() < 80) then
        return amount * MULTIPLIER_3
    else
        return amount * MULTIPLIER_4
    end
end

RegisterPlayerEvent(EVENT_ON_GIVE_XP, onGiveXP)

-- When a character gains money
function onMoneyChange(event, player, amount)
    if (player:GetLevel() < 60) then
        return amount * MULTIPLIER_1
    elseif (player:GetLevel() < 70) then
        return amount * MULTIPLIER_2
    elseif (player:GetLevel() < 80) then
        return amount * MULTIPLIER_3
    else
        return amount * MULTIPLIER_4
    end
end

RegisterPlayerEvent(EVENT_ON_MONEY_CHANGE, onMoneyChange)

-- When a character gains reputation
function onReputationChange(event, player, factionId, standing, incremenetal)
    if (player:GetLevel() < 60) then
        return standing * MULTIPLIER_1
    elseif (player:GetLevel() < 70) then
        return standing * MULTIPLIER_2
    elseif (player:GetLevel() < 80) then
        return standing * MULTIPLIER_3
    else
        return standing * MULTIPLIER_4
    end
end

RegisterPlayerEvent(EVENT_ON_REPUTATION_CHANGE, onReputationChange)

-- When a character logs in for the first time
function onFirstLogin(event, player)
    if not (player:GetClass() == CLASS_DEATH_KNIGHT) then
        if (player:GetTeam() == TEAM_ALLIANCE) then
            player:Teleport(0, -8830.438477, 626.666199, 93.982887, 0.682076)
        elseif (player:GetTeam() == TEAM_HORDE) then
            player:Teleport(1, 1630.776001, -4412.993652, 16.567701, 0.080535)
        end
    end

    if (player:GetClass() == CLASS_HUNTER) then
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG2)
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG3)
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG4)
    elseif (player:GetClass() == CLASS_DEATH_KNIGHT) then
        player:AddItem(INVENTORY_CONTAINER, 4)
    else
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG1)
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG2)
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG3)
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG4)
    end
end

RegisterPlayerEvent(EVENT_ON_FIRST_LOGIN, onFirstLogin)

-- When a character performs a command
function onCommand(event, player, command)
    if command == 'assistant' then
        onGossipHello(event, player, player)
        return false
    end
end

RegisterPlayerEvent(EVENT_ON_COMMAND, onCommand)

-- Gossip (Hello)
function onGossipHello(event, player, object)
    player:GossipClearMenu()
    if (ENABLE_GLYPHS) then
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want glyphs", 1, INT_GLYPHS)
    end
    if (ENABLE_GEMS) then
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want gems", 1, INT_GEMS)
    end
    if (ENABLE_HEIRLOOMS) then
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want heirlooms", 1, INT_HEIRLOOMS)
    end
    if (ENABLE_UTILITIES) then
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want utilities", 1, INT_UTILITIES)
    end
    player:GossipSendMenu(0x7FFFFFFF, object, 1)
end

RegisterPlayerGossipEvent(1, 1, onGossipHello)

-- Gossip (Select)
function onGossipSelect(event, player, object, sender, intid, code)
    if (intid == INT_RETURN) then
        onGossipHello(event, player, player)
    elseif (intid == INT_GLYPHS) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some major glyphs", 1, INT_GLYPHS+1, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some minor glyphs", 1, INT_GLYPHS+2, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_RETURN, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_GLYPHS+1) then
        player:GossipClearMenu()

        if (player:GetClass() == CLASS_WARRIOR) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Bloodthirst", 1, INT_GLYPHS+3, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Devastate", 1, INT_GLYPHS+4, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Intervene", 1, INT_GLYPHS+5, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Mortal Strike", 1, INT_GLYPHS+6, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Bladestorm", 1, INT_GLYPHS+7, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Shockwave", 1, INT_GLYPHS+8, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Vigilance", 1, INT_GLYPHS+9, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Enraged Regeneration", 1, INT_GLYPHS+10, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Spell Reflection", 1, INT_GLYPHS+11, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Shield Wall", 1, INT_GLYPHS+12, false, "", 0)
        elseif (player:GetClass() == CLASS_PALADIN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Hammer of Wrath", 1, INT_GLYPHS+13, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Avenging Wrath", 1, INT_GLYPHS+14, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Avenger's Shield", 1, INT_GLYPHS+15, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Holy Wrath", 1, INT_GLYPHS+16, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Seal of Righteousness", 1, INT_GLYPHS+17, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Seal of Vengeance", 1, INT_GLYPHS+18, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Beacon of Light", 1, INT_GLYPHS+19, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Hammer of the Righteous", 1, INT_GLYPHS+20, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Divine Storm", 1, INT_GLYPHS+21, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Shield of Righteousness", 1, INT_GLYPHS+22, false, "", 0)
        elseif (player:GetClass() == CLASS_HUNTER) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Bestial Wrath", 1, INT_GLYPHS+23, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Snake Trap", 1, INT_GLYPHS+24, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Steady Shot", 1, INT_GLYPHS+25, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Trueshot Aura", 1, INT_GLYPHS+26, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Volley", 1, INT_GLYPHS+27, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Wyvern Sting", 1, INT_GLYPHS+28, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Chimera Shot", 1, INT_GLYPHS+29, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Explosive Shot", 1, INT_GLYPHS+30, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Kill Shot", 1, INT_GLYPHS+31, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Explosive Trap", 1, INT_GLYPHS+32, false, "", 0)
        elseif (player:GetClass() == CLASS_ROGUE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|t"..GetItemLink(42954, 0), 1, INT_GLYPHS+33, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|t"..GetItemLink(42959, 0), 1, INT_GLYPHS+34, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|t"..GetItemLink(42971, 0), 1, INT_GLYPHS+35, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|t"..GetItemLink(45761, 0), 1, INT_GLYPHS+36, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|t"..GetItemLink(45762, 0), 1, INT_GLYPHS+37, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|t"..GetItemLink(45764, 0), 1, INT_GLYPHS+38, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|t"..GetItemLink(45766, 0), 1, INT_GLYPHS+39, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|t"..GetItemLink(45767, 0), 1, INT_GLYPHS+40, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|t"..GetItemLink(45768, 0), 1, INT_GLYPHS+41, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|t"..GetItemLink(45769, 0), 1, INT_GLYPHS+42, false, "", 0)
        elseif (player:GetClass() == CLASS_PRIEST) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|t"..GetItemLink(42396, 0), 1, INT_GLYPHS+43, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|t"..GetItemLink(42403, 0), 1, INT_GLYPHS+44, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|t"..GetItemLink(42404, 0), 1, INT_GLYPHS+45, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|t"..GetItemLink(42414, 0), 1, INT_GLYPHS+46, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|t"..GetItemLink(45753, 0), 1, INT_GLYPHS+47, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|t"..GetItemLink(45755, 0), 1, INT_GLYPHS+48, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|t"..GetItemLink(45756, 0), 1, INT_GLYPHS+49, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|t"..GetItemLink(45757, 0), 1, INT_GLYPHS+50, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|t"..GetItemLink(45758, 0), 1, INT_GLYPHS+51, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|t"..GetItemLink(45760, 0), 1, INT_GLYPHS+52, false, "", 0)
        elseif (player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|t"..GetItemLink(43533, 0), 1, INT_GLYPHS+53, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|t"..GetItemLink(43534, 0), 1, INT_GLYPHS+54, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|t"..GetItemLink(43536, 0), 1, INT_GLYPHS+55, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|t"..GetItemLink(43537, 0), 1, INT_GLYPHS+56, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|t"..GetItemLink(43538, 0), 1, INT_GLYPHS+57, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|t"..GetItemLink(43541, 0), 1, INT_GLYPHS+58, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|t"..GetItemLink(43542, 0), 1, INT_GLYPHS+59, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|t"..GetItemLink(43543, 0), 1, INT_GLYPHS+60, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|t"..GetItemLink(43545, 0), 1, INT_GLYPHS+61, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|t"..GetItemLink(43546, 0), 1, INT_GLYPHS+62, false, "", 0)
        elseif (player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|t"..GetItemLink(41517, 0), 1, INT_GLYPHS+63, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|t"..GetItemLink(41524, 0), 1, INT_GLYPHS+64, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|t"..GetItemLink(41529, 0), 1, INT_GLYPHS+65, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|t"..GetItemLink(41538, 0), 1, INT_GLYPHS+66, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|t"..GetItemLink(41539, 0), 1, INT_GLYPHS+67, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|t"..GetItemLink(41552, 0), 1, INT_GLYPHS+68, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|t"..GetItemLink(45770, 0), 1, INT_GLYPHS+69, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|t"..GetItemLink(45771, 0), 1, INT_GLYPHS+70, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|t"..GetItemLink(45772, 0), 1, INT_GLYPHS+71, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|t"..GetItemLink(45775, 0), 1, INT_GLYPHS+72, false, "", 0)
        elseif (player:GetClass() == CLASS_MAGE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|t"..GetItemLink(42736, 0), 1, INT_GLYPHS+73, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|t"..GetItemLink(45736, 0), 1, INT_GLYPHS+74, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|t"..GetItemLink(45737, 0), 1, INT_GLYPHS+75, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|t"..GetItemLink(42748, 0), 1, INT_GLYPHS+76, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|t"..GetItemLink(42745, 0), 1, INT_GLYPHS+77, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|t"..GetItemLink(42751, 0), 1, INT_GLYPHS+78, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|t"..GetItemLink(42754, 0), 1, INT_GLYPHS+79, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|t"..GetItemLink(44684, 0), 1, INT_GLYPHS+80, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|t"..GetItemLink(44955, 0), 1, INT_GLYPHS+81, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|t"..GetItemLink(50045, 0), 1, INT_GLYPHS+82, false, "", 0)
        elseif (player:GetClass() == CLASS_WARLOCK) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|t"..GetItemLink(42454, 0), 1, INT_GLYPHS+83, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|t"..GetItemLink(42457, 0), 1, INT_GLYPHS+84, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|t"..GetItemLink(42459, 0), 1, INT_GLYPHS+85, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|t"..GetItemLink(42463, 0), 1, INT_GLYPHS+86, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|t"..GetItemLink(42472, 0), 1, INT_GLYPHS+87, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|t"..GetItemLink(45779, 0), 1, INT_GLYPHS+88, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|t"..GetItemLink(45780, 0), 1, INT_GLYPHS+89, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|t"..GetItemLink(45781, 0), 1, INT_GLYPHS+90, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|t"..GetItemLink(45782, 0), 1, INT_GLYPHS+91, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|t"..GetItemLink(45783, 0), 1, INT_GLYPHS+92, false, "", 0)
        elseif (player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|t"..GetItemLink(40900, 0), 1, INT_GLYPHS+93, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|t"..GetItemLink(40906, 0), 1, INT_GLYPHS+94, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|t"..GetItemLink(40908, 0), 1, INT_GLYPHS+95, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|t"..GetItemLink(40915, 0), 1, INT_GLYPHS+96, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|t"..GetItemLink(40920, 0), 1, INT_GLYPHS+97, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|t"..GetItemLink(40921, 0), 1, INT_GLYPHS+98, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|t"..GetItemLink(44928, 0), 1, INT_GLYPHS+99, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|t"..GetItemLink(45601, 0), 1, INT_GLYPHS+100, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|t"..GetItemLink(45602, 0), 1, INT_GLYPHS+101, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|t"..GetItemLink(45603, 0), 1, INT_GLYPHS+102, false, "", 0)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_GLYPHS, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_GLYPHS+2) then
        player:GossipClearMenu()

        if (player:GetClass() == CLASS_WARRIOR) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|t"..GetItemLink(43395, 0), 1, INT_GLYPHS+103, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|t"..GetItemLink(43396, 0), 1, INT_GLYPHS+104, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|t"..GetItemLink(43397, 0), 1, INT_GLYPHS+105, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|t"..GetItemLink(43398, 0), 1, INT_GLYPHS+106, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|t"..GetItemLink(43399, 0), 1, INT_GLYPHS+107, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|t"..GetItemLink(43400, 0), 1, INT_GLYPHS+108, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|t"..GetItemLink(49084, 0), 1, INT_GLYPHS+109, false, "", 0)
        elseif (player:GetClass() == CLASS_PALADIN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|t"..GetItemLink(43340, 0), 1, INT_GLYPHS+110, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|t"..GetItemLink(43365, 0), 1, INT_GLYPHS+111, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|t"..GetItemLink(43366, 0), 1, INT_GLYPHS+112, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|t"..GetItemLink(43367, 0), 1, INT_GLYPHS+113, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|t"..GetItemLink(43368, 0), 1, INT_GLYPHS+114, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|t"..GetItemLink(43369, 0), 1, INT_GLYPHS+115, false, "", 0)
        elseif (player:GetClass() == CLASS_HUNTER) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|t"..GetItemLink(43338, 0), 1, INT_GLYPHS+116, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|t"..GetItemLink(43350, 0), 1, INT_GLYPHS+117, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|t"..GetItemLink(43351, 0), 1, INT_GLYPHS+118, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|t"..GetItemLink(43354, 0), 1, INT_GLYPHS+119, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|t"..GetItemLink(43355, 0), 1, INT_GLYPHS+120, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|t"..GetItemLink(43356, 0), 1, INT_GLYPHS+121, false, "", 0)
        elseif (player:GetClass() == CLASS_ROGUE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|t"..GetItemLink(43343, 0), 1, INT_GLYPHS+122, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|t"..GetItemLink(43376, 0), 1, INT_GLYPHS+123, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|t"..GetItemLink(43377, 0), 1, INT_GLYPHS+124, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|t"..GetItemLink(43378, 0), 1, INT_GLYPHS+125, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|t"..GetItemLink(43379, 0), 1, INT_GLYPHS+126, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|t"..GetItemLink(43380, 0), 1, INT_GLYPHS+127, false, "", 0)
        elseif (player:GetClass() == CLASS_PRIEST) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|t"..GetItemLink(43342, 0), 1, INT_GLYPHS+128, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|t"..GetItemLink(43370, 0), 1, INT_GLYPHS+129, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|t"..GetItemLink(43371, 0), 1, INT_GLYPHS+130, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|t"..GetItemLink(43372, 0), 1, INT_GLYPHS+131, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|t"..GetItemLink(43373, 0), 1, INT_GLYPHS+132, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|t"..GetItemLink(43374, 0), 1, INT_GLYPHS+133, false, "", 0)
        elseif (player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|t"..GetItemLink(43535, 0), 1, INT_GLYPHS+134, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|t"..GetItemLink(43539, 0), 1, INT_GLYPHS+135, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|t"..GetItemLink(43544, 0), 1, INT_GLYPHS+136, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|t"..GetItemLink(43671, 0), 1, INT_GLYPHS+137, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|t"..GetItemLink(43672, 0), 1, INT_GLYPHS+138, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|t"..GetItemLink(43673, 0), 1, INT_GLYPHS+139, false, "", 0)
        elseif (player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|t"..GetItemLink(44923, 0), 1, INT_GLYPHS+140, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|t"..GetItemLink(43344, 0), 1, INT_GLYPHS+141, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|t"..GetItemLink(43381, 0), 1, INT_GLYPHS+142, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|t"..GetItemLink(43385, 0), 1, INT_GLYPHS+143, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|t"..GetItemLink(43386, 0), 1, INT_GLYPHS+144, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|t"..GetItemLink(43388, 0), 1, INT_GLYPHS+145, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|t"..GetItemLink(43725, 0), 1, INT_GLYPHS+146, false, "", 0)
        elseif (player:GetClass() == CLASS_MAGE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|t"..GetItemLink(43339, 0), 1, INT_GLYPHS+147, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|t"..GetItemLink(43357, 0), 1, INT_GLYPHS+148, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|t"..GetItemLink(43359, 0), 1, INT_GLYPHS+149, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|t"..GetItemLink(43360, 0), 1, INT_GLYPHS+150, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|t"..GetItemLink(43361, 0), 1, INT_GLYPHS+151, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|t"..GetItemLink(43362, 0), 1, INT_GLYPHS+152, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|t"..GetItemLink(43364, 0), 1, INT_GLYPHS+153, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|t"..GetItemLink(44920, 0), 1, INT_GLYPHS+154, false, "", 0)
        elseif (player:GetClass() == CLASS_WARLOCK) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|t"..GetItemLink(43389, 0), 1, INT_GLYPHS+155, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|t"..GetItemLink(43390, 0), 1, INT_GLYPHS+156, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|t"..GetItemLink(43391, 0), 1, INT_GLYPHS+157, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|t"..GetItemLink(43392, 0), 1, INT_GLYPHS+158, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|t"..GetItemLink(43393, 0), 1, INT_GLYPHS+159, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|t"..GetItemLink(43394, 0), 1, INT_GLYPHS+160, false, "", 0)
        elseif (player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|t"..GetItemLink(43316, 0), 1, INT_GLYPHS+161, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|t"..GetItemLink(43331, 0), 1, INT_GLYPHS+162, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|t"..GetItemLink(43332, 0), 1, INT_GLYPHS+163, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|t"..GetItemLink(43334, 0), 1, INT_GLYPHS+164, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|t"..GetItemLink(43335, 0), 1, INT_GLYPHS+165, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|t"..GetItemLink(43674, 0), 1, INT_GLYPHS+166, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|t"..GetItemLink(44922, 0), 1, INT_GLYPHS+167, false, "", 0)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_GLYPHS, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_GLYPHS+3) then
        player:AddItem(43412)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+4) then
        player:AddItem(43415)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+5) then
        player:AddItem(43419)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+6) then
        player:AddItem(43421)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+7) then
        player:AddItem(45790)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+8) then
        player:AddItem(45792)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+9) then
        player:AddItem(45793)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+10) then
        player:AddItem(45794)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+11) then
        player:AddItem(45795)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+12) then
        player:AddItem(45797)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+13) then
        player:AddItem(41097)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+14) then
        player:AddItem(41107)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+15) then
        player:AddItem(41101)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+16) then
        player:AddItem(43867)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+17) then
        player:AddItem(43868)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+18) then
        player:AddItem(43869)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+19) then
        player:AddItem(45741)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+20) then
        player:AddItem(45742)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+21) then
        player:AddItem(45743)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+22) then
        player:AddItem(45744)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+23) then
        player:AddItem(43412)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+24) then
        player:AddItem(42913)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+25) then
        player:AddItem(42914)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+26) then
        player:AddItem(42915)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+27) then
        player:AddItem(42916)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+28) then
        player:AddItem(42917)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+29) then
        player:AddItem(45625)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+30) then
        player:AddItem(45731)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+31) then
        player:AddItem(45732)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+32) then
        player:AddItem(45733)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GEMS) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some meta gems", 1, INT_GEMS, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some red gems", 1, INT_GEMS, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some blue gems", 1, INT_GEMS, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some yellow gems", 1, INT_GEMS, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some purple gems", 1, INT_GEMS, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some green gems", 1, INT_GEMS, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some orange gems", 1, INT_GEMS, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_RETURN, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_HEIRLOOMS) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some armor", 1, INT_HEIRLOOMS+1, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some weapons", 1, INT_HEIRLOOMS+2, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want something else", 1, INT_HEIRLOOMS+3, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_RETURN, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_HEIRLOOMS+1) then
        player:GossipClearMenu()

        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_30:25:25:-19|tPolished Spaulders of Valor", 1, INT_HEIRLOOMS+4, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_plate03:25:25:-19|tPolished Breastplate of Valor", 1, INT_HEIRLOOMS+5, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_20:25:25:-19|tStrengthened Stockade Pauldrons", 1, INT_HEIRLOOMS+6, false, "", 0)

            if (player:GetClass() == CLASS_PALADIN) then
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_10:25:25:-19|tPristine Lightforge Spaulders", 1, INT_HEIRLOOMS+7, false, "", 0)
            end
        elseif (player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_01:25:25:-19|tChampion Herod's Shoulder", 1, INT_HEIRLOOMS+8, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_chain_07:25:25:-19|tChampion's Deathdealer Breastplate", 1, INT_HEIRLOOMS+9, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_10:25:25:-19|tPrized Beastmaster's Mantle", 1, INT_HEIRLOOMS+10, false, "", 0)
            if (player:GetClass() == CLASS_SHAMAN) then
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_29:25:25:-19|tMystical Pauldrons of Elements", 1, INT_HEIRLOOMS+11, false, "", 0)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_chain_11:25:25:-19|tMystical Vest of Elements", 1, INT_HEIRLOOMS+12, false, "", 0)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_29:25:25:-19|tAged Pauldrons of The Five Thunders", 1, INT_HEIRLOOMS+13, false, "", 0)
            end
        elseif (player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_07:25:25:-19|tStained Shadowcraft Spaulders", 1, INT_HEIRLOOMS+14, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_leather_07:25:25:-19|tStained Shadowcraft Tunic", 1, INT_HEIRLOOMS+15, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_05:25:25:-19|tExceptional Stormshroud Shoulders", 1, INT_HEIRLOOMS+16, false, "", 0)

            if (player:GetClass() == CLASS_DRUID) then
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_06:25:25:-19|tPreened Ironfeather Shoulders", 1, INT_HEIRLOOMS+17, false, "", 0)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_leather_06:25:25:-19|tPreened Ironfeather Breastplate", 1, INT_HEIRLOOMS+18, false, "", 0)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_01:25:25:-19|tLasting Feralheart Spaulders", 1, INT_HEIRLOOMS+19, false, "", 0)
            end
        elseif (player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_misc_bone_taurenskull_01:25:25:-19|tTattered Dreadmist Mantle", 1, INT_HEIRLOOMS+20, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_cloth_49:25:25:-19|tTattered Dreadmist Robe", 1, INT_HEIRLOOMS+21, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_02:25:25:-19|tExquisite Sunderseer Mantle", 1, INT_HEIRLOOMS+22, false, "", 0)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_ring_39:25:25:-19|tDread Pirate Ring", 1, INT_HEIRLOOMS+23, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_talisman_01:25:25:-19|tSwift Hand of Justice", 1, INT_HEIRLOOMS+24, false, "", 0)

        if (player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_talisman_08:25:25:-19|tDiscerning Eye of the Beast", 1, INT_HEIRLOOMS+25, false, "", 0)
        end

        if (player:GetTeam() == TEAM_ALLIANCE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_trinketpvp_01:25:25:-19|tInherited Insignia of the Alliance", 1, INT_HEIRLOOMS+26, false, "", 0)
        elseif (player:GetTeam() == TEAM_HORDE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_trinketpvp_02:25:25:-19|tInherited Insignia of the Horde", 1, INT_HEIRLOOMS+27, false, "", 0)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_HEIRLOOMS, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_HEIRLOOMS+2) then
        player:GossipClearMenu()

        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_axe_09:25:25:-19|tBloodied Arcanite Reaper", 1, INT_HEIRLOOMS+28, false, "", 0)
        end
        if (player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_17:25:25:-19|tBalanced Heartseeker", 1, INT_HEIRLOOMS+29, false, "", 0)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_43:25:25:-19|tVenerable Dal'Rend's Sacred Charge", 1, INT_HEIRLOOMS+30, false, "", 0)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_weapon_bow_08:25:25:-19|tCharmed Ancient Bone Bow", 1, INT_HEIRLOOMS+31, false, "", 0)
        end
        if (player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_talisman_12:25:25:-19|tDignified Headmaster's Charge", 1, INT_HEIRLOOMS+32, false, "", 0)
        end
        if (player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_hammer_05:25:25:-19|tDevout Aurastone Hammer", 1, INT_HEIRLOOMS+33, false, "", 0)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_weapon_shortblade_03:25:25:-19|tSharpened Scarlet Kris", 1, INT_HEIRLOOMS+34, false, "", 0)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_19:25:25:-19|tReforged Truesilver Champion", 1, INT_HEIRLOOMS+35, false, "", 0)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_weapon_rifle_09:25:25:-19|tUpgraded Dwarven Hand Cannon", 1, INT_HEIRLOOMS+36, false, "", 0)
        end
        if (player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_hammer_07:25:25:-19|tThe Blessed Hammer of Grace", 1, INT_HEIRLOOMS+37, false, "", 0)
        end
        if (player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_staff_13:25:25:-19|tGrand Staff of Jordan", 1, INT_HEIRLOOMS+38, false, "", 0)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_DEATH_KNIGHT or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_36:25:25:-19|tBattleworn Thrash Blade", 1, INT_HEIRLOOMS+39, false, "", 0)
        end
        if (player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_hammer_17:25:25:-19|tVenerable Mass of McGowan", 1, INT_HEIRLOOMS+40, false, "", 0)
        end
        if (player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_gizmo_02:25:25:-19|tRepurposed Lava Dredger", 1, INT_HEIRLOOMS+41, false, "", 0)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_HEIRLOOMS, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_HEIRLOOMS+3) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_misc_book_11:25:25:-19|tTome of Cold Weather Flight", 1, INT_HEIRLOOMS+42, false, "Do you wish to continue the transaction?", 10000000)
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_HEIRLOOMS, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_HEIRLOOMS+4) then
        player:AddItem(42949)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+5) then
        player:AddItem(48685)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+6) then
        player:AddItem(44099)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+7) then
        player:AddItem(44100)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+8) then
        player:AddItem(42950)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+9) then
        player:AddItem(48677)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+10) then
        player:AddItem(44101)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+11) then
        player:AddItem(42951)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+12) then
        player:AddItem(48683)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+13) then
        player:AddItem(44102)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+14) then
        player:AddItem(42952)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+15) then
        player:AddItem(48689)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+16) then
        player:AddItem(44103)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+17) then
        player:AddItem(42984)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+18) then
        player:AddItem(48687)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+19) then
        player:AddItem(44105)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+20) then
        player:AddItem(42985)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+21) then
        player:AddItem(48691)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+22) then
        player:AddItem(44107)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+23) then
        player:AddItem(50255)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+24) then
        player:AddItem(42991)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+25) then
        player:AddItem(42992)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+26) then
        player:AddItem(44098)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+27) then
        player:AddItem(44097)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+1, code)
    elseif (intid == INT_HEIRLOOMS+28) then
        player:AddItem(42943)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+29) then
        player:AddItem(42944)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+30) then
        player:AddItem(42945)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+31) then
        player:AddItem(42946)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+32) then
        player:AddItem(42947)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+33) then
        player:AddItem(42948)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+34) then
        player:AddItem(44091)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+35) then
        player:AddItem(44092)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+36) then
        player:AddItem(44093)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+37) then
        player:AddItem(44094)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+38) then
        player:AddItem(44095)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+39) then
        player:AddItem(44096)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+40) then
        player:AddItem(48716)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+41) then
        player:AddItem(48718)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+2, code)
    elseif (intid == INT_HEIRLOOMS+42) then
        player:ModifyMoney(-10000000)
        player:AddItem(49177)
        onGossipSelect(event, player, object, sender, INT_HEIRLOOMS+3, code)
    elseif (intid == INT_UTILITIES) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_MONEY_BAG, "I want to change my name", 1, INT_UTILITIES+1, false, "Do you wish to continue the transaction?", COPPER_UTILITIES_RENAME)
        player:GossipMenuAddItem(GOSSIP_ICON_MONEY_BAG, "I want to change my appearance", 1, INT_UTILITIES+2, false, "Do you wish to continue the transaction?", COPPER_UTILITIES_CUSTOMIZE)
        player:GossipMenuAddItem(GOSSIP_ICON_MONEY_BAG, "I want to change my faction", 1, INT_UTILITIES+3, false, "Do you wish to continue the transaction?", COPPER_UTILITIES_FACTION_CHANGE)
        player:GossipMenuAddItem(GOSSIP_ICON_MONEY_BAG, "I want to change my race", 1, INT_UTILITIES+4, false, "Do you wish to continue the transaction?", COPPER_UTILITIES_RACE_CHANGE)
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_RETURN, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_UTILITIES+1) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            player:GossipComplete()
        else
            player:ModifyMoney(-COPPER_UTILITIES_RENAME)
            player:SetAtLoginFlag(AT_LOGIN_RENAME)
            player:SendBroadcastMessage("You can now log out to apply the name change.")
            player:GossipComplete()
        end
    elseif (intid == INT_UTILITIES+2) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            player:GossipComplete()
        else
            player:ModifyMoney(-COPPER_UTILITIES_CUSTOMIZE)
            player:SetAtLoginFlag(AT_LOGIN_CUSTOMIZE)
            player:SendBroadcastMessage("You can now log out to apply the customization.")
            player:GossipComplete()
        end
    elseif (intid == INT_UTILITIES+3) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            player:GossipComplete()
        else
            player:ModifyMoney(-COPPER_UTILITIES_FACTION_CHANGE)
            player:SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION)
            player:SendBroadcastMessage("You can now log out to apply the faction change.")
            player:GossipComplete()
        end
    elseif (intid == INT_UTILITIES+4) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            player:GossipComplete()
        else
            player:ModifyMoney(-COPPER_UTILITIES_RACE_CHANGE)
            player:SetAtLoginFlag(AT_LOGIN_CHANGE_RACE)
            player:SendBroadcastMessage("You can now log out to apply the race change.")
            player:GossipComplete()
        end
    end
end

RegisterPlayerGossipEvent(1, 2, onGossipSelect)
