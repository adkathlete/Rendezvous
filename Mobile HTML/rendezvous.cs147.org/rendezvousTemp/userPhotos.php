<?php
session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}


?>
<html> 
  <head> 
    <title>Demo User Page</title> 
    
    <meta name="viewport" content="width=device-width, initial-scale=1"> 

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.js"></script>
</head> 
<body> 

<!-- Start of First List Page -->
<div data-role="page" id="demoUser">

	<div data-role="header" data-position="fixed">
		<h1>Demo User Page</h1>
		<a href="friends.php" data-direction="reverse" data-rel="back" data-icon="back">Back</a>
	</div><!-- /header -->

	<div data-role="content">	
		
		<?php
		
		$userId=$_GET['to_id'];
		$userJson=file_get_contents("https://graph.facebook.com/".$userId."?".$_SESSION['accesstoken']);
		$decodedUser = json_decode($userJson);
		
		print"<img src=\"http://graph.facebook.com./".$userId."/picture\" alt=No Image></a>";
		print"<p>".$decodedUser->{'name'}."</p>";
		?>
		<p>  </p>
		
		<div data-role="fieldcontain">
			<label for="textarea">Chat:</label>
			<textarea cols="100" rows="8" name="textarea" id="textarea"></textarea>
		</div>
		<input type="submit" name="btn-send" id="btn-send" value="Send" onclick>
		
		
				
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-id="navbar">
		<div data-role="navbar">
			<ul>
					<li><a href="home.php" data-direction="reverse" data-icon="home">Home</a></li>
					<li><a href="my_Lists.php"  data-direction="reverse" data-icon="grid">My List</a></li>
					<li><a href="friends.php" data-direction="reverse" class="ui-btn-active" data-icon="grid">Friends</a></li>
					<li><a href="matches.php"  data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->

</body>
</html