local EVENT_ON_GIVE_XP           = 12
local EVENT_ON_MONEY_CHANGE      = 14
local EVENT_ON_REPUTATION_CHANGE = 15
local EVENT_ON_FIRST_LOGIN       = 30

local TEAM_ALLIANCE              = 0
local TEAM_HORDE                 = 1

local RACE_HUMAN                 = 1
local RACE_ORC                   = 2
local RACE_DWARF                 = 3
local RACE_NIGHTELF              = 4
local RACE_UNDEAD                = 5
local RACE_TAUREN                = 6
local RACE_GNOME                 = 7
local RACE_TROLL                 = 8
local RACE_BLOODELF              = 10
local RACE_DRAENEI               = 11

local CLASS_WARRIOR              = 1
local CLASS_PALADIN              = 2
local CLASS_HUNTER               = 3
local CLASS_ROGUE                = 4
local CLASS_PRIEST               = 5
local CLASS_DEATH_KNIGHT         = 6
local CLASS_SHAMAN               = 7
local CLASS_MAGE                 = 8
local CLASS_WARLOCK              = 9
local CLASS_DRUID                = 11

local EQUIPMENT_SLOT_BAG1        = 19
local EQUIPMENT_SLOT_BAG2        = 20
local EQUIPMENT_SLOT_BAG3        = 21
local EQUIPMENT_SLOT_BAG4        = 22

local INVENTORY_CONTAINER        = 23162

local function onGiveXP(event, player, amount, victim)
    if (player:GetLevel() < 60) then
        return amount * 3;
    elseif (player:GetLevel() < 70) then
        return amount * 2;
    else
        return amount * 1;
    end
end

RegisterPlayerEvent(EVENT_ON_GIVE_XP, onGiveXP)

local function onMoneyChange(player, amount)
    if (player:GetLevel() < 60) then
        return amount * 3;
    elseif (player:GetLevel() < 70) then
        return amount * 2;
    else
        return amount * 1;
    end
end

RegisterPlayerEvent(EVENT_ON_MONEY_CHANGE, onMoneyChange)

local function onReputationChange(player, factionId, standing, incremenetal)
    if (player:GetLevel() < 60) then
        return standing * 3;
    elseif (player:GetLevel() < 70) then
        return standing * 2;
    else
        return standing * 1;
    end
end

RegisterPlayerEvent(EVENT_ON_REPUTATION_CHANGE, onReputationChange)

local function onFirstLogin(event, player)
    if not (player:GetClass() == CLASS_DEATH_KNIGHT) then
        if (player:GetTeam() == TEAM_ALLIANCE) then
            player:Teleport(0, -8830.438477, 626.666199, 93.982887, 0.682076);
        elseif (player:GetTeam() == TEAM_HORDE) then
            player:Teleport(1, 1630.776001, -4412.993652, 16.567701, 0.080535);
        end
    end

    if not (player:GetClass() == CLASS_DEATH_KNIGHT) then
        if (player:GetClass() == CLASS_HUNTER) then
            player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG2);
            player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG3);
            player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG4);
        else
            player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG1);
            player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG2);
            player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG3);
            player:EquipItem(INVENTORY_CONTAINER, EQUIPMENT_SLOT_BAG4);
        end
    end

    --if (player:GetClass() == CLASS_WARRIOR) then
        --player:AddItem(42943);
    --end
end

RegisterPlayerEvent(EVENT_ON_FIRST_LOGIN, onFirstLogin)
