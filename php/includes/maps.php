<?php
$maps = array(
    array(
        'name' => 'Eastern Kingdoms',
        'id' => 0,
        'type' => maptype::world,
        'expansion' => expansion::none
    ),
    array(
        'name' => 'Kalimdor',
        'id' => 1,
        'type' => maptype::world,
        'expansion' => expansion::none
    ),
    array(
        'name' => 'Alterac Valley',
        'id' => 30,
        'type' => maptype::battleground,
        'expansion' => expansion::none
    ),
    array(
        'name' => 'Warsong Gulch',
        'id' => 489,
        'type' => maptype::battleground,
        'expansion' => expansion::none
    ),
    array(
        'name' => 'Arathi Basin',
        'id' => 529,
        'type' => maptype::battleground,
        'expansion' => expansion::none
    ),
    array(
        'name' => 'Outland',
        'id' => 530,
        'type' => maptype::world,
        'expansion' => expansion::theburningcrusade
    ),
    array(
        'name' => 'Eye of the Storm',
        'id' => 566,
        'type' => maptype::battleground,
        'expansion' => expansion::theburningcrusade
    ),
    array(
        'name' => 'Northrend',
        'id' => 571,
        'type' => maptype::world,
        'expansion' => expansion::wrathofthelichking
    ),
    array(
        'name' => 'Ruins of Lordaeron',
        'id' => 572,
        'type' => maptype::arena,
        'expansion' => expansion::theburningcrusade
    ),
    array(
        'name' => 'Strand of the Ancients',
        'id' => 607,
        'type' => maptype::battleground,
        'expansion' => expansion::wrathofthelichking
    ),
    array(
        'name' => 'Dalaran Arena',
        'id' => 617,
        'type' => maptype::arena,
        'expansion' => expansion::wrathofthelichking
    ),
    array(
        'name' => 'The Ring of Valor',
        'id' => 618,
        'type' => maptype::arena,
        'expansion' => expansion::wrathofthelichking
    ),
    array(
        'name' => 'Isle of Conquest',
        'id' => 628,
        'type' => maptype::battleground,
        'expansion' => expansion::wrathofthelichking
    ),
    array(
        'name' => 'Deepholm',
        'id' => 646,
        'type' => maptype::world,
        'expansion' => expansion::cataclysm
    ),
    array(
        'name' => 'Twin Peaks',
        'id' => 726,
        'type' => maptype::battleground,
        'expansion' => expansion::cataclysm
    ),
    array(
        'name' => 'Maelstrom Zone',
        'id' => 730,
        'type' => maptype::world,
        'expansion' => expansion::cataclysm
    ),
    array(
        'name' => 'Tol Barad',
        'id' => 732,
        'type' => maptype::world,
        'expansion' => expansion::cataclysm
    ),
    array(
        'name' => 'The Battle for Gilneas',
        'id' => 761,
        'type' => maptype::battleground,
        'expansion' => expansion::cataclysm
    ),
    array(
        'name' => 'Nagrand Arena',
        'id' => 1505,
        'type' => maptype::arena,
        'expansion' => expansion::theburningcrusade
    ),
    array(
        'name' => 'Blade\'s Edge Arena',
        'id' => 1672,
        'type' => maptype::arena,
        'expansion' => expansion::theburningcrusade
    )
);

$map_column = array_column($maps, 'name');
array_multisort($map_column, SORT_ASC, $maps);

$map_name = array_column($maps, 'name');
$map_type = array_column($maps, 'type');
$map_id = array_column($maps, 'id');
$map_expansion = array_column($maps, 'expansion');
?>
