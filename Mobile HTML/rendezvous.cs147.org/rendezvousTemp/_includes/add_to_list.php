<?php
function addToList ($from_id,$to_id) {

include "db_connect.php";

$checkExists = mysql_query("SELECT * FROM lists WHERE from_id = '$from_id' AND to_id = '$to_id'",$connectID) or die ("Unable to select from database");

$matchinglist = @mysql_result($checkExists,0,0);

$checkMax = mysql_query("SELECT COUNT(*) FROM lists WHERE from_id = '$from_id'",$connectID) or die ("Unable to select from database");

$thecount = @mysql_result($checkMax,0,0);

if ((!$matchinglist) && ($thecount < 5)) {

$getRank = mysql_query("SELECT MAX(rank) FROM lists WHERE from_id = '$from_id'", $connectID) or die ("Unable to select from database");

$rank = @mysql_result($getRank,0,0);

if (!$rank) {
$rank = 0;
}

$rank++;

$checkOther = mysql_query("SELECT * FROM lists WHERE from_id='$to_id' AND to_id='$from_id'",$connectID) or die ("Unable to select from database");

$otherExists = @mysql_result($checkOther,0,0);

if ($otherExists) {

$myDataID = mysql_query("INSERT into lists (from_id,to_id,rank,can_Match) VALUES ('$from_id','$to_id','$rank',1)", $connectID)
  or die ("Unable to insert into database");

$myDataID = mysql_query("UPDATE lists SET can_Match = 1 WHERE from_id='$to_id' AND to_id='$from_id'", $connectID)
  or die ("Unable to insert into database");

} else {

$myDataID = mysql_query("INSERT into lists (from_id,to_id,rank) VALUES ('$from_id','$to_id','$rank')", $connectID)
  or die ("Unable to insert into database");

}
}
}
?>