<?php
require_once ("./_includes/add_to_list.php");

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

$error = 0;

if ($_GET['to_id']) {
$error = addToList($_SESSION['id'],$_GET['to_id']);
}

if ($error == 0) {
header ('Location: my_Lists.php');
} else if ($error == 1) {
header ('Location: my_Lists.php?error=1');
} else if ($error == 2) {
header ('Location: my_Lists.php?error=2');
}
?>