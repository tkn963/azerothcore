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

-- Bag all characters start with
local INVENTORY_CONTAINER             = 23162

-- Experience, money and reputation rates
local MULTIPLIER_1                    = 4 -- Multiplier for rates level 1-59
local MULTIPLIER_2                    = 3 -- Multiplier for rates level 60-69
local MULTIPLIER_3                    = 2 -- Multiplier for rates level 70-79
local MULTIPLIER_4                    = 1 -- Mutliplier for rates at level 80

-- Required copper values
local UTILITIES_COPPER_RENAME         = 100000 -- Money required in copper to perform a name change
local UTILITIES_COPPER_CUSTOMIZE      = 500000 -- Money required in copper to perform a change of appearance
local UTILITIES_COPPER_CHANGE_FACTION = 10000000 -- Money required in copper to perform a faction change
local UTILITIES_COPPER_CHANGE_RACE    = 5000000 -- Money required in copper to perform a race change

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
        return amount * MULTIPLIER_1;
    elseif (player:GetLevel() < 70) then
        return amount * MULTIPLIER_2;
    elseif (player:GetLevel() < 80) then
        return amount * MULTIPLIER_3;
    else
        return amount * MULTIPLIER_4;
    end
end

RegisterPlayerEvent(EVENT_ON_GIVE_XP, onGiveXP)

-- When a character gains money
function onMoneyChange(event, player, amount)
    if (player:GetLevel() < 60) then
        return amount * MULTIPLIER_1;
    elseif (player:GetLevel() < 70) then
        return amount * MULTIPLIER_2;
    elseif (player:GetLevel() < 80) then
        return amount * MULTIPLIER_3;
    else
        return amount * MULTIPLIER_4;
    end
end

RegisterPlayerEvent(EVENT_ON_MONEY_CHANGE, onMoneyChange)

-- When a character gains reputation
function onReputationChange(event, player, factionId, standing, incremenetal)
    if (player:GetLevel() < 60) then
        return standing * MULTIPLIER_1;
    elseif (player:GetLevel() < 70) then
        return standing * MULTIPLIER_2;
    elseif (player:GetLevel() < 80) then
        return standing * MULTIPLIER_3;
    else
        return standing * MULTIPLIER_4;
    end
end

RegisterPlayerEvent(EVENT_ON_REPUTATION_CHANGE, onReputationChange)

-- When a character logs in for the first time
function onFirstLogin(event, player)
    if not (player:GetClass() == CLASS_DEATH_KNIGHT) then
        if (player:GetTeam() == TEAM_ALLIANCE) then
            player:Teleport(0, -8830.438477, 626.666199, 93.982887, 0.682076);
        elseif (player:GetTeam() == TEAM_HORDE) then
            player:Teleport(1, 1630.776001, -4412.993652, 16.567701, 0.080535);
        end
    end

    if (player:GetClass() == CLASS_HUNTER) then
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG2);
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG3);
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG4);
    elseif (player:GetClass() == CLASS_DEATH_KNIGHT) then
        player:AddItem(INVENTORY_CONTAINER, 4);
    else
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG1);
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG2);
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG3);
        player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG4);
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
    player:GossipMenuAddItem(7, "I want glyphs", 1, INT_GLYPHS)
    player:GossipMenuAddItem(7, "I want gems", 1, INT_GEMS)
    player:GossipMenuAddItem(7, "I want heirlooms", 1, INT_HEIRLOOMS)
    player:GossipMenuAddItem(7, "What utilities can I get?", 1, INT_UTILITIES)
    player:GossipSendMenu(0x7FFFFFFF, object, 1)
end

RegisterPlayerGossipEvent(1, 1, onGossipHello)

-- Gossip (Select)
function onGossipSelect(event, player, object, sender, intid, code)
    if (intid == INT_RETURN) then
        onGossipHello(event, player, player)
    elseif (intid == INT_GLYPHS) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(7, "I want some major glyphs", 1, INT_GLYPHS+1, false, "", 0)
        player:GossipMenuAddItem(7, "I want some minor glyphs", 1, INT_GLYPHS+2, false, "", 0)
        player:GossipMenuAddItem(0, "Return to previous page", 1, INT_RETURN, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_GEMS) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(7, "I want some meta gems", 1, INT_GEMS+1, false, "", 0)
        player:GossipMenuAddItem(7, "I want some red gems", 1, INT_GEMS+2, false, "", 0)
        player:GossipMenuAddItem(7, "I want some blue gems", 1, INT_GEMS+3, false, "", 0)
        player:GossipMenuAddItem(7, "I want some yellow gems", 1, INT_GEMS+4, false, "", 0)
        player:GossipMenuAddItem(7, "I want some purple gems", 1, INT_GEMS+5, false, "", 0)
        player:GossipMenuAddItem(7, "I want some green gems", 1, INT_GEMS+6, false, "", 0)
        player:GossipMenuAddItem(7, "I want some orange gems", 1, INT_GEMS+7, false, "", 0)
        player:GossipMenuAddItem(0, "Return to previous page", 1, INT_RETURN, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_HEIRLOOMS) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(7, "I want some armor", 1, INT_HEIRLOOMS+1, false, "", 0)
        player:GossipMenuAddItem(7, "I want some weapons", 1, INT_HEIRLOOMS+2, false, "", 0)
        player:GossipMenuAddItem(0, "Return to previous page", 1, INT_RETURN, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_UTILITIES) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(6, "I want to change my name", 1, INT_UTILITIES+1, false, "Do you wish to continue the transaction?", UTILITIES_COPPER_RENAME)
        player:GossipMenuAddItem(6, "I want to change my appearance", 1, INT_UTILITIES+2, false, "Do you wish to continue the transaction?", UTILITIES_COPPER_CUSTOMIZE)
        player:GossipMenuAddItem(6, "I want to change my faction", 1, INT_UTILITIES+3, false, "Do you wish to continue the transaction?", UTILITIES_COPPER_CHANGE_FACTION)
        player:GossipMenuAddItem(6, "I want to change my race", 1, INT_UTILITIES+4, false, "Do you wish to continue the transaction?", UTILITIES_COPPER_CHANGE_RACE)
        player:GossipMenuAddItem(0, "Return to previous page", 1, INT_RETURN, false, "", 0)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_UTILITIES+1) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            player:GossipComplete()
        else
            player:ModifyMoney(-UTILITIES_COPPER_RENAME);
            player:SetAtLoginFlag(AT_LOGIN_RENAME)
            player:SendBroadcastMessage("You can now log out to apply the name change.")
            player:GossipComplete()
        end
    elseif (intid == INT_UTILITIES+2) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            player:GossipComplete()
        else
            player:ModifyMoney(-UTILITIES_COPPER_CUSTOMIZE);
            player:SetAtLoginFlag(AT_LOGIN_CUSTOMIZE)
            player:SendBroadcastMessage("You can now log out to apply the customization.")
            player:GossipComplete()
        end
    elseif (intid == INT_UTILITIES+3) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            player:GossipComplete()
        else
            player:ModifyMoney(-UTILITIES_COPPER_CHANGE_FACTION);
            player:SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION)
            player:SendBroadcastMessage("You can now log out to apply the faction change.")
            player:GossipComplete()
        end
    elseif (intid == INT_UTILITIES+4) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            player:GossipComplete()
        else
            player:ModifyMoney(-UTILITIES_COPPER_CHANGE_RACE);
            player:SetAtLoginFlag(AT_LOGIN_CHANGE_RACE)
            player:SendBroadcastMessage("You can now log out to apply the race change.")
            player:GossipComplete()
        end
    end
end

RegisterPlayerGossipEvent(1, 2, onGossipSelect)
