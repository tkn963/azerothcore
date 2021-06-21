function hasItemEquipped(player)
    for i = EQUIPMENT_SLOT_HEAD, EQUIPMENT_SLOT_RANGED do
        if not (player:GetEquippedItemBySlot(i) == nil) then
            player:SendNotification("You need to unequip all of your items before you can do this")
            return true
        end
    end

    return false
end
