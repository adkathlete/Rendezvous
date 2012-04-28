<?php

function readUnreadChat ($from_id) {
include "db_connect.php";
$myDataID = mysql_query("SELECT * FROM messages WHERE to_id = '$from_id' AND unread = 'Yes' ORDER BY time DESC", $connectID)
  or die ("Unable to select from database");
	return $myDataID;
}
?>