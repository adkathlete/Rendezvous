<?php
function addPhoneNumber($id, $phone_number) {

include "db_connect.php";

$myDataID = mysql_query("UPDATE users SET phone_number = '$phone_number' WHERE id = '$id'", $connectID)
  or die ("Unable to insert into database");
}
?>