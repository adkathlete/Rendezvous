<?php
function addRendezvous($id,$rendezvous) {

include "db_connect.php";

$myDataID = mysql_query("UPDATE users SET rendezvous = '$rendezvous' WHERE id = '$id'", $connectID)
  or die ("Unable to insert into database");
}
?>