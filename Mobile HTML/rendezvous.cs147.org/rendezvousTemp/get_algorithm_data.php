  
<?php

require_once ("./_includes/add_new_match.php");

//Hey Jack: the line above includes the add_new_match file.
//So every time you want to add a match into the database all you have to do
// is call the function addNewMatch($from_id,$to_id);
// What i'm guessing you want to do is iterate through all the elements in your
// matched array and call the function each time to add it into the database

      $list;
      $matches;
      $occurences;
      PopulateList($list, $occurences);
      MatchUsers($list, $matches);
?>

<?php
function PopulateList(&$list, &$occurences) {
    include "./_includes/db_connect.php";
      $myDataID = mysql_query("SELECT * FROM lists WHERE can_Match = 1", $connectID) or die ("Unable to read from database");
      while ($row = mysql_fetch_array($myDataID)) {
            $list[$row['from_id']][$row['to_id']] = $list[$row['from_id']][$row['to_id']] + $row['rank'];
            $list[$row['to_id']][$row['from_id']] = $list[$row['to_id']][$row['from_id']] + $row['rank'];
            $occurences[$row['from_id']]++;
      }
      uasort($list, "compareElements");
      //foreach ($list as $user => $value) {
            //uasort($list[$user], "compareElements");
      //}
}
?>

<?php
function compareElements($one, $two){
      if ($one == $two) {
            return 0;
      }
      return ($one < $two) ? -1 : 1;
}
?>

<?php
function PrintList(&$list){
      print "<br>================";
      foreach ($list as $from => $to) {
            print "<br>";
            foreach ($to as $toID => $rank) {
                  print $from;
                  echo " --> " .$toID. " = " .$rank. " . . . . . . ";
            }
      }
      print"<br>=================<br><br>";
}
?>

<?php
function PrintMatches(&$matches){
      foreach ($matches as $match){
            print "<br>" .$match[0]. " matched to " .$match[1]. " with rank " .$match[2];
      }
      print "<br>";
}
?>


<?php
function MatchUsers(&$list, &$matches) {
      print "This is the list of matches before users are paired :";
      PrintList($list);
      while(sizeof($list) > 0) {
            print "<br>-=-=-=-=NextRound=-=-=-=-=-";
            PrintList($list);
            GetNextMatch($list, $matches);
            print "<br><br> MATCHES: ";
            PrintMatches($matches);
      }
      PrintList($list);
}
?>

<?php
function GetNextMatch(&$list, &$matches) {
      $fewestMatches = -1;
      $bestRank = -1;
      $fromID;
      $toID;
      $bool = false;
      foreach ($list as $user => $value) {
            if ($fewestMatches == -1) $fewestMatches = sizeof($value);
            if (sizeof($value) > $fewestMatches) break;
            foreach ($value as $id => $rank) {
                  if (array_key_exists($id, $list)) {
                        if ($bestRank == -1 || $rank < $bestRank) {
                              $bool = true;
                              $bestRank = $rank;
                              $fromID = $user;
                              $toID = $id;
                              print $fromID. " to " .$toID. " new best rank: " .$bestRank. "<br>";
                        }
                  }
            }
      }
      if ($bool == true) {
            addNewMatch($fromID,$toID);
            $matches[] = array($fromID, $toID, $bestRank);
            unset($list[$fromID]);
            unset($list[$toID]);     
      }
}
?>
      
<?php
function PrintOccurences(&$occurences){
    foreach ($occurences as $id => $number)
    {
      print "ID: " .$id. " occurences: " .$number. "<br>"; 
    }
    unset($id);
}
?>
