<?php

function saveJustAdded($from_id) {

include "db_connect.php";
include "add_to_list.php";

$myDataID = mysql_query("SELECT * FROM justadded WHERE from_id = '$from_id' ORDER BY rank", $connectID)
  or die ("Unable to insert into database");

while ($row = mysql_fetch_array($myDataID)) {
      addToList($from_id,$row['to_id']);
}

$myDataID = mysql_query("DELETE FROM justadded WHERE from_id = '$from_id'", $connectID)
  or die ("Unable to insert into database");

}
?>