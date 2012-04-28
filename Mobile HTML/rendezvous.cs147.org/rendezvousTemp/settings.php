<?php

require_once ("./_includes/read_user_record.php");
session_start();


if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

$userRecord = readUserRecord($_SESSION['id']);


?>

<!DOCTYPE html> 
<html> 
  <head> 
    <title>Settings</title> 
    
    <meta name="viewport" content="width=device-width, initial-scale=1"> 

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.js"></script>
</head> 

<body> 
<div data-role="page" id= "Settings">

	<div data-role="header" data-position="fixed">
		<h1>Settings</h1>
		<a href="home.php" data-role="button" data-direction="reverse" data-icon="back">Cancel</a>
	</div><!-- /header -->

	<div data-role="content">
		
		<?php
		if($_SESSION['newUser']){
			
			print"This is the Settings Page. Here you can edit your settings, and update your phone number.";
		}
		
		?>	
		
		<?php
		$row = mysql_fetch_array($userRecord);
		print "<p>Your Phone Number: ".$row['phone_number']." <a href=\"edit_phone.php\">Edit</a></p>";
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
