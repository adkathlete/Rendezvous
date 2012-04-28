<?php

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

?>

<html> 
  <head> 
    <title>Page Title</title> 
    
    <meta name="viewport" content="width=device-width, initial-scale=1"> 

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.js"></script>
</head> 
<body> 

<!-- Start of First List Page -->
<div data-role="page" id="demoList">

	<div data-role="header" data-position="fixed">
		<h1>Stanford</h1>
		<a href="my_Lists.php" data-role="button" data-direction="reverse" data-icon="back">My Lists </a>
		<a href="demoList.php" data-role="button">Edit </a>
	</div><!-- /header -->

	<div data-role="content">	
		<p>This page will have a list of the users added to a given list. Users can select individuals on the list to link to their info page.</p>	
		
		<ol data-role="listview" data-theme="g" data-inset="true">
			<li><a href="demoUser.php">Jane Stanford</a></li>
			<li><a href="demoUser.php">Rachel Smith</a></li>
		</ol>

				
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-id="navbar">
		<div data-role="navbar">
			<ul>
					<li><a href="home.php" data-direction="reverse" data-icon="home">Home</a></li>
					<li><a href="demoList.php" class="ui-btn-active" data-icon="grid">My List</a></li>
					<li><a href="friends.php" data-icon="grid">Friends</a></li>
					<li><a href="matches.php"  data-icon="star">Matches</a></li>
			</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->

</body>
</html
