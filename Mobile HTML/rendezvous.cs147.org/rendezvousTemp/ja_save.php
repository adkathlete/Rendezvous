<?php
require_once ("./_includes/save_just_added.php");

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

saveJustAdded($_SESSION['id']);
header ('Location: my_Lists.php');
?>