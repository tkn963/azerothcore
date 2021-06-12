local EVENT_ON_CREATURE_KILL = 7

local MAX_LEVEL_ABOVE_CREATURE = 4 -- A creature can not be more levels below the player than this number in order to give the player money on kill

local GIVE_MONEY_TO_GROUP = true -- Give money to every member of the killers party, if any
local GIVE_MONEY_TO_RAID = false -- Give money to all of the raid, if any, if GIVE_MONEY_TO_GROUP is enabled

local MAX_DISTANCE_FROM_KILLER = 50 -- Max distance a member of the party or raid can be from the killer in order to get money for the kill

local MONEY_PER_KILL = { -- Money in copper to give to the player when they kill a creature
    1000, -- Level 1
    1000, -- Level 2
    1000, -- Level 3
    1000, -- Level 4
    1000, -- Level 5
    1000, -- Level 6
    1000, -- Level 7
    1000, -- Level 8
    1000, -- Level 9
    1000, -- Level 10
    1000, -- Level 11
    1000, -- Level 12
    1000, -- Level 13
    1000, -- Level 14
    1000, -- Level 15
    1000, -- Level 16
    1000, -- Level 17
    1000, -- Level 18
    1000, -- Level 19
    1000, -- Level 20
    1000, -- Level 21
    1000, -- Level 22
    1000, -- Level 23
    1000, -- Level 24
    1000, -- Level 25
    1000, -- Level 26
    1000, -- Level 27
    1000, -- Level 28
    1000, -- Level 29
    1000, -- Level 30
    1000, -- Level 31
    1000, -- Level 32
    1000, -- Level 33
    1000, -- Level 34
    1000, -- Level 35
    1000, -- Level 36
    1000, -- Level 37
    1000, -- Level 38
    1000, -- Level 39
    1000, -- Level 40
    1000, -- Level 41
    1000, -- Level 42
    1000, -- Level 43
    1000, -- Level 44
    1000, -- Level 45
    1000, -- Level 46
    1000, -- Level 47
    1000, -- Level 48
    1000, -- Level 49
    1000, -- Level 50
    1000, -- Level 51
    1000, -- Level 52
    1000, -- Level 53
    1000, -- Level 54
    1000, -- Level 55
    1000, -- Level 56
    1000, -- Level 57
    1000, -- Level 58
    1000, -- Level 59
    1000, -- Level 60
    1000, -- Level 61
    1000, -- Level 62
    1000, -- Level 63
    1000, -- Level 64
    1000, -- Level 65
    1000, -- Level 66
    1000, -- Level 67
    1000, -- Level 68
    1000, -- Level 69
    1000, -- Level 70
    1000, -- Level 71
    1000, -- Level 72
    1000, -- Level 73
    1000, -- Level 74
    1000, -- Level 75
    1000, -- Level 76
    1000, -- Level 77
    1000, -- Level 78
    1000, -- Level 79
    1000  -- Level 80
}

function onCreatureKill(event, killer, killed)
    if (GIVE_MONEY_TO_GROUP and killer:IsInGroup()) then
        for _, v in ipairs(killer:GetGroup():GetMembers()) do
            if v:IsInWorld() then
                if (killed:GetLevel() >= v:GetLevel()-MAX_LEVEL_ABOVE_CREATURE and killed:GetLevel() >= killer:GetLevel()-MAX_LEVEL_ABOVE_CREATURE) then
                    if (killer:GetDistance(v) <= MAX_DISTANCE_FROM_KILLER) then
                        if (GIVE_MONEY_TO_RAID) then
                            v:ModifyMoney(MONEY_PER_KILL[v:GetLevel()])
                        elseif (killer:GetGroup():SameSubGroup(killer, v)) then
                            v:ModifyMoney(MONEY_PER_KILL[v:GetLevel()])
                        end
                    end
                end
            end
        end
    else
        if (killed:GetLevel() >= killer:GetLevel()-MAX_LEVEL_ABOVE_CREATURE) then
            killer:ModifyMoney(MONEY_PER_KILL[killer:GetLevel()])
        end
    end
end

RegisterPlayerEvent(EVENT_ON_CREATURE_KILL, onCreatureKill)
