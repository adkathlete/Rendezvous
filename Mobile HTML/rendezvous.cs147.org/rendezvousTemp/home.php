<?php
session_start();
require_once("./_includes/facebook.php");
require_once("./_includes/return_user_names.php");

if ($_SESSION['logged_in'] != 1) {
   header('Location: welcome.php');
}

$config = array();
$config[‘appId’] = '235693846448097';
$config[‘secret’] = '803b07bd05274040a4e73c1156ab4cf9';
$config[‘fileUpload’] = false; // optional

$facebook = new Facebook($config);
?>


<!DOCTYPE html> 
<html> 
  <head> 
    <title>Home</title> 
    
    <meta name="viewport" content="width=device-width, initial-scale=1"> 

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.js"></script>
</head> 

<body> 
<div data-role="page" id= "Home">

	<div data-role="header" data-position="fixed">
		<h1>Rendezvous</h1>
		<a href="about.php" data-role="button" data-icon="info" data-iconpos="notext"></a>
		<a href="settings.php" data-role="button" data-icon="gear" data-iconpos="notext"></a>
	</div><!-- /header -->

	<div data-role="content">
	  <?php
		
		$urlstring = "https://graph.facebook.com/".$_SESSION['id'];
	    $json = file_get_contents($urlstring);
	    $decoded = json_decode($json);
	
		$data = file_get_contents("https://graph.facebook.com/me/albums?".$_SESSION['accesstoken']);
		$decodeddata = json_decode($data);

		$x=0;
		while($x<count($decodeddata->{'data'})){
			if($decodeddata->{'data'}[$x]->{'name'}=="Profile Pictures"){
					$picData=file_get_contents("https://graph.facebook.com/".$decodeddata->{'data'}[$x]->{'cover_photo'}."?".$_SESSION['accesstoken']);
				$decodedPicData=json_decode($picData);
				break;
			}
			$x=$x+1;
		}
	
		if($_SESSION['newUser']){
			print"<h2> Welcome to Rendezvous ".$decoded->{'first_name'}."!</h2>
				<p> This is the Home Page. You will see notifications about new matches on this page, as well as the image that other users will be able to see when they try to view your profile.<p>
				<p> There is an info in the upper left for more information, and a setting button in the upper right, where you can edit your phone number, and change other settings.<p>
				<p> These hints will remain on until your log out, or click the button below<p>
				<a href=disable_tutorials.php data-role=\"button\"> Disable Tutorials</a>";
		}else{
		print"<h2>Welcome Back, ".$decoded->{'first_name'}."</h2>";
		}
		print "<img src=".$decodedPicData->{'source'}." width=\"200\" height= \"150\" alt=\"No Image\">";
		
		if($_SESSION['newUser']){
			print"<p> This slider indicates your current status for being matched for a Rendezvous. If you would like to Rendezvous, switch this to the ON position. </p>";
		}
	     ?>
			
			
			<div data-role="fieldcontain">
				<label for="slider">Rendezvous?</label>
				<select name="slider" id="slider" data-role="slider">
					<option value="off">Off</option>
					<option value="on">On</option>
				</select> 
			</div>
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-id="navbar">
		<div data-role="navbar">
			<ul>
						<li><a href="home.php" class="ui-btn-active" class="ui-state-presist"data-icon="home">Home</a></li>
						<li><a href="my_Lists.php"data-icon="grid">My List</a></li>
						<li><a href="friends.php" data-icon="grid">Friends</a></li>
						<li><a href="matches.php" data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->
</body>
</html
