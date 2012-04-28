<?php
require_once ("./_includes/add_chat.php");
require_once ("./_includes/read_user_chat.php");
require_once ("./_includes/get_my_name.php");
require_once ("./_includes/read_user_matches.php");
require_once ("./_includes/return_user_names.php");
require_once ("./_includes/count_matches.php");
require_once ("./_includes/mark_unread_chats.php");


session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

$matchcount = countMatches($_SESSION['id']);
$nummatches = @mysql_result($matchcount,0,0);
$userMatches = readUserMatches($_SESSION['id']);
$currentMatch = mysql_fetch_array($userMatches);
$userId = $currentMatch['to_id']; //Be Careful - this is the to_id actually but we've called it userId
$userChat = readUserChat($_SESSION['id'],$userId);
$mynamedata = getMyName($_SESSION['id']);
$myname = @mysql_result($mynamedata,0,0);
markUnreadChats($_SESSION['id'],$userId);

if (@$_POST['submitted']) {
$newchat = @$_POST['chat'];
if (strlen($newchat) != 0) {
addChat($_SESSION['id'],$userId,$newchat);
}
header ("Location: matches.php");
}

?>
<html> 
  <head>
		<?php

		if ($nummatches == 0) {
		print "<title>My Current Match</title>";
} else {

		//$userId = $_GET['to_id'];
		$userJson=file_get_contents("https://graph.facebook.com/".$userId."?".$_SESSION['accesstoken']);
		$decodedUser = json_decode($userJson); 
		$friendsname = $decodedUser->{'first_name'};
		print "<title>My Current Match: ".$decodedUser->{'first_name'}."</title>";
}
		?>
    
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
    <link rel="stylesheet" href="themes/AquaOrange.css">
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

<!-- Start of First List Page -->
<div data-role="page" id="Matches">

	
		
		<?php
		print "<div data-role=\"header\" data-position=\"fixed\">";

		if ($nummatches != 0) {
		//$userId=$_GET['to_id'];
		$userJson=file_get_contents("https://graph.facebook.com/".$userId."?".$_SESSION['accesstoken']);
		$decodedUser = json_decode($userJson);
		
			print "<h1 style=\"white-space: normal\">My Current Match: ".$decodedUser->{'first_name'}."</h1>";
} else {
  print "<h1>My Current Match</h1>";
}
		print "<a href=\"matched.php\" data-role=\"button\" style=\"white-space:normal\" class=\"ui-btn-right\">Old Matches</a>

		</div><!-- /header -->

		<div data-role=\"content\">";

				
	if ($_SESSION['newUser']) {
		print "<div id=\"button\"><input type=\"submit\" value=\"See Page Tutorial\" /></div><a href=\"disable_tutorials.php\" data-role=\"button\"> Disable Tutorials</a>";
}


	
	if ($_SESSION['newUser']) {
	print "<div id=\"popupContact\">
		<a id=\"popupContactClose\">x</a>
		<h4>This is the Current Match Page.</h4>
		<p id=\"contactArea\">
		Here you can view your current match and send him or her a message. This page will be updated after every rendezvous!
		</p>
	</div>
	<div id=\"backgroundPopup\"></div>";
}


		if ($nummatches == 0) {
		print "<p>Sorry you do not currently have a match. Better luck next time...</p>";
		} else {

		$data = file_get_contents("https://graph.facebook.com/".$userId."/albums?".$_SESSION['accesstoken']);
		$decodeddata = json_decode($data);
		
		if(count($decodeddata->{'data'})==0){
			print "<img src=https://graph.facebook.com/".$userId."/picture alt=\"Avatar.jpg\"> </a>";
		} else{
		$x=0;
		while($x<count($decodeddata->{'data'})){
			if($decodeddata->{'data'}[$x]->{'name'}=="Profile Pictures"){
				$picData=file_get_contents("https://graph.facebook.com/".$decodeddata->{'data'}[$x]->{'cover_photo'}."?".$_SESSION['accesstoken']);
				$decodedPicData=json_decode($picData);
				break;
			}
			$x=$x+1;
		}
	
			print "<a href=\"userPhotos.php?to_id=$userId\"> <img src=\"".$decodedPicData->{'source'}."\" width=\"100%\" alt=\"Avatar.jpg\"> </a>";	
		}
		//print"<p>".$decodedUser->{'name'}."</p>";
		}
		?>
		
		<div data-role="fieldcontain" align="center">
		
		<?php
		if ($nummatches != 0) {
		print "<ul data-role=\"listview\" data-inset=\"true\">";
		print "<li data-role=\"list-divider\">Messages</li>";
		
		$chatcount = 0;

		while ($chatline = mysql_fetch_array($userChat)) {
		      $chatcount++;
		      print "<li><a>";
		      if ($chatline['from_id'] == $_SESSION['id']) {
		      print "<h5>".$myname.": </h5>";
		      } else {
		      print "<h5>".$friendsname.": </h5>";
		      }
		      print "<p style= \"white-space: normal\">".$chatline['message']."</p>";
		      print "<p class=\"ui-li-aside\" style= \"white-space: normal\"><strong>".date('m-d-Y \a\t H:i',strtotime($chatline['time']))."</strong></p>";
		      print "</a><a href=\"delete_message.php?forward=2&demo_id=0&from_id=".$chatline['from_id']."&to_id=".$chatline['to_id']."&message=".$chatline['message']."\" data-icon=\"delete\"></a>";
		      print "</li>";

		}
		if ($chatcount == 0) {
		print "<li>There are no messages.</li>";
		}

		print "</ul>";
		print "<br><form action=\"matches.php\" method=\"post\">";
		print "<input type=\"text\" name=\"chat\" id=\"chat\" value=\"\" />";
	    	print "<input type=\"submit\" value=\"Post\" name=\"submitted\" />";
		print "</form>";
		}
		?>


		</div>		
		
				
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-id="navbar">
		<div data-role="navbar">
			<ul>
					<li><a href="home.php" data-direction="reverse" data-icon="home">Home</a></li>
					<li><a href="my_Lists.php"data-direction="reverse" data-icon="grid">List</a></li>
					<li><a href="friends.php" data-icon="search" data-direction="reverse">Friends</a></li>
					<li><a href="matches.php" class="ui-btn-active" data-icon="star">Matches</a></li>

					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->

</body>
</html>
