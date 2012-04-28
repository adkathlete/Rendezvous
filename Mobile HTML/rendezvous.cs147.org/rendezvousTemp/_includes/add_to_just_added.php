<?php
function addToJustAdded ($from_id,$to_id) {

include "db_connect.php";

$checkExists = mysql_query("SELECT * FROM lists WHERE from_id = '$from_id' AND to_id = '$to_id'",$connectID) or die ("Unable to select from database");

$checkExists2 = mysql_query("SELECT * FROM justadded WHERE from_id = '$from_id' AND to_id = '$to_id'",$connectID) or die ("Unable to select from database");

$matchinglist = @mysql_result($checkExists,0,0);
$matchinglist2 = @mysql_result($checkExists2,0,0);

$checkMax1 = mysql_query("SELECT COUNT(*) FROM lists WHERE from_id = '$from_id'",$connectID) or die ("Unable to select from database");

$checkMax2 = mysql_query("SELECT COUNT(*) FROM justadded WHERE from_id = '$from_id'",$connectID) or die ("Unable to select from database");

$thecount1 = @mysql_result($checkMax1,0,0);
$thecount2 = @mysql_result($checkMax2,0,0);
$thecount = $thecount1 + $thecount2;

if ((!$matchinglist) && (!$matchinglist2) && ($thecount < 5)) {

$getRank = mysql_query("SELECT MAX(rank) FROM justadded WHERE from_id = '$from_id'", $connectID) or die ("Unable to select from database");

$rank = @mysql_result($getRank,0,0);

if (!$rank) {
$rank = 0;
}

$rank++;

$myDataID = mysql_query("INSERT into justadded (from_id,to_id,rank) VALUES ('$from_id','$to_id','$rank')", $connectID)
  or die ("Unable to insert into database");
}
}
?>