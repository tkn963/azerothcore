-- ----------------------------------------------------------
-- Heirloom Vendor - Armor
-- ----------------------------------------------------------
DELETE FROM `creature_template` WHERE `entry`=9000010;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(9000010, 15322, 'Cenarion Emissary Blackhoof', 'Heirloom Armor', 1, 1, 35, 128, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=9000010;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(9000010, 9000010, 571, 4395, 4395, 5809.225586, 622.384949, 647.759766, 2.174072);

DELETE FROM `npc_vendor` WHERE `entry`=9000010 AND `item` IN (42943, 42944, 42945, 42946, 42947, 42948, 44091, 44092, 44093, 44094, 44095, 44096, 48716, 48718);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 42943);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 42944);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 42945);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 42946);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 42947);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 42948);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 44091);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 44092);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 44093);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 44094);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 44095);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 44096);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 48716);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 48718);

DELETE FROM `npc_vendor` WHERE `entry`=9000010 AND `item` IN (49177);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000010, 49177);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Heirloom Vendor - Weapons
-- ----------------------------------------------------------
DELETE FROM `creature_template` WHERE `entry`=9000011;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(9000011, 18648, 'Emissary Mordin', 'Heirloom Weapons', 1, 1, 35, 128, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=9000011;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(9000011, 9000011, 571, 4395, 4395, 5799.781738, 621.482483, 647.510315, 1.333695);

DELETE FROM `npc_vendor` WHERE `entry`=9000011 AND `item` IN (42949, 42950, 42951, 42952, 42984, 42985, 44099, 44100, 44101, 44102, 44103, 44105, 44107, 48677, 48683, 48685, 48687, 48689, 48691, 50255, 42991, 42992, 44097, 44098);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 42949);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 42950);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 42951);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 42952);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 42984);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 42985);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 44099);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 44100);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 44101);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 44102);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 44103);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 44105);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 44107);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 48677);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 48683);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 48685);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 48687);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 48689);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 48691);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 50255);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 42991);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 42992);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 44097);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 44098);

DELETE FROM `npc_vendor` WHERE `entry`=9000011 AND `item` IN (49177);
INSERT INTO `npc_vendor` (`entry`, `item`) VALUES (9000011, 49177);
-- ----------------------------------------------------------
