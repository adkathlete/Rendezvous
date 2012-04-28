<?php
function addNewUser ($id,$first_name,$last_name,$phone_number,$gender,$dob) {

include "db_connect.php";

$myDataID = mysql_query("INSERT into users (id,first_name,last_name,phone_number,gender,date_of_birth) VALUES ('$id','$first_name','$last_name','$phone_number','$gender','$dob')", $connectID)
  or die ("Unable to insert into database");
}
?>