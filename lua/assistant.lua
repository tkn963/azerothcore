-- Features
local ENABLE_EQUIPMENT              = true
local ENABLE_HEIRLOOMS              = true
local ENABLE_GLYPHS                 = true
local ENABLE_GEMS                   = true
local ENABLE_CONTAINERS             = true
local ENABLE_UTILITIES              = true
local ENABLE_MISCELLANEOUS          = true

-- Events
local EVENT_ON_LOGIN                = 3
local EVENT_ON_COMMAND              = 42

-- Teams
local TEAM_ALLIANCE                 = 0
local TEAM_HORDE                    = 1

-- Classes
local CLASS_WARRIOR                 = 1
local CLASS_PALADIN                 = 2
local CLASS_HUNTER                  = 3
local CLASS_ROGUE                   = 4
local CLASS_PRIEST                  = 5
local CLASS_DEATH_KNIGHT            = 6
local CLASS_SHAMAN                  = 7
local CLASS_MAGE                    = 8
local CLASS_WARLOCK                 = 9
local CLASS_DRUID                   = 11

-- Login flags
local AT_LOGIN_RENAME               = 0x01
local AT_LOGIN_CUSTOMIZE            = 0x08
local AT_LOGIN_CHANGE_FACTION       = 0x40
local AT_LOGIN_CHANGE_RACE          = 0x80

-- Gossip icons
local GOSSIP_ICON_CHAT              = 0 -- white chat bubble
local GOSSIP_ICON_VENDOR            = 1 -- brown bag
local GOSSIP_ICON_TAXI              = 2 -- flightmarker (paperplane)
local GOSSIP_ICON_TRAINER           = 3 -- brown book (trainer)
local GOSSIP_ICON_INTERACT_1        = 4 -- golden interaction wheel
local GOSSIP_ICON_MONEY_BAG         = 6 -- brown bag (with gold coin in lower corner)
local GOSSIP_ICON_TALK              = 7 -- white chat bubble (with "..." inside)
local GOSSIP_ICON_TABARD            = 8 -- white tabard
local GOSSIP_ICON_BATTLE            = 9 -- two crossed swords
local GOSSIP_ICON_DOT               = 10 -- yellow dot/point

local CONTAINER_BAG                 = 23162 -- Foror's Crate of Endless Resist Gear Storage (36 slot)

-- Required copper values
local UTILITIES_COST_RENAME         = 10 -- Money required in gold to perform a name change
local UTILITIES_COST_CUSTOMIZE      = 50 -- Money required in gold to perform a customization
local UTILITIES_COST_FACTION_CHANGE = 1000 -- Money required in gold to perform a faction change
local UTILITIES_COST_RACE_CHANGE    = 500 -- Money required in gold to perform a race change

-- Ids for gossip selects
local INT_EQUIPMENT                 = 100
local INT_HEIRLOOMS                 = 200
local INT_GLYPHS                    = 300
local INT_GEMS                      = 500
local INT_CONTAINERS                = 600
local INT_UTILITIES                 = 700
local INT_MISCELLANEOUS             = 800
local INT_RETURN                    = 2000

-- When a character enters the world
function onLogin(event, player)
    player:SendBroadcastMessage("This server uses an assistant to aid players. Type .assistant to access this feature.")
end

RegisterPlayerEvent(EVENT_ON_LOGIN, onLogin)

-- Character performs a command
function onCommand(event, player, command)
    if (ENABLE_CONTAINERS or ENABLE_GLYPHS or ENABLE_GEMS or ENABLE_HEIRLOOMS or ENABLE_UTILITIES or ENABLE_MISCELLANEOUS) then
        if command == 'assistant' then
            onGossipHello(event, player, player)
            return false
        end
    end
end

RegisterPlayerEvent(EVENT_ON_COMMAND, onCommand)

-- Gossip: Hello
function onGossipHello(event, player, object)
    player:GossipClearMenu()
    if (ENABLE_EQUIPMENT and player:GetLevel() == 80) then
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want equipment", 1, INT_EQUIPMENT)
    end
    if (ENABLE_HEIRLOOMS) then
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want heirlooms", 1, INT_HEIRLOOMS)
    end
    if (ENABLE_GLYPHS) then
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want glyphs", 1, INT_GLYPHS)
    end
    if (ENABLE_GEMS) then
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want gems", 1, INT_GEMS)
    end
    if (ENABLE_CONTAINERS) then
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want containers", 1, INT_CONTAINERS)
    end
    if (ENABLE_UTILITIES) then
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want utilities", 1, INT_UTILITIES)
    end
    if (ENABLE_MISCELLANEOUS and player:GetClass() == CLASS_SHAMAN) then
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "What else can I get?", 1, INT_MISCELLANEOUS)
    end

    player:GossipSendMenu(0x7FFFFFFF, object, 1)
end

RegisterPlayerGossipEvent(1, 1, onGossipHello)

-- Gossip: Select
function onGossipSelect(event, player, object, sender, intid, code)
    if (intid == INT_RETURN) then
        onGossipHello(event, player, player)
    elseif (intid == INT_EQUIPMENT) then
        player:GossipClearMenu()

    if (player:GetClass() == CLASS_WARRIOR) then
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Arms", 1, INT_EQUIPMENT+1)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Fury", 1, INT_EQUIPMENT+2)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Protection", 1, INT_EQUIPMENT+3)
    elseif (player:GetClass() == CLASS_PALADIN) then
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Holy", 1, INT_EQUIPMENT+4)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Protection", 1, INT_EQUIPMENT+5)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Retribution", 1, INT_EQUIPMENT+6)
    elseif (player:GetClass() == CLASS_HUNTER) then
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Beast Mastery", 1, INT_EQUIPMENT+7)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Marksmanship", 1, INT_EQUIPMENT+8)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Survival", 1, INT_EQUIPMENT+9)
    elseif (player:GetClass() == CLASS_ROGUE) then
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Assassination", 1, INT_EQUIPMENT+10)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Combat", 1, INT_EQUIPMENT+11)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Subtlety", 1, INT_EQUIPMENT+12)
    elseif (player:GetClass() == CLASS_PRIEST) then
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Discipline", 1, INT_EQUIPMENT+13)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Holy", 1, INT_EQUIPMENT+14)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Shadow", 1, INT_EQUIPMENT+15)
    elseif (player:GetClass() == CLASS_DEATH_KNIGHT) then
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Blood", 1, INT_EQUIPMENT+16)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Frost", 1, INT_EQUIPMENT+17)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Unholy", 1, INT_EQUIPMENT+18)
    elseif (player:GetClass() == CLASS_SHAMAN) then
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Elemental", 1, INT_EQUIPMENT+19)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Enhancement", 1, INT_EQUIPMENT+20)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Restoration", 1, INT_EQUIPMENT+21)
    elseif (player:GetClass() == CLASS_MAGE) then
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Arcane", 1, INT_EQUIPMENT+22)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Fire", 1, INT_EQUIPMENT+23)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Frost", 1, INT_EQUIPMENT+24)
    elseif (player:GetClass() == CLASS_WARLOCK) then
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Affliction", 1, INT_EQUIPMENT+25)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Demonology", 1, INT_EQUIPMENT+26)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "I want to use Destruction", 1, INT_EQUIPMENT+27)
    elseif (player:GetClass() == CLASS_DRUID) then
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\spell_nature_forceOfnature:25:25:-19|tI want to use Balance", 1, INT_EQUIPMENT+28)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\ability_druid_catForm:25:25:-19|tI want to use Feral Combat", 1, INT_EQUIPMENT+29)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\ability_druid_treeoflife:25:25:-19|tI want to use Restoration", 1, INT_EQUIPMENT+30)
    end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_RETURN)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_HEIRLOOMS) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some armor", 1, INT_HEIRLOOMS+1)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some weapons", 1, INT_HEIRLOOMS+2)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want something else", 1, INT_HEIRLOOMS+3)
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_RETURN)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_HEIRLOOMS+1) then
        player:GossipClearMenu()

        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_30:25:25:-19|tPolished Spaulders of Valor", 1, INT_HEIRLOOMS+4)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_plate03:25:25:-19|tPolished Breastplate of Valor", 1, INT_HEIRLOOMS+5)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_20:25:25:-19|tStrengthened Stockade Pauldrons", 1, INT_HEIRLOOMS+6)

            if (player:GetClass() == CLASS_PALADIN) then
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_10:25:25:-19|tPristine Lightforge Spaulders", 1, INT_HEIRLOOMS+7)
            end
        elseif (player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_01:25:25:-19|tChampion Herod's Shoulder", 1, INT_HEIRLOOMS+8)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_chain_07:25:25:-19|tChampion's Deathdealer Breastplate", 1, INT_HEIRLOOMS+9)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_10:25:25:-19|tPrized Beastmaster's Mantle", 1, INT_HEIRLOOMS+10)
            if (player:GetClass() == CLASS_SHAMAN) then
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_29:25:25:-19|tMystical Pauldrons of Elements", 1, INT_HEIRLOOMS+11)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_chain_11:25:25:-19|tMystical Vest of Elements", 1, INT_HEIRLOOMS+12)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_29:25:25:-19|tAged Pauldrons of The Five Thunders", 1, INT_HEIRLOOMS+13)
            end
        elseif (player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_07:25:25:-19|tStained Shadowcraft Spaulders", 1, INT_HEIRLOOMS+14)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_leather_07:25:25:-19|tStained Shadowcraft Tunic", 1, INT_HEIRLOOMS+15)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_05:25:25:-19|tExceptional Stormshroud Shoulders", 1, INT_HEIRLOOMS+16)

            if (player:GetClass() == CLASS_DRUID) then
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_06:25:25:-19|tPreened Ironfeather Shoulders", 1, INT_HEIRLOOMS+17)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_leather_06:25:25:-19|tPreened Ironfeather Breastplate", 1, INT_HEIRLOOMS+18)
                player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_01:25:25:-19|tLasting Feralheart Spaulders", 1, INT_HEIRLOOMS+19)
            end
        elseif (player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_misc_bone_taurenskull_01:25:25:-19|tTattered Dreadmist Mantle", 1, INT_HEIRLOOMS+20)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_chest_cloth_49:25:25:-19|tTattered Dreadmist Robe", 1, INT_HEIRLOOMS+21)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_shoulder_02:25:25:-19|tExquisite Sunderseer Mantle", 1, INT_HEIRLOOMS+22)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_ring_39:25:25:-19|tDread Pirate Ring", 1, INT_HEIRLOOMS+23)
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_talisman_01:25:25:-19|tSwift Hand of Justice", 1, INT_HEIRLOOMS+24)

        if (player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_talisman_08:25:25:-19|tDiscerning Eye of the Beast", 1, INT_HEIRLOOMS+25)
        end

        if (player:GetTeam() == TEAM_ALLIANCE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_trinketpvp_01:25:25:-19|tInherited Insignia of the Alliance", 1, INT_HEIRLOOMS+26)
        elseif (player:GetTeam() == TEAM_HORDE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_trinketpvp_02:25:25:-19|tInherited Insignia of the Horde", 1, INT_HEIRLOOMS+27)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_HEIRLOOMS)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_HEIRLOOMS+2) then
        player:GossipClearMenu()

        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_axe_09:25:25:-19|tBloodied Arcanite Reaper", 1, INT_HEIRLOOMS+28)
        end
        if (player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_17:25:25:-19|tBalanced Heartseeker", 1, INT_HEIRLOOMS+29)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_43:25:25:-19|tVenerable Dal'Rend's Sacred Charge", 1, INT_HEIRLOOMS+30)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_weapon_bow_08:25:25:-19|tCharmed Ancient Bone Bow", 1, INT_HEIRLOOMS+31)
        end
        if (player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_jewelry_talisman_12:25:25:-19|tDignified Headmaster's Charge", 1, INT_HEIRLOOMS+32)
        end
        if (player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_hammer_05:25:25:-19|tDevout Aurastone Hammer", 1, INT_HEIRLOOMS+33)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_weapon_shortblade_03:25:25:-19|tSharpened Scarlet Kris", 1, INT_HEIRLOOMS+34)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_19:25:25:-19|tReforged Truesilver Champion", 1, INT_HEIRLOOMS+35)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_weapon_rifle_09:25:25:-19|tUpgraded Dwarven Hand Cannon", 1, INT_HEIRLOOMS+36)
        end
        if (player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_hammer_07:25:25:-19|tThe Blessed Hammer of Grace", 1, INT_HEIRLOOMS+37)
        end
        if (player:GetClass() == CLASS_PRIEST or player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_staff_13:25:25:-19|tGrand Staff of Jordan", 1, INT_HEIRLOOMS+38)
        end
        if (player:GetClass() == CLASS_WARRIOR or player:GetClass() == CLASS_PALADIN or player:GetClass() == CLASS_HUNTER or player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_DEATH_KNIGHT or player:GetClass() == CLASS_MAGE or player:GetClass() == CLASS_WARLOCK) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_sword_36:25:25:-19|tBattleworn Thrash Blade", 1, INT_HEIRLOOMS+39)
        end
        if (player:GetClass() == CLASS_ROGUE or player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_hammer_17:25:25:-19|tVenerable Mass of McGowan", 1, INT_HEIRLOOMS+40)
        end
        if (player:GetClass() == CLASS_SHAMAN or player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_gizmo_02:25:25:-19|tRepurposed Lava Dredger", 1, INT_HEIRLOOMS+41)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_HEIRLOOMS)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_HEIRLOOMS+3) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_misc_book_11:25:25:-19|tTome of Cold Weather Flight", 1, INT_HEIRLOOMS+42, false, "Do you wish to continue the transaction?", 10000000)
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_HEIRLOOMS)
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
    elseif (intid == INT_GLYPHS) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some major glyphs", 1, INT_GLYPHS+1)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some minor glyphs", 1, INT_GLYPHS+2)
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_RETURN)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_GLYPHS+1) then
        player:GossipClearMenu()

        if (player:GetClass() == CLASS_WARRIOR) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Bloodthirst", 1, INT_GLYPHS+3)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Devastate", 1, INT_GLYPHS+4)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Intervene", 1, INT_GLYPHS+5)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Mortal Strike", 1, INT_GLYPHS+6)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Bladestorm", 1, INT_GLYPHS+7)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Shockwave", 1, INT_GLYPHS+8)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Vigilance", 1, INT_GLYPHS+9)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Enraged Regeneration", 1, INT_GLYPHS+10)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Spell Reflection", 1, INT_GLYPHS+11)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarrior:25:25:-19|tGlyph of Shield Wall", 1, INT_GLYPHS+12)
        elseif (player:GetClass() == CLASS_PALADIN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Hammer of Wrath", 1, INT_GLYPHS+13)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Avenging Wrath", 1, INT_GLYPHS+14)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Avenger's Shield", 1, INT_GLYPHS+15)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Holy Wrath", 1, INT_GLYPHS+16)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Seal of Righteousness", 1, INT_GLYPHS+17)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Seal of Vengeance", 1, INT_GLYPHS+18)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Beacon of Light", 1, INT_GLYPHS+19)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Hammer of the Righteous", 1, INT_GLYPHS+20)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Divine Storm", 1, INT_GLYPHS+21)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpaladin:25:25:-19|tGlyph of Shield of Righteousness", 1, INT_GLYPHS+22)
        elseif (player:GetClass() == CLASS_HUNTER) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Bestial Wrath", 1, INT_GLYPHS+23)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Snake Trap", 1, INT_GLYPHS+24)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Steady Shot", 1, INT_GLYPHS+25)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Trueshot Aura", 1, INT_GLYPHS+26)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Volley", 1, INT_GLYPHS+27)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Wyvern Sting", 1, INT_GLYPHS+28)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Chimera Shot", 1, INT_GLYPHS+29)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Explosive Shot", 1, INT_GLYPHS+30)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Kill Shot", 1, INT_GLYPHS+31)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorhunter:25:25:-19|tGlyph of Explosive Trap", 1, INT_GLYPHS+32)
        elseif (player:GetClass() == CLASS_ROGUE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|tGlyph of Adrenaline Rush", 1, INT_GLYPHS+33)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|tGlyph of Deadly Throw", 1, INT_GLYPHS+34)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|tGlyph of Vigor", 1, INT_GLYPHS+35)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|tGlyph of Hunger for Blood", 1, INT_GLYPHS+36)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|tGlyph of Killing Spree", 1, INT_GLYPHS+37)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|tGlyph of Shadow Dance", 1, INT_GLYPHS+38)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|tGlyph of Fan of Knives", 1, INT_GLYPHS+39)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|tGlyph of Tricks of the Trade", 1, INT_GLYPHS+40)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|tGlyph of Mutilate", 1, INT_GLYPHS+41)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorrogue:25:25:-19|tGlyph of Cloak of Shadows", 1, INT_GLYPHS+42)
        elseif (player:GetClass() == CLASS_PRIEST) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|tGlyph of Circle of Healing", 1, INT_GLYPHS+43)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|tGlyph of Lightwell", 1, INT_GLYPHS+44)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|tGlyph of Mass Dispel", 1, INT_GLYPHS+45)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|tGlyph of Shadow Word: Death", 1, INT_GLYPHS+46)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|tGlyph of Dispersion", 1, INT_GLYPHS+47)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|tGlyph of Guardian Spirit", 1, INT_GLYPHS+48)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|tGlyph of Penance", 1, INT_GLYPHS+49)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|tGlyph of Mind Sear", 1, INT_GLYPHS+50)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|tGlyph of Hymn of Hope", 1, INT_GLYPHS+51)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorpriest:25:25:-19|tGlyph of Pain Suppression", 1, INT_GLYPHS+52)
        elseif (player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|tGlyph of Anti-Magic Shell", 1, INT_GLYPHS+53)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|tGlyph of Heart Strike", 1, INT_GLYPHS+54)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|tGlyph of Bone Shield", 1, INT_GLYPHS+55)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|tGlyph of Chains of Ice", 1, INT_GLYPHS+56)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|tGlyph of Dark Command", 1, INT_GLYPHS+57)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|tGlyph of Death Grip", 1, INT_GLYPHS+58)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|tGlyph of Death and Decay", 1, INT_GLYPHS+59)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|tGlyph of Frost Strike", 1, INT_GLYPHS+60)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|tGlyph of Icebound Fortitude", 1, INT_GLYPHS+61)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordeathknight:25:25:-19|tGlyph of Icy Touch", 1, INT_GLYPHS+62)
        elseif (player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|tGlyph of Chain Heal", 1, INT_GLYPHS+63)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|tGlyph of Lava", 1, INT_GLYPHS+64)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|tGlyph of Fire Elemental Totem", 1, INT_GLYPHS+65)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|tGlyph of Mana Tide Totem", 1, INT_GLYPHS+66)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|tGlyph of Stormstrike", 1, INT_GLYPHS+67)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|tGlyph of Elemental Mastery", 1, INT_GLYPHS+68)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|tGlyph of Thunder", 1, INT_GLYPHS+69)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|tGlyph of Feral Spirit", 1, INT_GLYPHS+70)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|tGlyph of Riptide", 1, INT_GLYPHS+71)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorshaman:25:25:-19|tGlyph of Earth Shield", 1, INT_GLYPHS+72)
        elseif (player:GetClass() == CLASS_MAGE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|tGlyph of Arcane Power", 1, INT_GLYPHS+73)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|tGlyph of Deep Freeze", 1, INT_GLYPHS+74)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|tGlyph of Living Bomb", 1, INT_GLYPHS+75)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|tGlyph of Invisibility", 1, INT_GLYPHS+76)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|tGlyph of Ice Lance", 1, INT_GLYPHS+77)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|tGlyph of Molten Armor", 1, INT_GLYPHS+78)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|tGlyph of Water Elemental", 1, INT_GLYPHS+79)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|tGlyph of Frostfire", 1, INT_GLYPHS+80)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|tGlyph of Arcane Blast", 1, INT_GLYPHS+81)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majormage:25:25:-19|tGlyph of Eternal Water", 1, INT_GLYPHS+82)
        elseif (player:GetClass() == CLASS_WARLOCK) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|tGlyph of Conflagrate", 1, INT_GLYPHS+83)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|tGlyph of Death Coil", 1, INT_GLYPHS+84)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|tGlyph of Felguard", 1, INT_GLYPHS+85)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|tGlyph of Howl of Terror", 1, INT_GLYPHS+86)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|tGlyph of Unstable Affliction", 1, INT_GLYPHS+87)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|tGlyph of Haunt", 1, INT_GLYPHS+88)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|tGlyph of Metamorphosis", 1, INT_GLYPHS+89)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|tGlyph of Chaos Bolt", 1, INT_GLYPHS+90)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|tGlyph of Demonic Circle", 1, INT_GLYPHS+91)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majorwarlock:25:25:-19|tGlyph of Shadowflame", 1, INT_GLYPHS+92)
        elseif (player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|tGlyph of Mangle", 1, INT_GLYPHS+93)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|tGlyph of Swiftmend", 1, INT_GLYPHS+94)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|tGlyph of Innervate", 1, INT_GLYPHS+95)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|tGlyph of Lifebloom", 1, INT_GLYPHS+96)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|tGlyph of Hurricane", 1, INT_GLYPHS+97)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|tGlyph of Starfall", 1, INT_GLYPHS+98)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|tGlyph of Focus", 1, INT_GLYPHS+99)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|tGlyph of Berserk", 1, INT_GLYPHS+100)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|tGlyph of Wild Growth", 1, INT_GLYPHS+101)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_majordruid:25:25:-19|tGlyph of Nourish", 1, INT_GLYPHS+102)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_GLYPHS)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_GLYPHS+2) then
        player:GossipClearMenu()

        if (player:GetClass() == CLASS_WARRIOR) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|tGlyph of Battle", 1, INT_GLYPHS+103)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|tGlyph of Bloodrage", 1, INT_GLYPHS+104)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|tGlyph of Charge", 1, INT_GLYPHS+105)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|tGlyph of Mocking Blow", 1, INT_GLYPHS+106)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|tGlyph of Thunder Clap", 1, INT_GLYPHS+107)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|tGlyph of Enduring Victory", 1, INT_GLYPHS+108)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarrior:25:25:-19|tGlyph of Command", 1, INT_GLYPHS+109)
        elseif (player:GetClass() == CLASS_PALADIN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|tGlyph of Blessing of Might", 1, INT_GLYPHS+110)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|tGlyph of Blessing of Kings", 1, INT_GLYPHS+111)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|tGlyph of Blessing of Wisdom", 1, INT_GLYPHS+112)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|tGlyph of Lay on Hands", 1, INT_GLYPHS+113)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|tGlyph of Sense Undead", 1, INT_GLYPHS+114)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpaladin:25:25:-19|tGlyph of the Wise", 1, INT_GLYPHS+115)
        elseif (player:GetClass() == CLASS_HUNTER) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|tGlyph of Revive Pet", 1, INT_GLYPHS+116)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|tGlyph of Mend Pet", 1, INT_GLYPHS+117)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|tGlyph of Feign Death", 1, INT_GLYPHS+118)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|tGlyph of Possessed Strength", 1, INT_GLYPHS+119)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|tGlyph of the Pack", 1, INT_GLYPHS+120)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorhunter:25:25:-19|tGlyph of Scare Beast", 1, INT_GLYPHS+121)
        elseif (player:GetClass() == CLASS_ROGUE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|tGlyph of Pick Pocket", 1, INT_GLYPHS+122)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|tGlyph of Distract", 1, INT_GLYPHS+123)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|tGlyph of Pick Lock", 1, INT_GLYPHS+124)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|tGlyph of Safe Fall", 1, INT_GLYPHS+125)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|tGlyph of Blurred Speed", 1, INT_GLYPHS+126)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorrogue:25:25:-19|tGlyph of Vanish", 1, INT_GLYPHS+127)
        elseif (player:GetClass() == CLASS_PRIEST) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|tGlyph of Fading", 1, INT_GLYPHS+128)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|tGlyph of Levitate", 1, INT_GLYPHS+129)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|tGlyph of Fortitude", 1, INT_GLYPHS+130)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|tGlyph of Shadow Protection", 1, INT_GLYPHS+131)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|tGlyph of Shackle Undead", 1, INT_GLYPHS+132)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorpriest:25:25:-19|tGlyph of Shadowfiend", 1, INT_GLYPHS+133)
        elseif (player:GetClass() == CLASS_DEATH_KNIGHT) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|tGlyph of Blood Tap", 1, INT_GLYPHS+134)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|tGlyph of Death's Embrace", 1, INT_GLYPHS+135)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|tGlyph of Horn of Winter", 1, INT_GLYPHS+136)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|tGlyph of Corpse Explosion", 1, INT_GLYPHS+137)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|tGlyph of Pestilence", 1, INT_GLYPHS+138)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordeathknight:25:25:-19|tGlyph of Raise Dead", 1, INT_GLYPHS+139)
        elseif (player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|tGlyph of Thunderstorm", 1, INT_GLYPHS+140)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|tGlyph of Water Breathing", 1, INT_GLYPHS+141)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|tGlyph of Astral Recall", 1, INT_GLYPHS+142)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|tGlyph of Renewed Life", 1, INT_GLYPHS+143)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|tGlyph of Water Shield", 1, INT_GLYPHS+144)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|tGlyph of Water Walking", 1, INT_GLYPHS+145)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorshaman:25:25:-19|tGlyph of Ghost Wolf", 1, INT_GLYPHS+146)
        elseif (player:GetClass() == CLASS_MAGE) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|tGlyph of Arcane Intellect", 1, INT_GLYPHS+147)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|tGlyph of Fire Ward", 1, INT_GLYPHS+148)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|tGlyph of Frost Armor", 1, INT_GLYPHS+149)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|tGlyph of Frost Ward", 1, INT_GLYPHS+150)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|tGlyph of the Penguin", 1, INT_GLYPHS+151)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|tGlyph of the Bear Cub", 1, INT_GLYPHS+152)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|tGlyph of Slow Fall", 1, INT_GLYPHS+153)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minormage:25:25:-19|tGlyph of Blast Wave", 1, INT_GLYPHS+154)
        elseif (player:GetClass() == CLASS_WARLOCK) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|tGlyph of Unending Breath", 1, INT_GLYPHS+155)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|tGlyph of Drain Soul", 1, INT_GLYPHS+156)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|tGlyph of Kilrogg", 1, INT_GLYPHS+157)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|tGlyph of Curse of Exhaustion", 1, INT_GLYPHS+158)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|tGlyph of Enslave Demon", 1, INT_GLYPHS+159)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minorwarlock:25:25:-19|tGlyph of Souls", 1, INT_GLYPHS+160)
        elseif (player:GetClass() == CLASS_DRUID) then
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|tGlyph of Aquatic Form", 1, INT_GLYPHS+161)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|tGlyph of Unburdened Rebirth", 1, INT_GLYPHS+162)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|tGlyph of Thorns", 1, INT_GLYPHS+163)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|tGlyph of Challenging Roar", 1, INT_GLYPHS+164)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|tGlyph of the Wild", 1, INT_GLYPHS+165)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|tGlyph of Dash", 1, INT_GLYPHS+166)
            player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_glyph_minordruid:25:25:-19|tGlyph of Typhoon", 1, INT_GLYPHS+167)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_GLYPHS)
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
    elseif (intid == INT_GLYPHS+33) then
        player:AddItem(42954)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+34) then
        player:AddItem(42959)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+35) then
        player:AddItem(42971)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+36) then
        player:AddItem(45761)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+37) then
        player:AddItem(45762)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+38) then
        player:AddItem(45764)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+39) then
        player:AddItem(45766)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+40) then
        player:AddItem(45767)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+41) then
        player:AddItem(45768)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+42) then
        player:AddItem(45769)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+43) then
        player:AddItem(42396)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+44) then
        player:AddItem(42403)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+45) then
        player:AddItem(42404)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+46) then
        player:AddItem(42414)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+47) then
        player:AddItem(45753)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+48) then
        player:AddItem(45755)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+49) then
        player:AddItem(45756)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+50) then
        player:AddItem(45757)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+51) then
        player:AddItem(45758)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+52) then
        player:AddItem(45760)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+53) then
        player:AddItem(43533)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+54) then
        player:AddItem(43534)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+55) then
        player:AddItem(43536)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+56) then
        player:AddItem(43537)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+57) then
        player:AddItem(43538)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+58) then
        player:AddItem(43541)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+59) then
        player:AddItem(43542)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+60) then
        player:AddItem(43543)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+61) then
        player:AddItem(43545)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+62) then
        player:AddItem(43546)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+63) then
        player:AddItem(41517)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+64) then
        player:AddItem(41524)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+65) then
        player:AddItem(41529)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+66) then
        player:AddItem(41538)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+67) then
        player:AddItem(41539)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+68) then
        player:AddItem(41552)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+69) then
        player:AddItem(45770)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+70) then
        player:AddItem(45771)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+71) then
        player:AddItem(45772)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+72) then
        player:AddItem(45775)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+73) then
        player:AddItem(42736)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+74) then
        player:AddItem(45736)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+75) then
        player:AddItem(45737)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+76) then
        player:AddItem(42748)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+77) then
        player:AddItem(42745)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+78) then
        player:AddItem(42751)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+79) then
        player:AddItem(42754)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+80) then
        player:AddItem(44684)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+81) then
        player:AddItem(44955)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+82) then
        player:AddItem(50045)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+83) then
        player:AddItem(42454)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+84) then
        player:AddItem(42457)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+85) then
        player:AddItem(42459)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+86) then
        player:AddItem(42463)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+87) then
        player:AddItem(42472)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+88) then
        player:AddItem(45779)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+89) then
        player:AddItem(45780)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+90) then
        player:AddItem(45781)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+91) then
        player:AddItem(45782)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+92) then
        player:AddItem(45783)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+93) then
        player:AddItem(40900)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+94) then
        player:AddItem(40906)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+95) then
        player:AddItem(40908)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+96) then
        player:AddItem(40915)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+97) then
        player:AddItem(40920)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+98) then
        player:AddItem(40921)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+99) then
        player:AddItem(44928)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+100) then
        player:AddItem(45601)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+101) then
        player:AddItem(45602)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+102) then
        player:AddItem(45603)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+1, code)
    elseif (intid == INT_GLYPHS+103) then
        player:AddItem(43395)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+104) then
        player:AddItem(43396)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+105) then
        player:AddItem(43397)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+106) then
        player:AddItem(43398)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+107) then
        player:AddItem(43399)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+108) then
        player:AddItem(43400)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+109) then
        player:AddItem(49084)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+110) then
        player:AddItem(43340)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+111) then
        player:AddItem(43365)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+112) then
        player:AddItem(43366)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+113) then
        player:AddItem(43367)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+114) then
        player:AddItem(43368)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+115) then
        player:AddItem(43369)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+116) then
        player:AddItem(43338)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+117) then
        player:AddItem(43350)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+118) then
        player:AddItem(43351)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+119) then
        player:AddItem(43354)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+120) then
        player:AddItem(43355)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+121) then
        player:AddItem(43356)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+122) then
        player:AddItem(43343)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+123) then
        player:AddItem(43376)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+124) then
        player:AddItem(43377)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+125) then
        player:AddItem(43378)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+126) then
        player:AddItem(43379)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+127) then
        player:AddItem(43380)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+128) then
        player:AddItem(43342)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+129) then
        player:AddItem(43370)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+130) then
        player:AddItem(43371)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+131) then
        player:AddItem(43372)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+132) then
        player:AddItem(43373)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+133) then
        player:AddItem(43374)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+134) then
        player:AddItem(43535)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+135) then
        player:AddItem(43539)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+136) then
        player:AddItem(43544)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+137) then
        player:AddItem(43671)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+138) then
        player:AddItem(43672)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+139) then
        player:AddItem(43673)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+140) then
        player:AddItem(44923)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+141) then
        player:AddItem(43344)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+142) then
        player:AddItem(43381)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+143) then
        player:AddItem(43385)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+144) then
        player:AddItem(43386)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+145) then
        player:AddItem(43388)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+146) then
        player:AddItem(43725)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+147) then
        player:AddItem(43339)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+148) then
        player:AddItem(43357)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+149) then
        player:AddItem(43359)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+150) then
        player:AddItem(43360)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+151) then
        player:AddItem(43361)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+152) then
        player:AddItem(43362)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+153) then
        player:AddItem(43364)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+154) then
        player:AddItem(44920)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+155) then
        player:AddItem(43389)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+156) then
        player:AddItem(43390)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+157) then
        player:AddItem(43391)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+158) then
        player:AddItem(43392)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+159) then
        player:AddItem(43393)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+160) then
        player:AddItem(43394)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+161) then
        player:AddItem(43316)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+162) then
        player:AddItem(43331)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+163) then
        player:AddItem(43332)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+164) then
        player:AddItem(43334)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+165) then
        player:AddItem(43335)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+166) then
        player:AddItem(43674)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GLYPHS+167) then
        player:AddItem(44922)
        onGossipSelect(event, player, object, sender, INT_GLYPHS+2, code)
    elseif (intid == INT_GEMS) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some meta gems", 1, INT_GEMS+1)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some red gems", 1, INT_GEMS+2)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some blue gems", 1, INT_GEMS+3)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some yellow gems", 1, INT_GEMS+4)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some purple gems", 1, INT_GEMS+5)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some green gems", 1, INT_GEMS+6)
        player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want some orange gems", 1, INT_GEMS+7)
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_RETURN)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)

        --[[
        -- Meta Gems
        41285
        41307
        41333
        41335
        41339
        41375
        41376
        41377
        41378
        41379
        41380
        41381
        41382
        41385
        41389
        41395
        41396
        41397
        41398
        41400
        41401
        25890
        25893
        25894
        25895
        25896
        25897
        25898
        25899
        25901
        32409
        32410
        34220
        35501
        35503
        -- Red Gems
        40111
        40112
        40113
        40114
        40115
        40116
        40117
        40118
        -- Blue Gems
        40119
        40120
        40121
        40122
        -- Yellow Gems
        40123
        40124
        40125
        40126
        40127
        40128
        -- Purple Gems
        40129
        40130
        40131
        40132
        40133
        40134
        40135
        40136
        40137
        40138
        40139
        40140
        40141
        -- Green Gems
        40164
        40165
        40166
        40167
        40168
        40169
        40170
        40171
        40172
        40173
        40174
        40175
        40176
        40177
        40178
        40179
        40180
        40181
        40182
        -- Orange Gems
        40142
        40143
        40144
        40145
        40146
        40147
        40148
        40149
        40150
        40151
        40152
        40153
        40154
        40155
        40156
        40157
        40158
        40159
        40160
        40161
        40162
        40163
        --]]
    elseif (intid == INT_CONTAINERS) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_VENDOR, "|TInterface\\icons\\inv_crate_04:25:25:-19|tForor's Crate of Endless Resist Gear Storage", 1, INT_CONTAINERS+1)
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_RETURN)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_CONTAINERS+1) then
        player:AddItem(CONTAINER_BAG)
        onGossipSelect(event, player, object, sender, INT_CONTAINERS, code)
    elseif (intid == INT_UTILITIES) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON_MONEY_BAG, "I want to change my name", 1, INT_UTILITIES+1, false, "Do you wish to continue the transaction?", (UTILITIES_COST_RENAME * 10000))
        player:GossipMenuAddItem(GOSSIP_ICON_MONEY_BAG, "I want to change my appearance", 1, INT_UTILITIES+2, false, "Do you wish to continue the transaction?", (UTILITIES_COST_CUSTOMIZE * 10000))
        player:GossipMenuAddItem(GOSSIP_ICON_MONEY_BAG, "I want to change my faction", 1, INT_UTILITIES+3, false, "Do you wish to continue the transaction?", (UTILITIES_COST_FACTION_CHANGE * 10000))
        player:GossipMenuAddItem(GOSSIP_ICON_MONEY_BAG, "I want to change my race", 1, INT_UTILITIES+4, false, "Do you wish to continue the transaction?", (UTILITIES_COST_RACE_CHANGE * 10000))
        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_RETURN)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_UTILITIES+1) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            onGossipSelect(event, player, object, sender, INT_UTILITIES, code)
        else
            player:ModifyMoney(-(UTILITIES_COST_RENAME * 10000))
            player:SetAtLoginFlag(AT_LOGIN_RENAME)
            player:SendBroadcastMessage("You can now log out to apply the name change.")
            player:GossipComplete()
        end
    elseif (intid == INT_UTILITIES+2) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            onGossipSelect(event, player, object, sender, INT_UTILITIES, code)
        else
            player:ModifyMoney(-(UTILITIES_COST_CUSTOMIZE * 10000))
            player:SetAtLoginFlag(AT_LOGIN_CUSTOMIZE)
            player:SendBroadcastMessage("You can now log out to apply the customization.")
            player:GossipComplete()
        end
    elseif (intid == INT_UTILITIES+3) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            onGossipSelect(event, player, object, sender, INT_UTILITIES, code)
        else
            player:ModifyMoney(-(UTILITIES_COST_FACTION_CHANGE * 10000))
            player:SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION)
            player:SendBroadcastMessage("You can now log out to apply the faction change.")
            player:GossipComplete()
        end
    elseif (intid == INT_UTILITIES+4) then
        if (player:HasAtLoginFlag(AT_LOGIN_RENAME) or player:HasAtLoginFlag(AT_LOGIN_CUSTOMIZE) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_FACTION) or player:HasAtLoginFlag(AT_LOGIN_CHANGE_RACE)) then
            player:SendBroadcastMessage("You have to complete the previously activated feature before trying to perform another.")
            onGossipSelect(event, player, object, sender, INT_UTILITIES, code)
        else
            player:ModifyMoney(-(UTILITIES_COST_RACE_CHANGE * 10000))
            player:SetAtLoginFlag(AT_LOGIN_CHANGE_RACE)
            player:SendBroadcastMessage("You can now log out to apply the race change.")
            player:GossipComplete()
        end
    elseif (intid == INT_MISCELLANEOUS) then
        player:GossipClearMenu()

        if (player:GetClass() == CLASS_SHAMAN) then
            player:GossipMenuAddItem(GOSSIP_ICON_TALK, "I want totems", 1, INT_MISCELLANEOUS+1)
        end

        player:GossipMenuAddItem(GOSSIP_ICON_CHAT, "Return to previous page", 1, INT_RETURN)
        player:GossipSendMenu(0x7FFFFFFF, object, 1)
    elseif (intid == INT_MISCELLANEOUS+1) then
        local TOTEM_EARTHEN_RING = 46978
        local TOTEM_EARTH        = 5175
        local TOTEM_FIRE         = 5176
        local TOTEM_WATER        = 5177
        local TOTEM_AIR          = 5178

        if not (player:HasItem(TOTEM_EARTHEN_RING, 1, true)) then
            if not (player:HasItem(TOTEM_EARTH, 1, true)) then
                player:AddItem(TOTEM_EARTH)
            end

            if not (player:HasItem(TOTEM_FIRE, 1, true)) then
                player:AddItem(TOTEM_FIRE)
            end

            if not (player:HasItem(TOTEM_WATER, 1, true)) then
                player:AddItem(TOTEM_WATER)
            end

            if not (player:HasItem(TOTEM_AIR, 1, true)) then
                player:AddItem(TOTEM_AIR)
            end
        end

        onGossipSelect(event, player, object, sender, INT_MISCELLANEOUS, code)
    end
end

RegisterPlayerGossipEvent(1, 2, onGossipSelect)
