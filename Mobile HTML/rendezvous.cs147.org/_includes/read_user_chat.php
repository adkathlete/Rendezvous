<?php

function readUserChat ($from_id,$to_id) {
include "db_connect.php";
$myDataID = mysql_query("SELECT * FROM messages WHERE (from_id = '$from_id' AND to_id = '$to_id') OR (from_id = '$to_id' AND to_id = '$from_id') ORDER BY time", $connectID)
  or die ("Unable to select from database");
	return $myDataID;
}
?>