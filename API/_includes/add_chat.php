<?php
function addChat($from_id,$to_id,$chat) {

include "db_connect.php";

$myDataID = mysql_query("INSERT into messages (from_id,to_id,message,unread) VALUES ('$from_id','$to_id','$chat','Yes')", $connectID)
  or die ("Unable to insert into database");
}
?>