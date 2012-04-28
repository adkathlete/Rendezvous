<?php
function addNewMatch ($from_id,$to_id) {

include "db_connect.php";

$myDataID = mysql_query("INSERT into matches (from_id,to_id) VALUES ('$from_id','$to_id')", $connectID)
  or die ("Unable to insert into database");
}
?>