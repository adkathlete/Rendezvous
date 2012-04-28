<?php

function returnUserNames ($id) {
include "db_connect.php";
$myDataID = mysql_query("SELECT first_name, last_name FROM users WHERE id = '$id'", $connectID)
  or die ("Unable to select from database");
	return $myDataID;
} //end of function
?>