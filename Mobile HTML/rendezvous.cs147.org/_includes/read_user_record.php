<?php

function readUserRecord ($id) {
include "db_connect.php";
$myDataID = mysql_query("SELECT * FROM users WHERE id = '$id'", $connectID)
  or die ("Unable to select from database");
	return $myDataID;
} //end of function
?>