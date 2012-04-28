<?php
require_once ("./_includes/add_chat.php");
require_once ("./_includes/read_user_chat.php");
require_once ("./_includes/get_my_name.php");
require_once ("./_includes/mark_unread_chats.php");

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

if (!$_GET['to_id']) {
header ('Location: friends.php');
}

if (@$_POST['submitted']) {
$newchat = @$_POST['chat'];
if (strlen($newchat) != 0) {
addChat($_SESSION['id'],$_GET['to_id'],$newchat);
}
header ("Location: demoUser.php?to_id=".$_GET['to_id']);
}

$userChat = readUserChat($_SESSION['id'],$_GET['to_id']);
$mynamedata = getMyName($_SESSION['id']);
$myname = @mysql_result($mynamedata,0,0);
markUnreadChats($_SESSION['id'],$_GET['to_id']);
?>
<html> 
  <head>
		<?php
		
		$userId=$_GET['to_id'];
		$userJson=file_get_contents("https://graph.facebook.com/".$userId."?".$_SESSION['accesstoken']);
		$decodedUser = json_decode($userJson); 
		$friendsname = $decodedUser->{'first_name'};
		print "<title>".$decodedUser->{'first_name'}."'s Page</title>";
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
</head> 
<body> 

<!-- Start of First List Page -->
<div data-role="page" id="demoUser">

	
		
		<?php
		
		$userId=$_GET['to_id'];
		$userJson=file_get_contents("https://graph.facebook.com/".$userId."?".$_SESSION['accesstoken']);
		$decodedUser = json_decode($userJson);
		
		print "<div data-role=\"header\" data-position=\"fixed\">
			<h1>".$decodedUser->{'first_name'}."'s Page</h1>
			<a href=\"friends.php\" data-direction=\"reverse\" data-rel=\"back\" data-icon=\"back\">Back</a>
		</div><!-- /header -->

		<div data-role=\"content\">";
	
		
	if ($_SESSION['newUser']) {
		print "<div id=\"button\"><input type=\"submit\" value=\"See Page Tutorial\" /></div><a href=\"disable_tutorials.php\" data-role=\"button\"> Disable Tutorials</a>";
}

	if ($_SESSION['newUser']) {
	print "<div id=\"popupContact\">
		<a id=\"popupContactClose\">x</a>
		<h4>This is the Your Friend's Page.</h4>
		<p id=\"contactArea\">
		Click on the photo to see more photos of them or message them by posting a message!
		</p>
	</div>
	<div id=\"backgroundPopup\"></div>";
}


		$data = file_get_contents("https://graph.facebook.com/".$userId."/albums?".$_SESSION['accesstoken']);
		$decodeddata = json_decode($data);
		
		if(count($decodeddata->{'data'})==0){
			print "<img src=https://graph.facebook.com/".$userId."/picture width= height= alt=\"No Image\"> </a>";
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
	
			print "<a href=\"userPhotos.php?to_id=$userId\" data-ajax=\"false\"> <img src=\"".$decodedPicData->{'source'}."\" width=\"100%\" alt=\"No Image\"> </a>";	
		}
		?>
		
		<div data-role="fieldcontain" align="center">
		
		<?php

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
		      print "<p class=\"ui-li-aside\" style=\"white-space:normal\"><strong>".date('m-d-Y \a\t H:i',strtotime($chatline['time']))."</strong></p>";
		      print "</a><a href=\"delete_message.php?forward=1&demo_id=".$userId."&from_id=".$chatline['from_id']."&to_id=".$chatline['to_id']."&message=".$chatline['message']."\" data-icon=\"delete\"></a>";
		      print "</li>";

		}
		if ($chatcount == 0) {
		print "<li>There are no messages.</li>";
		}

		print "</ul>";
		print "<br><form action=\"demoUser.php?to_id=".$userId."\" method=\"post\">";
		?>
		<input type="text" name="chat" id="chat" value="" />
	    	<input type="submit" value="Post" name="submitted" />
		</form>
		


		</div>		
		
				
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-id="navbar">
		<div data-role="navbar">
			<ul>
					<li><a href="home.php?refresh=1" data-direction="reverse" data-icon="home">Home</a></li>
					<li><a href="my_Lists.php"  data-direction="reverse" data-icon="grid">My List</a></li>
					<li><a href="friends.php" data-direction="reverse" class="ui-btn-active" data-icon="grid">Friends</a></li>
					<li><a href="matches.php"  data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->

</body>
</html>
