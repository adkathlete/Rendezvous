<?php
require_once ("./_includes/add_to_just_added.php");

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

if ($_GET['to_id']) {
$error = addToJustAdded($_SESSION['id'],$_GET['to_id']);
}

if ($error == 0) {
header ('Location: newList2.php');
} else if ($error == 1) {
header ('Location: newList2.php?error=1');
} else if ($error == 2) {
header ('Location: newList2.php?error=2');
}

?>