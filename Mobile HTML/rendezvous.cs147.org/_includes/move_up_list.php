<?php
function moveUpList ($from_id,$to_id) {

include "db_connect.php";

$checkExists = mysql_query("SELECT * FROM lists WHERE from_id = '$from_id' AND to_id = '$to_id'",$connectID) or die ("Unable to select from database");

$check = @mysql_result($checkExists,0,0);

if ($check) {

$getCurRank = mysql_query("SELECT rank FROM lists WHERE from_id = '$from_id' AND to_id = '$to_id'", $connectID) or die ("Unable to insert into database");

$curRank = @mysql_result($getCurRank,0,0);

if ($curRank != 1) {

$aboveRank = $curRank - 1;

$mySecondDataID = mysql_query("UPDATE lists SET rank = '$curRank' WHERE from_id = '$from_id' AND rank = '$aboveRank'", $connectID) or die ("Unable to update database");

$myFirstDataID = mysql_query("UPDATE lists SET rank = (rank - 1) WHERE from_id = '$from_id' AND to_id = '$to_id'", $connectID) or die ("Unable to update database");

}
}

}
?>