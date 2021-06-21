-- Requires
require("config")
require("class_ids")
require("class_spells")
require("events")
require("proficiencies")

-- Learn class spells
function classSpells(player)
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
end

-- Learn class talent ranks
function classTalents(player)
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
end

-- Learn class proficiencies
function classProficiencies(player)
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
end

-- Set skills to max
function classMaxSkill(player)
    if (ENABLE_MAX_SKILL_ON_LEVEL) then
        if (player:GetLevel() <= MAX_SKILL_MAX_LEVEL) then
            player:AdvanceSkillsToMax()
        end
    end
end

-- Character logs in for the first time
function classOnFirstLogin(event, player)
    classSpells(player)
    classTalents(player)
    classProficiencies(player)
    classMaxSkill(player)
end

RegisterPlayerEvent(EVENT_ON_FIRST_LOGIN, classOnFirstLogin)

-- Player levels up
function classOnLevelChanged(event, player, oldLevel)
    classSpells(player)
    classTalents(player)
    classProficiencies(player)
    classMaxSkill(player)
end

RegisterPlayerEvent(EVENT_ON_LEVEL_CHANGED, classOnLevelChanged)
