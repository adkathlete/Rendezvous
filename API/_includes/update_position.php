<?php
function updatePosition ($from_id,$to_id,$newposition) {

include "db_connect.php";

$myDataID = mysql_query("UPDATE lists SET rank = '$newposition' WHERE from_id = '$from_id' AND to_id = '$to_id'",$connectID) or die ("Unable to select from database");


}
?>