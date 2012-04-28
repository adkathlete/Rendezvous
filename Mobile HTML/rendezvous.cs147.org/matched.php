<?php
session_start();
require_once ("./_includes/read_user_matches.php");
require_once ("./_includes/return_user_names.php");
require_once ("./_includes/add_chat.php");
require_once ("./_includes/read_user_chat.php");
require_once ("./_includes/get_my_name.php");
require_once ("./_includes/count_matches.php");


if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

$userId = $_SESSION['id'];
$userMatches = readUserMatches($userId);
$matchcount = countMatches($userId);
$nummatches = @mysql_result($matchcount,0,0);

if (@$_POST['submitted']) {
$newchat = @$_POST['chat'];
addChat($_SESSION['id'],$_GET['to_id'],$newchat);
header ("Location: demoUser.php?to_id=".$_GET['to_id']);
}

?>

<!DOCTYPE html> 
<html> 
  <head> 
    <title>My Match</title> 
    
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
<div data-role="page" id="Matches">

	<div data-role="header" data-position="fixed">
		<h1>My Matches</h1>
<a href="matches.php" data-direction="reverse" data-rel="back" data-icon="back">Back</a>
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
		<h4>This is the Previous Matches Page.</h4>
		<p id=\"contactArea\">
		Here you can view your current match, as well as previous matches. Click on any of your matches to view his or her profile and have the option of sending them a message as well!
		</p>
	</div>
	<div id=\"backgroundPopup\"></div>";
}
?>	
		<?php
			if ($nummatches == 0) {
			print "<p>Sorry you have no matches. Don't worry, there are many fish in the ocean...</p>";
}
		?>
		
		
			<ul data-role="listview" data-theme="g" list-dividertheme="b" data-inset="true">
			
<?php
			
				//Play Current Match

				if ($nummatches > 0) {

				$currentMatch = mysql_fetch_array($userMatches);
				$listnames = returnUserNames($currentMatch['to_id']);
				print "<li data-role=\"list-divider\">Current Match</li>";
				$first_name = @mysql_result($listnames,0,'first_name');
				$last_name = @mysql_result($listnames,0,'last_name');
				print "<li><a href=\"demoUser.php?to_id=".$currentMatch['to_id']."\">".$first_name." ".$last_name."</a></li>";
				
				}

				if ($nummatches > 1) {
				//Print Previous Matches
				//$pastMatches = mysql_fetch_array($userMatches);
				print "<li data-role=\"list-divider\">Previous Matches</li>";
				
				while ($pastMatches = mysql_fetch_array($userMatches)) {
					$listnames = returnUserNames($pastMatches['to_id']);
					$first_name = @mysql_result($listnames,0,'first_name');
					$last_name = @mysql_result($listnames,0,'last_name');
					print "<li><a href=\"demoUser.php?to_id=".$pastMatches['to_id']."\">".$first_name." ".$last_name."</a></li>";
				}
}
?>
			</ul>
				
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
