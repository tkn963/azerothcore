-- ----------------------------------------------------------
-- Ragefire Chasm
-- ----------------------------------------------------------
SET @Entry := 9000100;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 16, 16, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 389, 2437, 2437, 15248, 5.932387, -26.050083, -20.757383, 2.230886);

-- Searching for the Lost Satchel
SET @Quest := 5722;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
SET @Quest := 5724;
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Testing an Enemy's Strength
SET @Quest := 5723;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Hidden Enemies
SET @Quest := 5728;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Slaying the Beast
SET @Quest := 5761;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Power to Destroy...
SET @Quest := 14356;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Wailing Caverns
-- ----------------------------------------------------------
SET @Entry := 9000101;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 20, 20, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 43, 718, 718, 15248, -160.318878, 124.585793, -74.088326, 1.012204);

-- Leaders of the Fang
SET @Quest := 914;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Serpentbloom
SET @Quest := 962;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Deviate Hides
SET @Quest := 1486;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Deviate Eradication
SET @Quest := 1487;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Smart Drinks
SET @Quest := 1491;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Deadmines
-- ----------------------------------------------------------
SET @Entry := 9000102;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 20, 20, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 36, 1581, 1581, 15248, -11.191869, -383.491119, 62.211040, 3.025098);

-- The Defias Brotherhood
SET @Quest := 166;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Red Silk Bandanas
SET @Quest := 214;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Underground Assault
SET @Quest := 2040;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Shadowfang Keep
-- ----------------------------------------------------------
SET @Entry := 9000103;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 20, 20, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 33, 209, 209, 15248, -217.310745, 2120.118408, 80.152290, 3.968776);

-- The Book of Ur
SET @Quest := 1013;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Arugal Must Die
SET @Quest := 1014;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Deathstalkers in Shadowfang
SET @Quest := 1098;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Blackfathom Deeps
-- ----------------------------------------------------------
SET @Entry := 9000104;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 24, 24, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 48, 719, 719, 15248, -150.129486, 81.555962, -43.927952, 2.193446);

-- Knowledge in the Deeps
SET @Quest := 971;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- In Search of Thaelrid
SET @Quest := 1198;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Twilight Falls
SET @Quest := 1199;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Blackfathom Villainy
SET @Quest := 1200;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Researching the Corruption
SET @Quest := 1275;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Blackfathom Villainy
SET @Quest := 6561;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Allegiance to the Old Gods
SET @Quest := 6565;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Amongst the Ruins
SET @Quest := 6921;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Stockade
-- ----------------------------------------------------------
SET @Entry := 9000105;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 25, 25, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 34, 717, 717, 15248, 53.081776, 5.022602, -17.917654, 4.803876);

-- Crime and Punishment
SET @Quest := 377;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Fury Runs Deep
SET @Quest := 378;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- What Comes Around...
SET @Quest := 386;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Quell The Uprising
SET @Quest := 387;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Color of Blood
SET @Quest := 388;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Stockade Riots
SET @Quest := 391;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Razorfen Kraul
-- ----------------------------------------------------------
SET @Entry := 9000106;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 37, 37, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 47, 491, 491, 15248, 1941.500732, 1556.740356, 81.506493, 6.135584);

-- Crate with Holes (Blueleaf Tubers)
DELETE FROM `gameobject` WHERE `guid`=@Entry;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES
(@Entry, 21277, 47, 0, 0, 1941.8, 1558.89, 81.7565, 6.02563, 1);

-- Snufflenose Owner's Manual (Blueleaf Tubers)
DELETE FROM `gameobject` WHERE `guid`=@Entry+1;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES
(@Entry+1, 21530, 47, 0, 0, 1942.08, 1560.38, 81.9439, 6.10024, 1);

-- Snufflenose Command Sticks (Blueleaf Tubers)
DELETE FROM `gameobject` WHERE `guid`=@Entry+2;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES
(@Entry+2, 68865, 47, 0, 0, 1942.41, 1561.77, 82.1205, 6.09238, 1);

-- The Crone of the Kraul
SET @Quest := 1101;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- A Vengeful Fate
SET @Quest := 1102;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Going, Going, Guano!
SET @Quest := 1109;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Blueleaf Tubers
SET @Quest := 1221;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Gnomeregan
-- ----------------------------------------------------------
SET @Entry := 9000107;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 28, 28, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 90, 721, 721, 15248, -329.518494, 2.273906, -152.843903, 4.297603);

-- Rig Wars
SET @Quest := 2841;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Essential Artificials
SET @Quest := 2924;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Gyrodrillmatic Excavationators
SET @Quest := 2928;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Grand Betrayal
SET @Quest := 2929;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Only Cure is More Green Glow
SET @Quest := 2962;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Razorfen Downs
-- ----------------------------------------------------------
SET @Entry := 9000108;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 37, 37, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 129, 722, 722, 15248, 2596.764160, 1101.787231, 52.110310, 3.232038);

-- Bring the End
SET @Quest := 3341;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Bring the Light
SET @Quest := 3636;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Scarlet Monastery
-- ----------------------------------------------------------
SET @Entry := 9000109;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 37, 37, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 189, 796, 796, 15248, 1686.425903, 1054.362671, 18.677500, 5.424347);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry+1, @Entry, 189, 796, 796, 15248, 252.909058, -209.867447, 18.677299, 0.766019);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry+2, @Entry, 189, 796, 796, 15248, 851.822449, 1323.248047, 18.671103, 5.534225);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry+3, @Entry, 189, 796, 796, 15248, 1625.116333, -311.625702, 18.007574, 4.658371);

-- Compendium of the Fallen
SET @Quest := 1049;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Mythology of the Titans
SET @Quest := 1050;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- In the Name of the Light
SET @Quest := 1053;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Hearts of Zeal
SET @Quest := 1113;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Test of Lore
SET @Quest := 1160;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Into The Scarlet Monastery
SET @Quest := 14355;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Uldaman
-- ----------------------------------------------------------
/*SET @Entry := 9000113;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 40, 40, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 70, 1337, 1337, 15248, -227.971207, 68.912483, -46.037704, 4.688672);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Zul'Farrak
-- ----------------------------------------------------------
SET @Entry := 9000114;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 46, 46, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 209, 1176, 1176, 15248, 1217.395996, 831.202515, 8.902082, 1.051672);

-- Divino-matic Rod
SET @Quest := 2768;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Gahz'rilla
SET @Quest := 2770;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Tiara of the Deep
SET @Quest := 2846;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Scarab Shells
SET @Quest := 2865;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- The Spider God
SET @Quest := 2936;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Nekrum's Medallion
SET @Quest := 2991;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Troll Temper
SET @Quest := 3042;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Prophecy of Mosh'aru
SET @Quest := 3527;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Maraudon
-- ----------------------------------------------------------
SET @Entry := 9000115;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 48, 48, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 349, 2100, 2100, 15248, 1017.726929, -451.871216, -43.446407, 5.078657);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry+1, @Entry, 349, 2100, 2100, 15248, 740.835632, -597.290771, -32.653210, 5.509045);

-- Twisted Evils
SET @Quest := 7028;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Vyletongue Corruption (Horde)
SET @Quest := 7029;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Vyletongue Corruption (Alliance)
SET @Quest := 7041;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Legends of Maraudon
SET @Quest := 7044;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Corruption of Earth and Seed (Horde)
SET @Quest := 7064;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Corruption of Earth and Seed (Alliance)
SET @Quest := 7065;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Temple of Atal'Hakkar (Sunken Temple)
-- ----------------------------------------------------------
SET @Entry := 9000117;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 50, 50, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 109, 1477, 1477, 15248, -320.984436, 78.934074, -131.850006, 2.265926);

-- The Temple of Atal'Hakkar
SET @Quest := 1445;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Jammal'an the Prophet
SET @Quest := 1446;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Into the Depths
SET @Quest := 3446;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Secret of the Circle
SET @Quest := 3447;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- The God Hakkar
SET @Quest := 3528;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Haze of Evil
SET @Quest := 4143;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Zapper Fuel
SET @Quest := 4146;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Blackrock Depths
-- ----------------------------------------------------------
SET @Entry := 9000118;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 56, 56, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 230, 1584, 1584, 15248, 443.845032, 23.719954, -70.480469, 5.260233);

-- Dark Iron Legacy
SET @Quest := 3802;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Disharmony of Fire
SET @Quest := 3907;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- The Royal Rescue
SET @Quest := 4003;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- A Taste of Flame
SET @Quest := 4024;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- The Rise of the Machines
SET @Quest := 4063;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- The Heart of the Mountain
SET @Quest := 4123;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Hurley Blackbreath
SET @Quest := 4126;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Operation: Death to Angerforge
SET @Quest := 4132;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Lost Thunderbrew Recipe
SET @Quest := 4134;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Ribbly Screwspigot
SET @Quest := 4136;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Incendius!
SET @Quest := 4263;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- The Good Stuff
SET @Quest := 4286;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Fate of the Kingdom
SET @Quest := 4362;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- The Last Element
SET @Quest := 7201;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Attunement to the Core (Horde)
SET @Quest := 7487;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Attunement to the Core (Alliance)
SET @Quest := 7848;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Stratholme
-- ----------------------------------------------------------
SET @Entry := 9000119;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 60, 60, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 329, 2017, 2017, 15248, 3387.887207, -3379.173828, 142.760788, 6.281084);

-- The Flesh Does Not Lie
SET @Quest := 5212;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Active Agent
SET @Quest := 5213;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- The Great Fras Siabi
SET @Quest := 5214;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Houses of the Holy
SET @Quest := 5243;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Archivist
SET @Quest := 5251;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Truth Comes Crashing Down
SET @Quest := 5262;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Above and Beyond
SET @Quest := 5263;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Menethil's Gift
SET @Quest := 5463;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Of Love and Family
SET @Quest := 5848;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Ramstein
SET @Quest := 6163;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Scholomance
-- ----------------------------------------------------------
SET @Entry := 9000120;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 60, 60, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 289, 2057, 2057, 15248, 202.186020, 129.245758, 134.910004, 3.898742);

-- Dawn's Gambit
SET @Quest := 4771;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Barov Family Fortune (Horde)
SET @Quest := 5341;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Barov Family Fortune (Alliance)
SET @Quest := 5343;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Doctor Theolen Krastinov, the Butcher
SET @Quest := 5382;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Kirtonos the Herald
SET @Quest := 5384;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Krastinov's Bag of Horrors
SET @Quest := 5515;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Plagued Hatchlings
SET @Quest := 5529;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Dire Maul
-- ----------------------------------------------------------
-- East
SET @Entry := 9000121;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 60, 60, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 429, 2557, 2557, 15248, -201.015717, -335.113678, -2.725355, 0.613636);

-- Shards of the Felvine
SET @Quest := 5526;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Pusillin and the Elder Azj'Tordin
SET @Quest := 7441;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Lethtendris's Web (Alliance)
SET @Quest := 7488;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Lethtendris's Web (Horde)
SET @Quest := 7489;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- North
SET @Entry := 9000122;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 60, 60, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 429, 2557, 2557, 15248, 248.960388, -33.690758, -2.587370, 0.765152);

-- Elven Legends (Horde)
SET @Quest := 7481;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Elven Legends (Alliance)
SET @Quest := 7482;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Blackrock Spire
-- ----------------------------------------------------------
SET @Entry := 9000123;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 60, 60, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 229, 1583, 1583, 15248, 75.098602, -227.298584, 49.754997, 0.144138);

-- Lower
-- Put Her Down
SET @Quest := 4701;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Pack Mistress
SET @Quest := 4724;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Kibler's Exotic Pets
SET @Quest := 4729;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- The Final Tablets
SET @Quest := 4788;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- En-Ay-Es-Tee-Why
SET @Quest := 4862;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Mother's Milk
SET @Quest := 4866;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Warlord's Command
SET @Quest := 4903;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Operative Bijou
SET @Quest := 4981;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Bijou's Reconnaissance Report
SET @Quest := 4983;
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Message to Maxwell
SET @Quest := 5002;
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Maxwell's Mission
SET @Quest := 5081;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Upper
-- Egg Freezing
SET @Quest := 4734;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Egg Collection
SET @Quest := 4735;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Doomrigger's Clasp
SET @Quest := 4764;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- The Darkstone Tablet
SET @Quest := 4768;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- For The Horde!
SET @Quest := 4974;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Hellfire Ramparts
-- ----------------------------------------------------------
SET @Entry := 9000124;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 61, 61, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 543, 3562, 3562, 15248, -1363.565308, 1648.090942, 68.430687, 0.197461);

-- Weaken the Ramparts (Horde)
SET @Quest := 9572;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Weaken the Ramparts (Alliance)
SET @Quest := 9575;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Blood Furnace
-- ----------------------------------------------------------
SET @Entry := 9000125;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 63, 63, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 542, 3713, 3713, 15248, -9.681078, 10.342448, -44.697002, 5.295887);

-- The Blood is Life (Alliance)
SET @Quest := 9589;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- The Blood is Life (Horde)
SET @Quest := 9590;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Slave Pens
-- ----------------------------------------------------------
/*SET @Entry := 9000126;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 64, 64, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 547, 3717, 3717, 15248, 135.673706, -119.109886, -1.590557, 2.982134);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Underbog
-- ----------------------------------------------------------
/*SET @Entry := 9000127;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 65, 65, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 546, 3716, 3716, 15248, 43.963852, -16.454206, -2.755201, 4.117830);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Mana-Tombs
-- ----------------------------------------------------------
/*SET @Entry := 9000128;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 66, 66, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 557, 3792, 3792, 15248, -3.271465, 7.528450, -0.954300, 4.668355);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Auchenai Crypts
-- ----------------------------------------------------------
/*SET @Entry := 9000129;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 67, 67, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 558, 3790, 3790, 15248, -18.753958, -7.163058, -0.120600, 1.606138);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Old Hillsbrad Foothills
-- ----------------------------------------------------------
/*SET @Entry := 9000130;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 68, 68, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 560, 2367, 2367, 15248, 2720.402588, 1306.491211, 14.496667, 0.384049);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Steamvault
-- ----------------------------------------------------------
/*SET @Entry := 9000131;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 69, 69, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 545, 3715, 3715, 15248, 9.032151, 9.713045, -3.908064, 3.628544);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Shattered Halls
-- ----------------------------------------------------------
/*SET @Entry := 9000132;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 69, 69, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 540, 3714, 3714, 15248, -21.925442, 1.835999, -13.115076, 4.739878);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Mechanar
-- ----------------------------------------------------------
/*SET @Entry := 9000133;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 69, 69, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 554, 3849, 3849, 15248, -28.189423, -10.620949, -1.812820, 0.821168);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Botanica
-- ----------------------------------------------------------
/*SET @Entry := 9000134;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 69, 69, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 553, 3847, 3847, 15248, 25.963009, -6.480484, -1.083299, 4.836117);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Shadow Labyrinth
-- ----------------------------------------------------------
/*SET @Entry := 9000135;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 69, 69, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 555, 3789, 3789, 15248, 3.135054, 6.700622, -1.127880, 3.833485);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Sethekk Halls
-- ----------------------------------------------------------
/*SET @Entry := 9000136;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 69, 69, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 556, 3791, 3791, 15248, 27.057100, -4.731260, 0.006200, 3.069330);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Black Morass
-- ----------------------------------------------------------
/*SET @Entry := 9000137;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 70, 70, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 269, 2366, 2366, 15248, -1475.968140, 7057.547363, 33.296432, 3.692997);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Arcatraz
-- ----------------------------------------------------------
/*SET @Entry := 9000138;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 70, 70, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 552, 3848, 3848, 15248, 11.828168, -5.482939, -0.205258, 2.422960);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Magister's Terrace
-- ----------------------------------------------------------
/*SET @Entry := 9000139;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 70, 70, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 585, 4131, 4131, 15248, 15.428506, -10.098178, -2.809786, 2.362998);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Utgarde Keep
-- ----------------------------------------------------------
SET @Entry := 9000140;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 70, 70, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 574, 206, 206, 15248, 165.224960, -70.167709, 12.553828, 4.325240);

-- Into Utgarde!
SET @Quest := 11252;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Ingvar Must Die!
SET @Quest := 11262;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- A Score to Settle
SET @Quest := 11272;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Disarmament (Alliance)
SET @Quest := 13205;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Disarmament (Horde)
SET @Quest := 13206;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Nexus
-- ----------------------------------------------------------
SET @Entry := 9000141;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 71, 71, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 576, 4265, 4265, 15248, 145.605423, -3.024071, -16.636038, 4.720644);

-- Postponing the Inevitable
SET @Quest := 11905;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Quickening
SET @Quest := 11911;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Prisoner of War
SET @Quest := 11973;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Have They No Shame? (Alliance)
SET @Quest := 13094;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Have They No Shame? (Horde)
SET @Quest := 13095;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Azjol-Nerub
-- ----------------------------------------------------------
SET @Entry := 9000142;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 72, 72, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 601, 4277, 4277, 15248, 444.840454, 792.553772, 828.904968, 3.705367);

-- Death to the Traitor King
SET @Quest := 13167;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Don't Forget the Eggs!
SET @Quest := 13182;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Ahn'kahet: The Old Kingdom
-- ----------------------------------------------------------
SET @Entry := 9000143;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 73, 73, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 619, 4623, 4623, 15248, 364.130646, -1078.684814, 47.360531, 6.113483);

-- The Faceless Ones
SET @Quest := 13187;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- All Things in Good Time
SET @Quest := 13190;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Funky Fungi
SET @Quest := 13204;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Drak'Tharon Keep
-- ----------------------------------------------------------
SET @Entry := 9000144;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 74, 74, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 600, 4196, 4196, 15248, -515.140625, -537.538208, 11.024030, 2.419826);

-- Search and Rescue
SET @Quest := 12037;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Cleansing Drak'Tharon
SET @Quest := 12238;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Head Games
SET @Quest := 13129;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Violet Hold
-- ----------------------------------------------------------
SET @Entry := 9000145;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 75, 75, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 608, 4415, 4415, 15248, 1831.098877, 793.833801, 44.333935, 6.282004);

-- Containment
SET @Quest := 13159;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Gundrak
-- ----------------------------------------------------------
SET @Entry := 9000146;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 76, 76, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 604, 4416, 4416, 15248, 1874.995972, 658.413147, 176.681229, 4.017632);

-- Gal'darah Must Pay
SET @Quest := 13096;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- For Posterity
SET @Quest := 13098;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- One of a Kind
SET @Quest := 13111;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Halls of Stone
-- ----------------------------------------------------------
/*SET @Entry := 9000147;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 77, 77, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 599, 4264, 4264, 15248, 1144.786987, 802.957642, 195.936998, 0.014390);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Utgarde Pinnacle
-- ----------------------------------------------------------
/*SET @Entry := 9000148;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 79, 79, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 575, 1196, 1196, 15248, 571.840942, -334.676056, 110.139084, 1.539422);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Trial of the Champion
-- ----------------------------------------------------------
/*SET @Entry := 9000149;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 79, 79, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 650, 4723, 4723, 15248, 800.261108, 610.237427, 412.356415, 2.949251);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Oculus
-- ----------------------------------------------------------
SET @Entry := 9000150;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 79, 79, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 578, 4228, 4228, 15248, 1051.802368, 996.073669, 361.083221, 5.387641);

-- The Struggle Persists
SET @Quest := 13124;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);

-- A Unified Front
SET @Quest := 13126;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Mage-Lord Urom
SET @Quest := 13127;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- A Wing and a Prayer
SET @Quest := 13128;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Culling of Stratholme
-- ----------------------------------------------------------
/*SET @Entry := 9000151;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 79, 79, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 595, 4100, 4100, 15248, 1470.156006, 508.931122, 35.828003, 2.175483);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Halls of Lightning
-- ----------------------------------------------------------
SET @Entry := 9000152;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 79, 79, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 602, 4272, 4272, 15248, 1318.072144, 237.991486, 52.988964, 6.269638);

-- Whatever it Takes!
SET @Quest := 13108;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;

-- Diametrically Opposed
SET @Quest := 13109;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
DELETE FROM `creature_questender` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (@Entry, @Quest);
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `id`=@Quest;
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- The Forge of Souls
-- ----------------------------------------------------------
SET @Entry := 9000153;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 80, 80, 35, 3, 0, 0, 0, 0, 1);

DELETE FROM `creature` WHERE `id`=@Entry;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `modelid`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@Entry, @Entry, 632, 4809, 4809, 15248, 4919.859375, 2200.539062, 638.733948, 3.633251);

-- Inside the Frozen Citadel (Horde)
SET @Quest := 24506;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);

-- Inside the Frozen Citadel (Alliance)
SET @Quest := 24510;
DELETE FROM `creature_queststarter` WHERE `id`=@Entry AND `quest`=@Quest;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (@Entry, @Quest);
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Pit of Saron
-- ----------------------------------------------------------
/*SET @Entry := 9000154;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 80, 80, 35, 3, 0, 0, 0, 0, 1);*/
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Halls of Reflection
-- ----------------------------------------------------------
/*SET @Entry := 9000155;
DELETE FROM `creature_template` WHERE `entry`=@Entry;
INSERT INTO `creature_template` (`entry`, `modelid1`, `name`, `subname`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `unit_class`) VALUES
(@Entry, 15248, 'The Commoner', 'Dungeon Quests', 80, 80, 35, 3, 0, 0, 0, 0, 1);*/
-- ----------------------------------------------------------
