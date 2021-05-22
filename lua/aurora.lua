local EVENT_ON_GIVE_XP           = 12
local EVENT_ON_MONEY_CHANGE      = 14
local EVENT_ON_REPUTATION_CHANGE = 15
local EVENT_ON_FIRST_LOGIN       = 30
local EVENT_ON_COMMAND           = 42

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

local AT_LOGIN_RENAME            = 0x01
local AT_LOGIN_CUSTOMIZE         = 0x08
local AT_LOGIN_CHANGE_FACTION    = 0x40
local AT_LOGIN_CHANGE_RACE       = 0x80

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

local function onMoneyChange(event, player, amount)
    if (player:GetLevel() < 60) then
        return amount * 3;
    elseif (player:GetLevel() < 70) then
        return amount * 2;
    else
        return amount * 1;
    end
end

RegisterPlayerEvent(EVENT_ON_MONEY_CHANGE, onMoneyChange)

local function onReputationChange(event, player, factionId, standing, incremenetal)
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

    if (player:GetClass() == CLASS_WARRIOR) then
        player:AddItem(42943);
        player:AddItem(42945);
        player:AddItem(42946);
        player:AddItem(44092);
        player:AddItem(44093);
        player:AddItem(44096, 2);
        player:AddItem(42949);
        player:AddItem(44099);
        player:AddItem(48685);
    elseif (player:GetClass() == CLASS_PALADIN) then
        player:AddItem(42943);
        player:AddItem(42945);
        player:AddItem(42948);
        player:AddItem(44092);
        player:AddItem(44094);
        player:AddItem(44096);
        player:AddItem(42949);
        player:AddItem(44099);
        player:AddItem(44100);
        player:AddItem(48685);
        player:AddItem(42992);
    elseif (player:GetClass() == CLASS_HUNTER) then
        player:AddItem(42944, 2);
        player:AddItem(42946);
        player:AddItem(44091, 2);
        player:AddItem(44093);
        player:AddItem(44096, 2);
        player:AddItem(42950);
        player:AddItem(44101);
        player:AddItem(48677);
    elseif (player:GetClass() == CLASS_ROGUE) then
        player:AddItem(42944, 2);
        player:AddItem(42946);
        player:AddItem(44091, 2);
        player:AddItem(44093);
        player:AddItem(44096, 2);
        player:AddItem(48716, 2);
        player:AddItem(42952);
        player:AddItem(44103);
        player:AddItem(48689);
    elseif (player:GetClass() == CLASS_PRIEST) then
        player:AddItem(42947);
        player:AddItem(42948);
        player:AddItem(44094);
        player:AddItem(44095);
        player:AddItem(42985);
        player:AddItem(44107);
        player:AddItem(48691);
        player:AddItem(42992);
    elseif (player:GetClass() == CLASS_DEATH_KNIGHT) then
        player:AddItem(42943);
        player:AddItem(44092);
        player:AddItem(44096, 2);
        player:AddItem(42949);
        player:AddItem(44099);
        player:AddItem(48685);
    elseif (player:GetClass() == CLASS_SHAMAN) then
        player:AddItem(42944, 2);
        player:AddItem(42947);
        player:AddItem(42948);
        player:AddItem(44091);
        player:AddItem(44094);
        player:AddItem(44095);
        player:AddItem(48716, 2);
        player:AddItem(48718);
        player:AddItem(42950);
        player:AddItem(42951);
        player:AddItem(44101);
        player:AddItem(44102);
        player:AddItem(48677);
        player:AddItem(48683);
        player:AddItem(42992);
    elseif (player:GetClass() == CLASS_MAGE) then
        player:AddItem(42945);
        player:AddItem(42947);
        player:AddItem(44091);
        player:AddItem(44095);
        player:AddItem(44096);
        player:AddItem(42985);
        player:AddItem(44107);
        player:AddItem(48691);
        player:AddItem(42992);
    elseif (player:GetClass() == CLASS_WARLOCK) then
        player:AddItem(42945);
        player:AddItem(42947);
        player:AddItem(44091);
        player:AddItem(44095);
        player:AddItem(44096);
        player:AddItem(42985);
        player:AddItem(44107);
        player:AddItem(48691);
        player:AddItem(42992);
    elseif (player:GetClass() == CLASS_DRUID) then
        player:AddItem(42944);
        player:AddItem(42947);
        player:AddItem(42948);
        player:AddItem(44094);
        player:AddItem(44095);
        player:AddItem(48716);
        player:AddItem(48718);
        player:AddItem(42952);
        player:AddItem(42984);
        player:AddItem(44103);
        player:AddItem(44105);
        player:AddItem(48687);
        player:AddItem(48689);
        player:AddItem(42992);
    end

    player:AddItem(42991);
    player:AddItem(50255);

    if (player:GetTeam() == TEAM_ALLIANCE) then
        player:AddItem(44098);
    elseif (player:GetTeam() == TEAM_HORDE) then
        player:AddItem(44097);
    end
end

RegisterPlayerEvent(EVENT_ON_FIRST_LOGIN, onFirstLogin)

local commands = {}
commands.List = {
    "change name",
    "change appearance",
    "change faction",
    "change race"
}

function onCommand(event, player, command)
    for index, value in pairs(commands.List) do
        commands.c = string.lower(command)
        commands.v = string.lower(value)

        if (string.match(commands.c, commands.v .. "?")) then
            if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
                player:SendBroadcastMessage("You already have a queued feature")
                return false
            end

            if (index == 1) then
                player:SetAtLoginFlag(AT_LOGIN_RENAME)
                player:SendBroadcastMessage("You may now log out to apply the name change")
            elseif (index == 2) then
                player:SetAtLoginFlag(AT_LOGIN_CUSTOMIZE)
                player:SendBroadcastMessage("You may now log out to apply the customization")
            elseif (index == 3) then
                player:SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION)
                player:SendBroadcastMessage("You may now log out to apply the faction change")
            elseif (index == 4) then
                player:SetAtLoginFlag(AT_LOGIN_CHANGE_RACE)
                player:SendBroadcastMessage("You may now log out to apply the race change")
            end

            return false
        end
    end
end

RegisterPlayerEvent(EVENT_ON_COMMAND, onCommand)
