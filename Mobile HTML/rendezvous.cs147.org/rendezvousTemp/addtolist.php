<?php
require_once ("./_includes/add_to_list.php");

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

if ($_GET['to_id']) {
addToList($_SESSION['id'],$_GET['to_id']);
}

header ('Location: my_Lists.php');
?>