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
local INT_GEMS                        = 200
local INT_HEIRLOOMS                   = 300
local INT_UTILITIES                   = 400
local INT_RETURN                      = 1000

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
    player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want glyphs", 1, INT_GLYPHS)
    player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want gems", 1, INT_GEMS)
    player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want heirlooms", 1, INT_HEIRLOOMS)
    player:GossipMenuAddItem(GOSSIP_ICON_TALK, "What utilities can I get?", 1, INT_UTILITIES)
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
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|t"..GetItemLink(43412, 0), 1, INT_GLYPHS+3, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|t"..GetItemLink(43415, 0), 1, INT_GLYPHS+4, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|t"..GetItemLink(43419, 0), 1, INT_GLYPHS+5, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|t"..GetItemLink(43421, 0), 1, INT_GLYPHS+6, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|t"..GetItemLink(45790, 0), 1, INT_GLYPHS+7, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|t"..GetItemLink(45792, 0), 1, INT_GLYPHS+8, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|t"..GetItemLink(45793, 0), 1, INT_GLYPHS+9, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|t"..GetItemLink(45794, 0), 1, INT_GLYPHS+10, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|t"..GetItemLink(45795, 0), 1, INT_GLYPHS+11, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|t"..GetItemLink(45797, 0), 1, INT_GLYPHS+12, false, "", 0)
        elseif (player:GetClass() == CLASS_PALADIN) then
        elseif (player:GetClass() == CLASS_HUNTER) then
        elseif (player:GetClass() == CLASS_ROGUE) then
        elseif (player:GetClass() == CLASS_PRIEST) then
        elseif (player:GetClass() == CLASS_DEATH_KNIGHT) then
        elseif (player:GetClass() == CLASS_SHAMAN) then
        elseif (player:GetClass() == CLASS_MAGE) then
        elseif (player:GetClass() == CLASS_WARLOCK) then
        elseif (player:GetClass() == CLASS_DRUID) then
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_GLYPHS, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_GLYPHS+2) then
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
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_30:25:25:-19|t"..GetItemLink(42949, 0), 1, INT_HEIRLOOMS+4, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_plate03:25:25:-19|t"..GetItemLink(48685, 0), 1, INT_HEIRLOOMS+5, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_20:25:25:-19|t"..GetItemLink(44099, 0), 1, INT_HEIRLOOMS+6, false, "", 0)

            if (player:GetClass() == CLASS_PALADIN) then
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_10:25:25:-19|t"..GetItemLink(44100, 0), 1, INT_HEIRLOOMS+7, false, "", 0)
            end
        elseif (player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_01:25:25:-19|t"..GetItemLink(42950, 0), 1, INT_HEIRLOOMS+8, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_chain_07:25:25:-19|t"..GetItemLink(48677, 0), 1, INT_HEIRLOOMS+9, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_10:25:25:-19|t"..GetItemLink(44101, 0), 1, INT_HEIRLOOMS+10, false, "", 0)
            if (player:GetClass() == CLASS_SHAMAN) then
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_29:25:25:-19|t"..GetItemLink(42951, 0), 1, INT_HEIRLOOMS+11, false, "", 0)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_chain_11:25:25:-19|t"..GetItemLink(48683, 0), 1, INT_HEIRLOOMS+12, false, "", 0)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_29:25:25:-19|t"..GetItemLink(44102, 0), 1, INT_HEIRLOOMS+13, false, "", 0)
            end
        elseif (player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_07:25:25:-19|t"..GetItemLink(42952, 0), 1, INT_HEIRLOOMS+14, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_leather_07:25:25:-19|t"..GetItemLink(48689, 0), 1, INT_HEIRLOOMS+15, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_05:25:25:-19|t"..GetItemLink(44103, 0), 1, INT_HEIRLOOMS+16, false, "", 0)

            if (player:GetClass() == CLASS_DRUID) then
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_06:25:25:-19|t"..GetItemLink(42984, 0), 1, INT_HEIRLOOMS+17, false, "", 0)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_leather_06:25:25:-19|t"..GetItemLink(48687, 0), 1, INT_HEIRLOOMS+18, false, "", 0)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_01:25:25:-19|t"..GetItemLink(44105, 0), 1, INT_HEIRLOOMS+19, false, "", 0)
            end
        elseif (player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_misc_bone_taurenskull_01:25:25:-19|t"..GetItemLink(42985, 0), 1, INT_HEIRLOOMS+20, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_cloth_49:25:25:-19|t"..GetItemLink(48691, 0), 1, INT_HEIRLOOMS+21, false, "", 0)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_02:25:25:-19|t"..GetItemLink(44107, 0), 1, INT_HEIRLOOMS+22, false, "", 0)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_ring_39:25:25:-19|t"..GetItemLink(50255, 0), 1, INT_HEIRLOOMS+23, false, "", 0)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_talisman_01:25:25:-19|t"..GetItemLink(42991, 0), 1, INT_HEIRLOOMS+24, false, "", 0)

        if (player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_talisman_08:25:25:-19|t"..GetItemLink(42992, 0), 1, INT_HEIRLOOMS+25, false, "", 0)
        end

        if (player:GetTeam() == TEAM_ALLIANCE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_trinketpvp_01:25:25:-19|t"..GetItemLink(44098, 0), 1, INT_HEIRLOOMS+26, false, "", 0)
        elseif (player:GetTeam() == TEAM_HORDE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_trinketpvp_02:25:25:-19|t"..GetItemLink(44097, 0), 1, INT_HEIRLOOMS+27, false, "", 0)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_HEIRLOOMS, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_HEIRLOOMS+2) then
        player:GossipClearMenu()

        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_axe_09:25:25:-19|t"..GetItemLink(42943, 0), 1, INT_HEIRLOOMS+28, false, "", 0) -- Warrior, Paladin, Death Knight
        end
        if (player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_17:25:25:-19|t"..GetItemLink(42944, 0), 1, INT_HEIRLOOMS+29, false, "", 0) -- Hunter, Rogue, Shaman
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_43:25:25:-19|t"..GetItemLink(42945, 0), 1, INT_HEIRLOOMS+30, false, "", 0) -- Warrior, Paladin, Hunter, Rogue, Death Knight
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_weapon_bow_08:25:25:-19|t"..GetItemLink(42946, 0), 1, INT_HEIRLOOMS+31, false, "", 0) -- Warrior, Hunter, Rogue
        end
        if (player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_talisman_12:25:25:-19|t"..GetItemLink(42947, 0), 1, INT_HEIRLOOMS+32, false, "", 0) -- Priest, Shaman, Mage, Warlock, Druid
        end
        if (player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_hammer_05:25:25:-19|t"..GetItemLink(42948, 0), 1, INT_HEIRLOOMS+33, false, "", 0) -- Paladin, Priest, Shaman, Druid
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_weapon_shortblade_03:25:25:-19|t"..GetItemLink(44091, 0), 1, INT_HEIRLOOMS+34, false, "", 0) -- Warrior, Hunter, Rogue, Shaman
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_19:25:25:-19|t"..GetItemLink(44092, 0), 1, INT_HEIRLOOMS+35, false, "", 0) -- Warrior, Paladin, Death Knight
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_weapon_rifle_09:25:25:-19|t"..GetItemLink(44093, 0), 1, INT_HEIRLOOMS+36, false, "", 0) -- Warrior, Hunter, Rogue
        end
        if (player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_hammer_07:25:25:-19|t"..GetItemLink(44094, 0), 1, INT_HEIRLOOMS+37, false, "", 0) -- Paladin, Priest, Shaman, Druid
        end
        if (player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_staff_13:25:25:-19|t"..GetItemLink(44095, 0), 1, INT_HEIRLOOMS+38, false, "", 0) -- Priest, Shaman, Mage, Warlock, Druid
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_DEATH_KNIGHT or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_36:25:25:-19|t"..GetItemLink(44096, 0), 1, INT_HEIRLOOMS+39, false, "", 0) -- Warrior, Paladin, Hunter, Rogue, Death Knight, Mage, Warlock
        end
        if (player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_hammer_17:25:25:-19|t"..GetItemLink(48716, 0), 1, INT_HEIRLOOMS+40, false, "", 0) -- Rogue, Shaman
        end
        if (player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_gizmo_02:25:25:-19|t"..GetItemLink(48718, 0), 1, INT_HEIRLOOMS+41, false, "", 0) -- Shaman, Druid
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_HEIRLOOMS, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
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
    elseif (intid == INT_HEIRLOOMS+3) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_misc_book_11:25:25:-19|t"..GetItemLink(49177, 0), 1, INT_HEIRLOOMS+42, false, "Do you wish to continue the transaction?", 10000000)
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_HEIRLOOMS, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
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
