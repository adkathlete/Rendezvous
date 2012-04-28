<?php
require_once ("./_includes/read_just_added_list.php");

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

$justAddedList = readJustAddedList($_SESSION['id']);

?>
<!DOCTYPE html> 
<html> 
  <head> 
    <title>Add New Friends</title> 
    
    <meta name="viewport" content="width=device-width, initial-scale=1"> 

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.js"></script>
</head> 
<body>
	<!-- Start of the New List page-->

	<div data-role="page" id="newList">

		<div data-role="header" data-position="fixed">
			<h1>Add Friends To Your List</h1>
			<a href="ja_cancel.php" data-role="button" data-direction="reverse" data-icon="back">Cancel</a>
<a href="ja_save.php" data-role="button" data-icon="check" data-iconpos="right">Save</a>

		</div><!-- /header -->

		<div data-role="content">
<ol data-role="listview" data-theme="g" data-inset="true">

<?php
while ($row = mysql_fetch_array($justAddedList)) {

      $urlstring = "https://graph.facebook.com/".$row['to_id'];
      $json = file_get_contents($urlstring);
      $decoded = json_decode($json);
	print "<li id=\"target\"><a class=\"mylist\" id=\"".$row['to_id']."\" href=\"#\">".$decoded->{'name'}."<img src=\"http://graph.facebook.com/".$decoded->{'id'}."/picture\" alt=\"No Image\"/> </a></li>";


}
?>
</ol>
		<h3> Search For New Users To Add to Your List!</h3>
		<form action="newList.php" method="post">	

			<div data-role="fieldcontain">
				<label for="search"></label>
				<input type="search" name="search" id="search" value="" />
				     <input type="submit" value="Search" name="submitted"/>
			</div>


		</form>

		<?php

			if(@$_POST['submitted']){
				$search=str_replace(' ','',@$_POST['search']);
				$usersJson=file_get_contents("https://graph.facebook.com/search?q=".$search."&type=user&".$_SESSION['accesstoken']."&limit=50");
				$decodedUsers = json_decode($usersJson);

				$friendsJson=file_get_contents("https://graph.facebook.com/me/friends?".$_SESSION['accesstoken']);
				$decodedFriends = json_decode($friendsJson);

				$filteredFriends=array();
				foreach($decodedFriends->{'data'} as $item){
					$pos=stripos($item->{'name'},$search);
					if($pos!==false){
						array_push($filteredFriends,$item);
						}
					}
				$allFriends=$filteredFriends+$decodedUsers->{'data'};
				print "<h3>Click on a user to add him or her to your list!</h3>";
				print "<ul data-role=\"listview\" data-theme=\"g\"  data-dividertheme=\"b\" data-inset=\"true\">";



				foreach($allFriends as $item){
					print "<li> <a href= \"addtojustadded.php?to_id=".$item->{'id'}."\">".$item->{'name'}."<img src=\"http://graph.facebook.com/".$item->{'id'}."/picture\" alt=\"No Image\"/> </a></li>";
				}	
				print "</ul>";
			}	

		?>
						
		</div><!-- /content -->
	</div><!-- /page -->
	
	</body>
	</html>