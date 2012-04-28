<?php

function readAllMessages ($from_id) {
include "db_connect.php";
$myDataID = mysql_query("SELECT * FROM messages WHERE (from_id = '$from_id' OR to_id = '$from_id') ORDER BY time", $connectID)
  or die ("Unable to select from database");
	return $myDataID;
}
?>

?>