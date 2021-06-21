-- Requires
require("class_ids")
require("class_spells")
require("events")
require("proficiencies")

-- Features
local ENABLE_SPELLS_ON_LEVEL_UP      = true -- Automatically learn new spells when leveling up
local ENABLE_TALENTS_ON_LEVEL_UP     = true -- Automatically learn new ranks of talents when leveling up
local ENABLE_PROFICIENCY_ON_LEVEL_UP = true -- Automatically learn new weapon and armor skills when leveling up
local ENABLE_MAX_SKILL_ON_LEVEL      = true -- Set weapon skills to thier maximum value when leveling up
local MAX_SKILL_MAX_LEVEL            = 70 -- Last level when a players skills will be set to their maximum value

-- Player levels up
function playerClassSpells(event, player, oldLevel)
    if (ENABLE_SPELLS_ON_LEVEL_UP) then
        local count = 0
        for _ in pairs(CLASS_SPELL_LIST[player:GetClass()]) do count = count + 1 end

        for i=1,count do
            if (CLASS_SPELL_LIST[player:GetClass()][i][2] <= player:GetLevel()) then
                if not (player:HasSpell(CLASS_SPELL_LIST[player:GetClass()][i][1])) then
                    player:LearnSpell(CLASS_SPELL_LIST[player:GetClass()][i][1])
                end
            end
        end
    end

    if (ENABLE_TALENTS_ON_LEVEL_UP) then
        local count = 0
        for _ in pairs(CLASS_TALENT_LIST[player:GetClass()]) do count = count + 1 end

        for i=1,count do
            if (CLASS_TALENT_LIST[player:GetClass()][i][2] <= player:GetLevel() and player:HasSpell(CLASS_TALENT_LIST[player:GetClass()][i][3])) then
                if not (player:HasSpell(CLASS_TALENT_LIST[player:GetClass()][i][1])) then
                    player:LearnSpell(CLASS_TALENT_LIST[player:GetClass()][i][1])
                end
            end
        end
    end

    if (ENABLE_PROFICIENCY_ON_LEVEL_UP) then
        local count = 0
        for _ in pairs(CLASS_PROFICIENCY_LIST[player:GetClass()]) do count = count + 1 end

        for i=1,count do
            if (CLASS_PROFICIENCY_LIST[player:GetClass()][i][2] <= player:GetLevel()) then
                if not (player:HasSpell(CLASS_PROFICIENCY_LIST[player:GetClass()][i][1])) then
                    player:LearnSpell(CLASS_PROFICIENCY_LIST[player:GetClass()][i][1])
                end
            end
        end
    end

    if (ENABLE_MAX_SKILL_ON_LEVEL) then
        if (player:GetLevel() <= MAX_SKILL_MAX_LEVEL) then
            player:AdvanceSkillsToMax()
        end
    end
end

RegisterPlayerEvent(EVENT_ON_LEVEL_CHANGED, playerClassSpells)
