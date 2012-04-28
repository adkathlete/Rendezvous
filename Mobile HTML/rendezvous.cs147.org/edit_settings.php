<?php
require_once ("./_includes/add_phone_number.php");
require_once ("./_includes/check_for_phone.php");
require_once ("./_includes/add_rendezvous.php");

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

if (@$_POST['submitted']) {
$phonenumber = @$_POST['thephone'];
$rendezvous = @$_POST['slider'];
addRendezvous($_SESSION['id'],$rendezvous);
header ('Location: settings.php');
}

?>

<!DOCTYPE html> 
<html xmlns:fb="http://ogp.me/ns/fb#">> 
  <head> 
    <title>Phone Registration</title> 
    
	<!--><!-->

    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta property="og:title" content="Rendezvous"/>
	<meta property="og:type" content="website"/>
	<meta property="og:url" content="http://www.rendezvous.cs147.org"/>
	<meta property="og:image" content="http://www.akonig.cs147.org/rendezvous/Konigsberg.jpg"/>

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
	<link rel="stylesheet" href="themes/AquaOrange.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.js"></script>
</head> 

<body> 
<div data-role="page" id= "index">
	
	<div data-role="header" data-position="fixed">
		<h1>Edit Settings</h1>
		<a href="settings.php" data-role="button" data-direction="reverse" data-icon="back">Cancel</a>
	</div><!-- /header -->

	<div data-role="content">
		<p style="white-space: normal">Would you like to participate in the next rendezvous?</p>
		<form action="edit_settings.php" method="post">
		<select name="slider" id="slider" data-role="slider">
			<option value="No">No</option>
			<option value="Yes">Yes</option>
		</select> 
	    	<input type="submit" value="Save" name="submitted"/>

		</form>


		

</div><!-- /page -->
</body>
</html>
