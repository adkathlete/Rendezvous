<?php

function countMatches ($id) {
include "db_connect.php";
$myDataID = mysql_query("SELECT COUNT(*) FROM matches WHERE from_id = '$id'", $connectID)
  or die ("Unable to select from database");
	return $myDataID;
} //end of function
?>