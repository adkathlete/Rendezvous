<?php

function readJustAddedList ($id) {
include "db_connect.php";
$myDataID = mysql_query("SELECT * FROM justadded WHERE from_id = '$id' ORDER BY rank", $connectID)
  or die ("Unable to select from database");
	return $myDataID;
} //end of function
?>