<?php
function removeMessage($from_id,$to_id,$message) {

include "db_connect.php";

$checkExists = mysql_query("SELECT * FROM messages WHERE from_id = '$from_id' AND to_id = '$to_id' AND message = '$message'",$connectID) or die ("Unable to select from database");

$check = @mysql_result($checkExists,0,0);

if ($check) {

$myDataID = mysql_query("DELETE FROM messages WHERE from_id = '$from_id' AND to_id = '$to_id' AND message='$message'", $connectID)
  or die ("Unable to insert into database");

}

}
?>