-- Events
local EVENT_ON_GIVE_XP             = 12
local EVENT_ON_REPUTATION_CHANGE   = 15
local EVENT_ON_LOOT_MONEY          = 37

-- Experience, money and reputation rates
local ENABLE_EXPERIENCE_MULTIPLIER = true -- Enable the experience multiplier
local ENABLE_REPUTATION_MULTIPLIER = true -- Enable the reputation multiplier
local ENABLE_MONEY_LOOT_MULTIPLIER = true -- Enable the money loot multiplier
local ENABLE_WEEKEND_MULTIPLIER    = true -- Changes the multiplier on friday, saturday and sunday
local MULTIPLIER_WEEKEND           = 2 -- Multiplier for all rates on weekends
local RATE_MULTIPLIER              = { -- Multiplier for specific levels. It's modular so you can set your own level ranges
--    Min level  Max level  Multiplier
    { 1,         59,        4 },
    { 60,        69,        3 },
    { 70,        79,        2 },
    { 80,        80,        1 },
}

-- Calculate multiplier
function rateMultiplier(player)
    local multiplier = 1

    local count = 0
    for _ in pairs(RATE_MULTIPLIER) do count = count + 1 end

    for i=1,count do
        if (player:GetLevel() >= RATE_MULTIPLIER[i][1] and player:GetLevel() <= RATE_MULTIPLIER[i][2]) then
            multiplier = RATE_MULTIPLIER[3]
            break
        end
    end

    if (ENABLE_WEEKEND_MULTIPLIER) then
        if (os.date("*t").wday == 6 or os.date("*t").wday == 7 or os.date("*t").wday == 8) then
            multiplier = multiplier * MULTIPLIER_WEEKEND
        end
    end

    return multiplier
end

-- Character gains experience
function onGiveXP(event, player, amount, victim)
    if (ENABLE_EXPERIENCE_MULTIPLIER) then
        return amount * rateMultiplier(player)
    end
end

RegisterPlayerEvent(EVENT_ON_GIVE_XP, onGiveXP)

-- Character gains reputation
function onReputationChange(event, player, factionId, standing, incremenetal)
    if (ENABLE_REPUTATION_MULTIPLIER) then
        return standing * rateMultiplier(player)
    end
end

RegisterPlayerEvent(EVENT_ON_REPUTATION_CHANGE, onReputationChange)
