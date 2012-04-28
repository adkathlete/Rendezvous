<?php
$hostUrl = 'mysql.cs147.org';
$userName = 'akonig';
$dbpassword = 'wYW4PTW2';
// connect to database
$connectID = mysql_connect($hostUrl, $userName, $dbpassword)
  or die ("Sorry, can't connect to database");

//select the database to read from
mysql_select_db("akonig_mysql", $connectID)
  or die ("Unable to select database");
  
?>