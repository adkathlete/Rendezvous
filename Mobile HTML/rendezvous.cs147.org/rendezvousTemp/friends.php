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

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.js"></script>
</head> 

<body> 
<div data-role="page" id= "Home">

	<div data-role="header" data-position="fixed">
		<h1>My Friends</h1>
	</div><!-- /header -->

	<div data-role="content">
		<?php
		if($_SESSION['newUser']){
			print "<p> This is the Friends Tab. You can search for your friends or new users to view their profiles. </p>";
		}
		
		?>
		
	<form action="friends.php" method="post">	
		
		<div data-role="fieldcontain">
			<label for="search">Search:</label>
			<input type="search" name="search" id="search" value="" />
			     <input type="submit" value="Go" name="submitted"/>
		</div>
		     
		
	</form>
		
	<?php
		
		if(@$_POST['submitted']){
			$search=str_replace(' ','',@$_POST['search']);
			
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
				print "<li> <a href= \"demoUser.php?to_id=".$item->{'id'}."\">".$item->{'name'}."<img src=\"http://graph.facebook.com/".$item->{'id'}."/picture\" alt=\"No Image\"/> </a></li>";
			}	
			print "</ul>";
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
						<li><a href="my_Lists.php"data-icon="grid" data-direction="reverse">My List</a></li>
						<li><a href="friends.php" class="ui-btn-active" class="ui-state-presist"data-icon="grid">Friends</a></li>
						<li><a href="matches.php" data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->
</body>
</html