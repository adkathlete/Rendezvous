<?php
require_once("./_includes/remove_from_list.php");
session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}


if ($_GET['to_id']) {
removeFromList($_SESSION['id'],$_GET['to_id']);
}

header ('Location: my_Lists.php');
?>