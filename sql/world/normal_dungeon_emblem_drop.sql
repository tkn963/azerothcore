-- Emblem of Heroism
SET @emblem := 40752;

-- Ahn'kahet: The Old Kingdom
-- Elder Nadox
SET @entry := 29309;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Prince Taldaram
SET @entry := 29308;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Jedoga Shadowseeker
SET @entry := 29310;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Herald Volazj
SET @entry := 29311;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);

-- Azjol-Nerub
-- Krik'thir the Gatewatcher
SET @entry := 28684;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Hadronox
SET @entry := 28921;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Anub'arak
SET @entry := 29120;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);

-- Caverns of Time: The Culling of Stratholme
-- Meathook
SET @entry := 26529;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Salramm the Fleshcrafter
SET @entry := 26530;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Chrono-Lord Epoch
SET @entry := 26532;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Mal'Ganis 
SET @entry := 35037;
DELETE FROM `reference_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);

-- Drak'Tharon Keep
-- Trollgore
SET @entry := 26630;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Novos the Summoner
SET @entry := 26631;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- King Dred
SET @entry := 27483;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- The Prophet Tharon'ja
SET @entry := 26632;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);

-- Gundrak
-- Slad'ran
SET @entry := 29304;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Drakkari Colossus
SET @entry := 35038;
DELETE FROM `reference_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Moorabi
SET @entry := 29305;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Gal'darah
SET @entry := 29306;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);

-- Halls of Lightning
-- General Bjarngrim
SET @entry := 28586;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Volkhan
SET @entry := 28587;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Ionar
SET @entry := 28546;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Loken
SET @entry := 28923;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);

-- Halls of Stone
-- Maiden of Grief
SET @entry := 27975;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Krystallus
SET @entry := 27977;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- The Tribunal of Ages
SET @entry := 27975;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Sjonnir the Ironshaper
SET @entry := 27978;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);

-- The Nexus
-- Grand Magus Telestra
SET @entry := 26731;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Anomalus
SET @entry := 26763;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Ormorok the Tree-Shaper
SET @entry := 26794;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Keristrasza
SET @entry := 26723;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);

-- The Oculus
-- Drakos the Interrogator
SET @entry := 27654;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Varos Cloudstrider
SET @entry := 27447;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Mage-Lord Urom
SET @entry := 27655;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Ley-Guardian Eregos
SET @entry := 27656;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);

-- Utgarde Keep
-- Prince Keleseth
SET @entry := 23953;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Skarvald the Constructor / Dalronn the Controller
SET @entry := 24200;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
SET @entry := 24201;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Ingvar the Plunderer
SET @entry := 23954;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);

-- Utgarde Pinnacle
-- Svala
SET @entry := 26668;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Gortok Palehoof
SET @entry := 26687;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Skadi the Ruthless
SET @entry := 26693;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- King Ymiron
SET @entry := 26861;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);

-- The Violet Hold
-- Erekem
SET @entry := 29315;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Zuramat the Obliterator
SET @entry := 29314;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Xevozz
SET @entry := 29266;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Ichoron
SET @entry := 29313;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Moragg
SET @entry := 29316;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Lavanthor
SET @entry := 29312;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 1, 1);
-- Cyanigosa
SET @entry := 31134;
DELETE FROM `creature_loot_template` WHERE `Entry`=@entry AND `Item`=@emblem;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Chance`, `MinCount`, `MaxCount`) VALUES (@entry, @emblem, 100, 2, 2);
