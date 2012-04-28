<?php
require_once ("./_includes/cancel_just_added.php");

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

cancelJustAdded($_SESSION['id']);
header ('Location: my_Lists.php');
?>