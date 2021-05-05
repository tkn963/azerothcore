-- Set spawn to Orgrimmar for horde
UPDATE `playercreateinfo` SET `map`=1, `zone`=1637, `position_x`=1632.663452, `position_y`=-4413.136719, `position_z`=17.030386, `orientation`=0.007035 WHERE `race` IN (2, 5, 6, 8, 10) AND `class` NOT LIKE 6;
-- Set spawn to Stormwind for alliance
UPDATE `playercreateinfo` SET `map`=0, `zone`=1519, `position_x`=-8831.482422, `position_y`=624.786682, `position_z`=93.901566, `orientation`=0.794381 WHERE `race` IN (1, 3, 4, 7, 11) AND `class` NOT LIKE 6;

/*-- Set class spell prices to 0
-- Warrior
UPDATE `npc_trainer` SET `MoneyCost`=0 WHERE `ID` IN (200001, 200002);
-- Paladin
UPDATE `npc_trainer` SET `MoneyCost`=0 WHERE `ID` IN (200003, 200004, 200020, 200021);
-- Hunter
UPDATE `npc_trainer` SET `MoneyCost`=0 WHERE `ID` IN (200013, 200014);
-- Rogue
UPDATE `npc_trainer` SET `MoneyCost`=0 WHERE `ID` IN (200015, 200016);
-- Priest
UPDATE `npc_trainer` SET `MoneyCost`=0 WHERE `ID` IN (200011, 200012);
-- Death Knight
UPDATE `npc_trainer` SET `MoneyCost`=0 WHERE `ID` IN (200019);
-- Shaman
UPDATE `npc_trainer` SET `MoneyCost`=0 WHERE `ID` IN (200017, 200018);
-- Mage
UPDATE `npc_trainer` SET `MoneyCost`=0 WHERE `ID` IN (200007, 200008);
-- Warlock
UPDATE `npc_trainer` SET `MoneyCost`=0 WHERE `ID` IN (200009, 200010);
-- Druid
UPDATE `npc_trainer` SET `MoneyCost`=0 WHERE `ID` IN (200005, 200006);

-- Spawn Kickstarter
-- Horde
DELETE FROM `creature` WHERE `guid`=9000000;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(9000000, 9000000, 1, 1637, 1637, 1651.787964, -4428.298828, 17.071730, 1.782035);
-- Alliance
DELETE FROM `creature` WHERE `guid`=9000001;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(9000001, 9000000, 0, 1519, 1519, -8827.855469, 647.297913, 94.538979, 5.294718);*/
