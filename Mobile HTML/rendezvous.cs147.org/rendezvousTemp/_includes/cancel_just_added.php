<?php
function cancelJustAdded($from_id) {

include "db_connect.php";

$myDataID = mysql_query("DELETE FROM justadded WHERE from_id = '$from_id'", $connectID)
  or die ("Unable to insert into database");

}
?>