<?php

function getMyName($id) {
include "db_connect.php";
$myDataID = mysql_query("SELECT first_name FROM users WHERE id = '$id'", $connectID)
  or die ("Unable to select from database");
	return $myDataID;
} //end of function
?>