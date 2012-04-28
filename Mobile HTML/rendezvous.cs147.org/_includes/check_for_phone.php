<?php

function checkForPhone ($id) {
include "db_connect.php";

$myDataID = mysql_query("SELECT phone_number FROM users WHERE id = '$id'", $connectID)
  or die ("Unable to select from database");

$matching_id = @mysql_result($myDataID,0,0);
return $matching_id;

} //end of function
?>