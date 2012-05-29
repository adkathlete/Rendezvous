<?php

require_once ("./_includes/check_user_exists.php");
require_once ("./_includes/add_new_user.php");
require_once ("./_includes/read_user_record.php");

if ($_GET['id'] && $_GET['first_name'] && $_GET['last_name'] &&
    $_GET['gender']) {
  
  if (!checkUserExists($_GET['id'])) {
      addNewUser($_GET['id'],$_GET['first_name'],$_GET['last_name'],"",$_GET['gender'],"");
    }

$output = "";
$record = readUserRecord($_GET['id']);
$row = mysql_fetch_array($record);
$output .= $row['first_name'];
$output .= ",";
$output .= $row['last_name'];
$output .= ",";
$output .= $row['phone_number'];
$output .= ",";
$output .= $row['id'];
$output .= ",";
$output .= $row['gender'];
$output .= ",";
$output .= $row['rendezvous'];
print $output;
}

?>