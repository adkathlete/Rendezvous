<?php

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}


?>

<!DOCTYPE html> 
<html> 
  <head> 
    <title>My Friends</title> 
    
    <meta name="viewport" content="width=device-width, initial-scale=1"> 

    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
    <link rel="stylesheet" href="themes/AquaOrange.min.css">

    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
	<script>
	$(document).bind("mobileinit", function(){
	  $.mobile.touchOverflowEnabled = true;
	});
	</script>
			<link rel="stylesheet" href="general.css" type="text/css" media="screen" />
	<script src="http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js" type="text/javascript"></script>
	<script src="popup.js" type="text/javascript"></script>
</head> 

<body> 
<div data-role="page" id= "Home">

	<div data-role="header" data-position="fixed">
		<h1>My Friends</h1>
	</div><!-- /header -->

	<div data-role="content">
		<?php
	if ($_SESSION['newUser']) {
		print "<div id=\"button\"><input type=\"submit\" value=\"See Page Tutorial\" /></div><a href=\"disable_tutorials.php\" data-role=\"button\"> Disable Tutorials</a>";
}
?>

	<?php
	if ($_SESSION['newUser']) {
	print "<div id=\"popupContact\">
		<a id=\"popupContactClose\">x</a>
		<h4>This is the Friends Page.</h4>
		<p id=\"contactArea\">
		This is the Friends Tab. You can search for your friends or new users to view their profiles.
		</p>
	</div>
	<div id=\"backgroundPopup\"></div>";
}
?>
		
	<form action="friends.php" method="post">	
		
		<div data-role="fieldcontain">
			<label for="search"></label>
			<input type="search" name="search" id="search" value="" />
			     <input type="submit" value="Search" name="submitted"/>
		</div>
		     
		
	</form>
		
	<?php
		if(@$_POST['submitted']){
			$search=str_replace(' ','',@$_POST['search']);
			if (strlen($search) == 0) {
			header("Location: friends.php");
			}else{
			
	$usersJson=file_get_contents("https://graph.facebook.com/search?q=".$search."&type=user&".$_SESSION['accesstoken']."&limit=25");
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
			print "<ul data-role=\"listview\" data-theme=\"g\"  data-dividertheme=\"b\" data-inset=\"true\">";
			
				
		
			foreach($allFriends as $item){
				print "<li> <a href= \"demoUser.php?to_id=".$item->{'id'}."\">".$item->{'name'}."<img src=\"http://graph.facebook.com/".$item->{'id'}."/picture?type=large\" width=100% height=100% alt=\"No Image\"/> </a></li>";
			}	
			print "</ul>";
			}
		}
	
	/*function friendCMP($a, $b)
	{
	    if ($a->{'name'} == $b->{'name'}) {
	        return 0;
	    }
	    return strcasecmp($a->{'name'}, $b->{'name'});
	}

	usort($decoded->{'data'}, "friendCMP");
	
	print "<ul data-role=\"listview\" data-theme=\"g\"  data-dividertheme=\"b\" data-inset=\"true\" data-filter=\"true\">";

	foreach($decoded->{'data'} as $item){
		print "<li> <a href= \"demoUser.php\">".$item->{'name'}."</a></li>";
	}	
	print "</ul>";*/
	
	?>
	
		
		
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-id="navbar">
		<div data-role="navbar">
			<ul>
						<li><a href="home.php" data-icon="home" data-direction="reverse">Home</a></li>
						<li><a href="my_Lists.php"data-icon="grid" data-direction="reverse">List</a></li>
						<li><a href="friends.php" class="ui-btn-active" class="ui-state-presist"data-icon="search">Friends</a></li>
						<li><a href="matches.php" data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->
</body>
</html