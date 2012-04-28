<?php
function removeFromList ($from_id,$to_id) {

include "db_connect.php";

$checkExists = mysql_query("SELECT * FROM lists WHERE from_id = '$from_id' AND to_id = '$to_id'",$connectID) or die ("Unable to select from database");

$check = @mysql_result($checkExists,0,0);

if ($check) {

$getIsMatched = mysql_query("SELECT * FROM lists WHERE from_id = '$from_id' AND to_id = '$to_id' AND can_Match = 1", $connectID) or die ("Unable to select from database");

$isMatched = @mysql_result($getIsMatched,0,0);

$getCurRank = mysql_query("SELECT rank FROM lists WHERE from_id = '$from_id' AND to_id = '$to_id'", $connectID) or die ("Unable to insert into database");

$curRank = @mysql_result($getCurRank,0,0);

$myDataID = mysql_query("DELETE FROM lists WHERE from_id = '$from_id' AND to_id = '$to_id'", $connectID)
  or die ("Unable to insert into database");

$mySecondDataID = mysql_query("UPDATE lists SET rank = (rank - 1) WHERE from_id = '$from_id' AND rank > '$curRank'", $connectID) or die ("Unable to update database");

if ($isMatched) {
$myThirdDataID = mysql_query("UPDATE lists SET can_Match = 0 WHERE from_id='$to_id' AND to_id = '$from_id'",$connectID) or die ("Unable to update database");
}

}

}
?>