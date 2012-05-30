<?php

require_once ("./_includes/read_user_matches.php");

if ($_GET['id']) {

$output = "";
$record = readUserMatches($_GET['id']);
$row = mysql_fetch_array($record);
$output .= $row['to_id'];
print $output;

}

?>