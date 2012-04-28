<?php
session_start();
require_once ("./_includes/read_all_messages.php");
require_once("./_includes/return_user_names.php");


if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

$userId = $_SESSION['id'];

$allMessages = readAllMessages($userId);

?>

<!DOCTYPE html> 
<html> 
  <head> 
    <title>Messages</title> 
    
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
<div data-role="page" id="Messages">

	<div data-role="header" data-position="fixed">
		<h1>Messages</h1>
<a href="matches.php" data-direction="reverse" data-rel="back" data-icon="back">Back</a>
	</div><!-- /header -->


	<div data-role="content">
	<?php
			$alreadyId = array();
			print "<ul data-role=\"listview\" data-inset=\"true\">";
			print "<li data-role=\"list-divider\">Message Inbox</li>";

			$chatcount = 0;

		while ($chatline = mysql_fetch_array($allMessages)) {
		      $chatcount++;

		      $theId = $chatline['to_id'];
		      if ($chatline['to_id'] == $userId) {
		      	 $theId = $chatline['from_id'];
		      }
		      if (!in_array($theId,$alreadyId)) {
		      print "<li><a href=\"demoUser.php?to_id=".$theId."\">";

		      $urlstring = "https://graph.facebook.com/".$theId;
    		      $json = file_get_contents($urlstring);
    		      $decoded = json_decode($json);

		      $toname = $decoded->{'name'};
		      print "<h5>Conversation with ".$toname."</h5>";
		      print "<p style= \"white-space: normal\">Last Message: ".$chatline['message']."</p>";
		      print "<p class=\"ui-li-aside\"><strong>".date('m-d-Y \a\t H:i',strtotime($chatline['time']))."</strong></p></a></li>";
		      array_push($alreadyId,$theId);
		      }
		}
		if ($chatcount == 0) {
		print "<li>There are no unread messages.</li>";
} 
		print "</ul>";


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
</html>
