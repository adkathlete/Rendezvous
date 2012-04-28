<?php 
/* This is where you would inject your sql into the database 
but we're just going to format it and send it back 
*/ 
require_once ("./_includes/update_position.php");
session_start();
foreach ($_GET['userID'] as $position => $item) :
	updatePosition($item,$position+1); 
  $sql[] = "UPDATE `table` SET `position` = $position WHERE `id` = $item"; 
endforeach; 
print_r ($sql); 
?>