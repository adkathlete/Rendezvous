<?php
function markUnreadChats ($from_id,$to_id) {

include "db_connect.php";

$mySecondDataID = mysql_query("UPDATE messages SET unread = 'No' WHERE from_id = '$to_id' AND to_id = '$from_id'", $connectID) or die ("Unable to update database");

}
?>