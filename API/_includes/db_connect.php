<?php
$hostUrl = 'brycekam.db.9401574.hostedresource.com';
$userName = 'brycekam';
$dbpassword = 'Rendezvous123@';
// connect to database
$connectID = mysql_connect($hostUrl, $userName, $dbpassword)
  or die ("Sorry, can't connect to database");

//select the database to read from
mysql_select_db("brycekam", $connectID)
  or die ("Unable to select database");
  
?>