<?php
// type: 0 (world)
// type: 1 (dungeon)
// type: 2 (raid)
// type: 3 (battleground)
// type: 4 (arena)
$maps = array(
    array(
        'name' => 'Eastern Kingdoms',
        'id' => 0,
        'type' => 0,
        'expansion' => 0
    ),
    array(
        'name' => 'Kalimdor',
        'id' => 1,
        'type' => 0,
        'expansion' => 0
    ),
    array(
        'name' => 'Alterac Valley',
        'id' => 30,
        'type' => 3,
        'expansion' => 0
    ),
    array(
        'name' => 'Warsong Gulch',
        'id' => 489,
        'type' => 3,
        'expansion' => 0
    ),
    array(
        'name' => 'Arathi Basin',
        'id' => 529,
        'type' => 3,
        'expansion' => 0
    ),
    array(
        'name' => 'Outland',
        'id' => 530,
        'type' => 0,
        'expansion' => 1
    ),
    array(
        'name' => 'Eye of the Storm',
        'id' => 566,
        'type' => 3,
        'expansion' => 1
    ),
    array(
        'name' => 'Northrend',
        'id' => 571,
        'type' => 0,
        'expansion' => 2
    ),
    array(
        'name' => 'Ruins of Lordaeron',
        'id' => 572,
        'type' => 4,
        'expansion' => 1
    ),
    array(
        'name' => 'Strand of the Ancients',
        'id' => 607,
        'type' => 3,
        'expansion' => 2
    ),
    array(
        'name' => 'Dalaran Arena',
        'id' => 617,
        'type' => 4,
        'expansion' => 2
    ),
    array(
        'name' => 'The Ring of Valor',
        'id' => 618,
        'type' => 4,
        'expansion' => 2
    ),
    array(
        'name' => 'Isle of Conquest',
        'id' => 628,
        'type' => 3,
        'expansion' => 2
    ),
    array(
        'name' => 'Deepholm',
        'id' => 646,
        'type' => 0,
        'expansion' => 3
    ),
    array(
        'name' => 'Twin Peaks',
        'id' => 726,
        'type' => 3,
        'expansion' => 3
    ),
    array(
        'name' => 'Maelstrom Zone',
        'id' => 730,
        'type' => 0,
        'expansion' => 3
    ),
    array(
        'name' => 'Tol Barad',
        'id' => 732,
        'type' => 0,
        'expansion' => 3
    ),
    array(
        'name' => 'The Battle for Gilneas',
        'id' => 761,
        'type' => 3,
        'expansion' => 3
    ),
    array(
        'name' => 'Nagrand Arena',
        'id' => 1505,
        'type' => 4,
        'expansion' => 1
    ),
    array(
        'name' => 'Blade\'s Edge Arena',
        'id' => 1672,
        'type' => 4,
        'expansion' => 1
    )
);

$map_column = array_column($maps, 'name');
array_multisort($map_column, SORT_ASC, $maps);

$map_name = array_column($maps, 'name');
$map_type = array_column($maps, 'type');
$map_id = array_column($maps, 'id');
$map_expansion = array_column($maps, 'expansion');
?>
