DROP PROCEDURE IF EXISTS `questLoot`;
DELIMITER //
CREATE PROCEDURE questLoot ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @FLAG
FROM item_template
WHERE Flags = 0 AND entry = 21808;
IF @FLAG = 0 THEN LEAVE proc; END IF;
START TRANSACTION;

UPDATE `item_template` SET `Flags`=Flags+2048 WHERE `entry` IN (SELECT `RequiredItemId1` FROM `quest_template` WHERE `RequiredItemId1` IN (SELECT `item` FROM `creature_loot_template`)) AND `class`=12;
UPDATE `item_template` SET `Flags`=Flags+2048 WHERE `entry` IN (SELECT `RequiredItemId2` FROM `quest_template` WHERE `RequiredItemId2` IN (SELECT `item` FROM `creature_loot_template`)) AND `class`=12;
UPDATE `item_template` SET `Flags`=Flags+2048 WHERE `entry` IN (SELECT `RequiredItemId3` FROM `quest_template` WHERE `RequiredItemId3` IN (SELECT `item` FROM `creature_loot_template`)) AND `class`=12;
UPDATE `item_template` SET `Flags`=Flags+2048 WHERE `entry` IN (SELECT `RequiredItemId4` FROM `quest_template` WHERE `RequiredItemId4` IN (SELECT `item` FROM `creature_loot_template`)) AND `class`=12;
UPDATE `item_template` SET `Flags`=Flags+2048 WHERE `entry` IN (SELECT `RequiredItemId5` FROM `quest_template` WHERE `RequiredItemId5` IN (SELECT `item` FROM `creature_loot_template`)) AND `class`=12;
UPDATE `item_template` SET `Flags`=Flags+2048 WHERE `entry` IN (SELECT `RequiredItemId6` FROM `quest_template` WHERE `RequiredItemId6` IN (SELECT `item` FROM `creature_loot_template`)) AND `class`=12;
UPDATE `item_template` SET `Flags`=Flags+2048 WHERE `entry` IN (33778, 33779, 33780); -- Book of Runes Chapter 1, 2, 3

COMMIT;
END //
DELIMITER ;
CALL questLoot();
DROP PROCEDURE IF EXISTS `questLoot`;
