/*
World of Warcraft - Phase 3: Patch 1.3
*/

-- Enable Dire Maul
DELETE FROM `disables` WHERE `sourceType`=2 AND `entry`=429;

-- Add Lord Kazzak
UPDATE `creature_template` SET `minlevel`=63, `maxlevel`=63, `unit_class`=2, `MovementType`=2, `HealthModifier`=110, `ManaModifier`=43 WHERE `entry`=12397;
DELETE FROM `creature` WHERE `guid`=156950;
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`, `curmana`, `MovementType`) VALUES (156950, 12397, 0, -12275.6, -2524.26, 3.79202, 1.69492, 518400, 486610, 113480, 2);
DELETE FROM `creature_addon` WHERE `guid`=156950;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (156950, 1239700);
DELETE FROM `waypoint_data` WHERE `id`=1239700;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES (1239700, 1, -12241.3, -2432.1, 2.93936);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES (1239700, 2, -12271.6, -2453.36, 3.84158);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES (1239700, 3, -12279.2, -2488.66, 4.38164);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES (1239700, 4, -12275.1, -2520.88, 3.67985);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES (1239700, 5, -12224.9, -2522.83, 1.56836);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES (1239700, 6, -12191.6, -2502.13, -0.148134);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES (1239700, 7, -12114.8, -2510.99, 3.11959);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES (1239700, 8, -12138.4, -2494.16, 3.89333);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES (1239700, 9, -12166, -2478.6, 0.810272);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES (1239700, 10, -12171.4, -2452.79, -0.15142);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES (1239700, 11, -12208, -2436.73, 0.09382);
