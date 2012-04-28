<?php
function updatePosition ($to_id,$newposition) {

include "db_connect.php";

$myDataID = mysql_query("UPDATE lists SET rank = '$newposition' WHERE to_id = '$to_id'",$connectID) or die ("Unable to select from database");


}
?>