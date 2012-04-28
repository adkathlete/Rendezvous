<?php

function readUserMatches ($id) {
include "db_connect.php";
$myDataID = mysql_query("SELECT * FROM matches WHERE from_id = '$id' ORDER BY time DESC", $connectID)
  or die ("Unable to select from database");
	return $myDataID;
} //end of function
?>