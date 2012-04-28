<?php
require_once("./_includes/move_down_list.php");
session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

if ($_GET['to_id']) {
moveDownList($_SESSION['id'],$_GET['to_id']);
}

header ('Location: my_Lists_edit.php');
?>