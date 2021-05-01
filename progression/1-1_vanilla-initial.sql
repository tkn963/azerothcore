/*
World of Warcraft - Phase 1: Initial Release
*/

-- Disable Dark Portal teleport
DELETE FROM `areatrigger_teleport` WHERE `ID`=4354;
INSERT INTO `areatrigger_teleport` VALUES (4354, 'Dark Portal To Outland', 0, -11893.124023, -3207.051025, -14.711871, 0.088629);

-- Remove northrend transports
DELETE FROM `transports` WHERE `guid` IN (10, 11, 12, 17);

-- Remove northrend transport npcs
DELETE FROM `creature` WHERE `guid` IN (200017, 203491, 120786);

-- Disable battlegrounds
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=1;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 1, 'Alterac Valley');
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=2;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 2, 'Warsong Gulch');
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=3;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 3, 'Arathi Basin');
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=7;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 7, 'Eye of the Storm');
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=9;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 9, 'Strand of the Ancients');
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=30;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 30, 'Isle of Conquest');
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=32;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 32, 'Random Battleground');

-- Disable arenas
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=4;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 4, 'Nagrand Arena / Ring of Trials');
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=5;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 5, 'Blade\'s Edge Arena');
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=6;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 6, 'Arenas');
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=8;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 8, 'Ruins of Lordaeron');
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=10;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 10, 'Dalaran Sewers');
DELETE FROM `disables` WHERE `sourceType`=3 AND `entry`=11;
INSERT INTO `disables` (`sourceType`, `entry`, `comment`) VALUES (3, 11, 'The Ring of Valor');

-- Disable dungeons
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=229;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 229, 1, 'Blackrock Spire');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=269;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 269, 5, 'Caverns Of Time: Black Morass');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=349;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 349, 1, 'Maraudon');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=429;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 429, 1, 'Dire Maul');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=534;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 534, 1, 'Battle of Mount Hyjal');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=540;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 540, 5, 'The Shattered Halls');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=542;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 542, 5, 'The Blood Furnace');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=543;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 543, 5, 'Hellfire Ramparts');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=545;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 545, 5, 'The Steamvault');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=546;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 546, 5, 'The Underbog');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=547;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 547, 5, 'The Slave Pens');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=552;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 552, 5, 'The Arcatraz');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=553;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 553, 5, 'The Botanica');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=554;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 554, 5, 'The Mechanar');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=555;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 555, 5, 'Shadow Labyrinth');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=556;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 556, 5, 'Sethekk Halls');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=557;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 557, 5, 'Mana Tombs');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=558;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 558, 5, 'Auchenai Crypts');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=560;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 560, 5, 'Caverns Of Time: Old Hillsbrad Foothills');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=574;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 574, 5, 'Utgarde Keep');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=575;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 575, 5, 'Utgarde Pinnacle');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=576;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 576, 5, 'The Nexus');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=578;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 578, 5, 'The Oculus');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=585;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 585, 5, 'Magister\'s Terrace');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=595;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 595, 5, 'Culling of Stratholme');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=599;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 599, 5, 'Halls of Stone');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=600;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 600, 5, 'Drak\'Tharon Keep');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=601;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 601, 5, 'Azjol-Nerub');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=602;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 602, 5, 'Halls of Lightning');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=604;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 604, 5, 'Gundrak');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=608;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 608, 5, 'Violet Hold');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=619;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 619, 5, 'Ahn\'Kahet');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=632;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 632, 5, 'Forge of Souls');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=650;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 650, 5, 'Trial of the Champion');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=658;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 658, 5, 'Pit of Saron');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=668;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 668, 5, 'Halls of Reflection');

-- Disable raids
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=309;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 309, 1, 'Zul\'Gurub');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=469;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 469, 1, 'Blackwing Lair');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=509;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 509, 1, 'Ruins of Ahn\'Qiraj');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=531;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 531, 1, 'Temple of Ahn\'Qiraj');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=532;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 532, 1, 'Karazhan');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=533;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 533, 15, 'Naxxramas');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=544;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 544, 2, 'Magtheridon\'s Lair');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=548;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 548, 2, 'Serpentshrine Cavern');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=550;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 550, 2, 'Tempest Keep');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=565;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 565, 2, 'Gruul\'s Lair');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=568;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 568, 1, 'Zul\'Aman');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=564;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 564, 2, 'Black Temple');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=580;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 580, 2, 'Sunwell Plateau');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=603;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 603, 15, 'Ulduar');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=616;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 616, 15, 'Eye of Eternity');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=615;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 615, 15, 'The Obsidian Sanctum');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=624;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 624, 15, 'Vault of Archavon');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=631;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 631, 15, 'Icecrown Citadel');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=649;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 649, 15, 'Trial of the Crusader');
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=724;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `comment`) VALUES (2, 724, 15, 'The Ruby Sanctum');

-- Remove inscription
-- Trainers
DELETE FROM `creature` WHERE `guid` IN (10497, 34033, 34034, 40603, 47642, 47646, 98803, 99197, 102850, 106632, 120826, 125428, 125643, 125644, 125645, 125646, 125647, 125648);
-- Supplies etc
DELETE FROM `creature` WHERE `guid` IN (34039, 34040, 34041, 34042, 34043, 34044, 34045, 73498, 73499, 76736, 84645, 97187, 100700, 120602, 135120);
-- Lexicon of Power
DELETE FROM `gameobject` WHERE `guid` IN (60245, 60246, 60247, 60248, 61967, 63145, 63170, 63171, 63172, 63173, 63174, 63175, 63176, 100257);
-- Spells
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=45357;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 45357, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=45358;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 45358, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=45359;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 45359, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=45360;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 45360, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=45361;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 45361, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=45363;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 45363, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=51005;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 51005, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=52175;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 52175, 1);
-- Gossip menu options
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (2351, 3572) AND `OptionID`=6;
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (751, 3330, 7788) AND `OptionID`=7;
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (421, 1942, 2168, 3284, 3355, 3532, 3558, 7667, 8138, 8205, 10078, 10767) AND `OptionID`=8;

-- Remove jewelcrafting
-- Trainers
DELETE FROM `creature` WHERE `guid` IN (40602, 55420, 67024, 67049, 68364, 69944, 70730, 75906, 82941, 88256, 88267, 98589, 103040, 106833, 125431);
-- Supplies etc
DELETE FROM `creature` WHERE `guid` IN (44253, 57619, 57619, 63008, 63008, 68366, 68366, 69943, 69943, 94386, 94386, 97152, 97152, 100492, 100492, 125692, 125692, 133918, 133918, 200795);
-- Spells
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=31252;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 31252, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=25229;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 25229, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=25230;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 25230, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=28894;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 28894, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=28895;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 28895, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=28897;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 28897, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=51311;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 51311, 1);
DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=55534;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`) VALUES (0, 55534, 1);
-- Gossip menu options
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (8326, 8403, 8424) AND `OptionID`=5;
DELETE FROM `gossip_menu_option` WHERE `MenuID`=7788 AND `OptionID`=8;
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (7667, 8138, 8205, 10078) AND `OptionID`=9;

-- Disable dual talent specialization
-- Gossip menu options
DELETE FROM `gossip_menu_option` WHERE `MenuID`=10371 AND `OptionID`=0;
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (63, 64, 85, 141, 381, 410, 411, 436, 523, 655, 656, 1403, 1503, 1522, 2304, 2381, 2383, 2384, 3642, 3643, 3644, 3645, 3921, 3924, 3925, 3926, 3984, 4007, 4008, 4009, 4010, 4011, 4012, 4017, 4023, 4091, 4092, 4101, 4103, 4104, 4463, 4464, 4466, 4467, 4468, 4469, 4470, 4471, 4472, 4473, 4474, 4475, 4481, 4482, 4484, 4485, 4486, 4502, 4503, 4504, 4505, 4506, 4507, 4508, 4509, 4511, 4512, 4513, 4515, 4516, 4517, 4518, 4519, 4520, 4521, 4522, 4523, 4524, 4525, 4526, 4527, 4528, 4529, 4530, 4531, 4532, 4533, 4534, 4535, 4537, 4538, 4539, 4540, 4541, 4542, 4543, 4544, 4545, 4546, 4547, 4548, 4549, 4550, 4551, 4552, 4556, 4557, 4558, 4559, 4561, 4562, 4566, 4567, 4568, 4569, 4570, 4571, 4572, 4573, 4574, 4575, 4576, 4577, 4578, 4579, 4581, 4603, 4604, 4605, 4606, 4607, 4609, 4610, 4621, 4641, 4642, 4643, 4645, 4646, 4647, 4648, 4649, 4650, 4651, 4652, 4653, 4654, 4655, 4656, 4657, 4658, 4659, 4660, 4661, 4662, 4665, 4666, 4667, 4674, 4675, 4676, 4677, 4678, 4679, 4680, 4681, 4682, 4683, 4684, 4685, 4686, 4687, 4688, 4690, 4691, 4692, 4693, 4694, 4695, 4696, 4697, 4801, 5061, 5123, 6628, 6647, 6648, 6649, 6650, 6652, 7260, 7262, 7263, 7264, 7265, 7349, 7357, 7366, 7368, 7437, 7438, 7467, 7522, 7566, 7567, 8110, 8111, 9580, 9691, 9692, 9693, 9990, 21221) AND `OptionID`=2;
DELETE FROM `gossip_menu_option` WHERE `MenuID`=7377 AND `OptionID`=3;
DELETE FROM `gossip_menu_option` WHERE `MenuID`=0 AND `OptionID`=16;

-- Remove world bosses
-- Azuregos
DELETE FROM `creature` WHERE `id`=6109;
-- Ysondre
DELETE FROM `creature` WHERE `id`=14887;
-- Lethon
DELETE FROM `creature` WHERE `id`=14888;
-- Emeriss
DELETE FROM `creature` WHERE `id`=14889;
-- Taerar
DELETE FROM `creature` WHERE `id`=14890;
DELETE FROM `creature_addon` WHERE `guid`=4256;
DELETE FROM `waypoint_data` WHERE `id`=42560;

-- Remove Teremus the Devourer
DELETE FROM `creature` WHERE `id`=7846;
DELETE FROM `creature_addon` WHERE `guid`=134380;
DELETE FROM `waypoint_data` WHERE `id`=1343800;

-- Level and health of creatures
-- Stormwind City Guard
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=68;
UPDATE `creature` SET `curhealth`=5228 WHERE `id`=68;
-- Dungar Longdrink
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=352;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=352;
-- General Marcus Jonathan
UPDATE `creature_template` SET `minlevel`=62, `maxlevel`=62 WHERE `entry`=466;
UPDATE `creature` SET `curhealth`=32370 WHERE `id`=466;
-- Thor
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=523;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=523;
-- Coldridge Mountaineer
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=853;
UPDATE `creature` SET `curhealth`=5228 WHERE `id`=853;
-- Stonard Grunt
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=866;
UPDATE `creature` SET `curhealth`=3398 WHERE `id`=866;
-- Ariena Stormfeather
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=931;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=931;
-- Grom'gol Grunt
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=1064;
UPDATE `creature` SET `curhealth`=5228 WHERE `id`=1064;
-- Thysta
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=1387;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=1387;
-- Shellei Brondir
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=1571;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=1571;
-- Thorgrum Borrelson
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=1572;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=1572;
-- Gryth Thurden
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=1573;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=1573;
-- Northshire Guard
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=1642;
UPDATE `creature` SET `curhealth`=5228 WHERE `id`=1642;
-- Deathguard Randolph
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=1736;
UPDATE `creature` SET `curhealth`=5228 WHERE `id`=1736;
-- Deathguard Oliver
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=1737;
UPDATE `creature` SET `curhealth`=5228 WHERE `id`=1737;
-- Deathguard Phillip
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=1739;
UPDATE `creature` SET `curhealth`=5228 WHERE `id`=1739;
-- Deathguard Bartrand
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=1741;
UPDATE `creature` SET `curhealth`=5228 WHERE `id`=1741;
-- Stormwind Royal Guard
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60 WHERE `entry`=1756;
UPDATE `creature` SET `curhealth`=6104 WHERE `id`=1756;
-- Stormwind City Patroller
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=1976;
UPDATE `creature` SET `curhealth`=5228 WHERE `id`=1976;
-- Karos Razok
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2226;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2226;
-- Borgus Stoutarm
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2299;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2299;
-- Zarise
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2389;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2389;
-- Felicia Maline
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2409;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2409;
-- Darla Harris
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2432;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2432;
-- King Magni Bronzebeard
UPDATE `creature_template` SET `minlevel`=63, `maxlevel`=63 WHERE `entry`=2784;
UPDATE `creature` SET `curhealth`=999300 WHERE `id`=2784;
-- Cedrik Prose
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2835;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2835;
-- Urda
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2851;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2851;
-- Gringer
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2858;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2858;
-- Gyll
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2859;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2859;
-- Gorrik
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2861;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2861;
-- Lanie Reed
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2941;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2941;
-- Tal
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=2995;
UPDATE `creature` SET `curhealth`=7842 WHERE `id`=2995;
-- Cairne Bloodhoof
UPDATE `creature_template` SET `minlevel`=63, `maxlevel`=63 WHERE `entry`=3057;
UPDATE `creature` SET `curhealth`=999300 WHERE `id`=3057;
-- Honor Guard
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60 WHERE `entry`=3083;
UPDATE `creature` SET `curhealth`=6104 WHERE `id`=3083;
-- Bluffwatcher
UPDATE `creature_template` SET `minlevel`=55, `maxlevel`=55 WHERE `entry`=3084;
UPDATE `creature` SET `curhealth`=5228 WHERE `id`=3084;
