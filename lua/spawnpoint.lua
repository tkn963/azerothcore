-- Requires
require("class_ids")
require("events")

-- Character logs in for the first time
function spawnOnFirstLogin(event, player)
    if not (player:GetClass() == CLASS_DEATH_KNIGHT) then
        if (player:GetTeam() == TEAM_ALLIANCE) then
            player:Teleport(0, -8830.438477, 626.666199, 93.982887, 0.682076)
            player:SetBindPoint(-8830.438477, 626.666199, 93.982887, 0.682076, 0, 1519)
        elseif (player:GetTeam() == TEAM_HORDE) then
            player:Teleport(1, 1630.776001, -4412.993652, 16.567701, 0.080535)
            player:SetBindPoint(1630.776001, -4412.993652, 16.567701, 0.080535, 1, 1637)
        end
    end
end

RegisterPlayerEvent(EVENT_ON_FIRST_LOGIN, spawnOnFirstLogin)
