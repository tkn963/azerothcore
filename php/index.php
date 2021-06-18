<?php
include('includes/statics.php');
include('includes/config.php');
include('includes/maps.php');
include('includes/zones.php');

if ($enable_debug)
{
    error_reporting(-1);
    ini_set('display_errors', 'On');
}

for ($id = 0; $id < count($maps); $id++)
{
    if ($map_expansion[$id] <= $expansion)
    {
        echo $map_name[$id].'<br>';
    }
}
?>
