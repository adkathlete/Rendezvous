<?php

require_once ("./_includes/read_user_record.php");
session_start();


if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

if ($_GET['refresh'] == 1) {
header ('Location: settings.php');
}

$userRecord = readUserRecord($_SESSION['id']);


?>

<!DOCTYPE html> 
<html> 
  <head> 
    <title>Settings</title> 
    
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
<div data-role="page" id= "Settings">

	<div data-role="header" data-position="fixed">
		<h1>Settings</h1>
		<a href="home.php" data-role="button" data-direction="reverse" data-icon="back">Back</a>
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
		<h4>This is the Settings Page.</h4>
		<p id=\"contactArea\">
		Here you can edit your settings, update your phone number and select whether or not you want to be in the next rendezvous.
		</p>
	</div>
	<div id=\"backgroundPopup\"></div>";
}
?>
		
		<?php
		$row = mysql_fetch_array($userRecord);
		print "<p>Your Phone Number: ".$row['phone_number']." <a data-role=\"button\" href=\"edit_phone.php\">Edit</a></p>
		<p>Participate In The Next Rendezvous? ".$row['rendezvous']." <a data-role=\"button\" href=\"edit_settings.php\">Edit</a></p>";
?>
		
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-id="navbar">
		<div data-role="navbar">
			<ul>
						<li><a href="settings.php" class="ui-btn-active"data-icon="home">Home</a></li>
						<li><a href="my_Lists.php"data-icon="grid">My Lists</a></li>
						<li><a href="friends.php" data-icon="grid">Friends</a></li>
						<li><a href="matches.php" data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->
</body>
</html
