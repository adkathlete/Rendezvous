<?php
require_once("./_includes/remove_message.php");
session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}


if ($_GET['from_id'] && $_GET['to_id'] && $_GET['message']) {
removeMessage($_GET['from_id'],$_GET['to_id'],$_GET['message']);
}

if ($_GET['forward'] == 1) {
header ("Location: demoUser.php?to_id=".$_GET['demo_id']);
} else {
header ('Location: matches.php');
}
?>