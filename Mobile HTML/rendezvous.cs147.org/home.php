<?php
session_start();
require_once("./_includes/facebook.php");
require_once("./_includes/return_user_names.php");
require_once("./_includes/read_unread_chat.php");

if ($_SESSION['logged_in'] != 1) {
   header('Location: welcome.php');
}

if ($_GET['refresh'] == 1) {
header ('Location: home.php');
}

$config = array();
$config[‘appId’] = '235693846448097';
$config[‘secret’] = '803b07bd05274040a4e73c1156ab4cf9';
$config[‘fileUpload’] = false; // optional

$facebook = new Facebook($config);

$unreadchat = readUnreadChat($_SESSION['id']);
?>


<!DOCTYPE html> 
<html> 
  <head> 
    <title>Home</title> 
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
    <link rel="stylesheet" href="themes/AquaOrange.min.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
	<script type="text/javascript">if (window.location.hash == '#_=_')window.location.hash = '';</script>
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
	
	<style type="text/css">
		.nav-glyphish-example .ui-btn .ui-btn-inner { padding-top: 40px !important; }
		.nav-glyphish-example .ui-btn .ui-icon { width: 30px!important; height: 30px!important; margin-left: -15px !important; box-shadow: none!important; -moz-box-shadow: none!important; -webkit-box-shadow: none!important; -webkit-border-radius: none !important; border-radius: none !important; }
		#chat .ui-icon { background:  url(glyphish-icons/09-chat2.png) 50% 50% no-repeat; background-size: 24px 22px; }
		#email .ui-icon { background:  url(glyphish-icons/18-envelope.png) 50% 50% no-repeat; background-size: 24px 16px;  }
		#login .ui-icon { background:  url(glyphish-icons/30-key.png) 50% 50% no-repeat;  background-size: 12px 26px; }
		#beer .ui-icon { background:  url(glyphish-icons/88-beermug.png) 50% 50% no-repeat;  background-size: 22px 27px; }
		#coffee .ui-icon { background:  url(glyphish-icons/100-coffee.png) 50% 50% no-repeat;  background-size: 20px 24px; }
		#skull .ui-icon { background:  url(glyphish-icons/21-skull.png) 50% 50% no-repeat;  background-size: 22px 24px; }
	</style>
<div data-role="page" id= "Home">

	<div data-role="header" data-position="fixed">
		<h1>Rendezvous</h1>
		<a href="about.php" data-role="button" data-icon="info" data-iconpos="notext"></a>
		<a href="settings.php?refresh=1" data-role="button" data-icon="gear" data-iconpos="notext"></a>
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
		<h4>This is the Home Page.</h4>
		<p id=\"contactArea\">
		You will see notifications about new matches on this page, as well as the image that other users will be able to see when they try to view your profile. There is an info in the upper left for more information, and a setting button in the upper right, where you can edit your phone number, and change other settings.
		These hints will remain on until your log out, or click the button below.
		</p>
	</div>
	<div id=\"backgroundPopup\"></div>";
}
?>
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
	
		print "<div style=\"border:1px solid black\" align=\"center\"><b><font face=\"sans-serif\">Time Until Next Rendezvous</font></b><br><iframe src=\"http://free.timeanddate.com/countdown/i2v9gy0e/cf12/cm0/cu4/ct0/cs0/ca0/co0/cr0/ss0/cac000/cpc000/pct/tcfff/fs100/szw320/szh135/iso2011-12-12T00:00:00\" frameborder=\"0\" width=\"103\" height=\"30\"></iframe></div>
<br><br>";

		print "<img src=".$decodedPicData->{'source'}." width=\"100%\" align=\"left\" alt=\"Avatar.jpg\">";
		
	     ?>
			
			
			<div data-role="fieldcontain">
<?php
			print "<br><ul data-role=\"listview\" data-inset=\"true\">";
			print "<li data-role=\"list-divider\">Unread Messages</li>";

			$chatcount = 0;

		while ($chatline = mysql_fetch_array($unreadchat)) {
		      $chatcount++;
		      print "<li><a href=\"demoUser.php?to_id=".$chatline['from_id']."\">";

		      $toname = returnUserNames($chatline['from_id']);
		      $acttoname = @mysql_result($toname,0,'first_name');
		      print "<h5>".$acttoname."</h5>";
		      print "<p style= \"white-space: normal\">".$chatline['message']."</p>";
		      print "<p class=\"ui-li-aside\"><strong>".date('m-d-Y \a\t H:i',strtotime($chatline['time']))."</strong></p></a></li>";

		}
		if ($chatcount == 0) {
		print "<li>There are no unread messages.</li>";
} 
		print "<li><a href=\"messages.php\">";
		print "Go To Message Inbox.</a></li>";
		print "</ul>";
?>
			</div>
	</div><!-- /content -->

	<!--<div data-role="footer" class="nav-glyphish-example">
		<div data-role="navbar" class="nav-glyphish-example" data-grid="d">
		<ul>
			<li><a href="#" id="chat" data-icon="chat">Chat</a></li>
			<li><a href="#" id="email" data-icon="custom">Email</a></li>
			<li><a href="#" id="skull" data-icon="custom">Danger</a></li>
			<li><a href="#" id="beer" data-icon="custom">Beer</a></li>
			<li><a href="#" id="coffee" data-icon="custom">Coffee</a></li>
		</ul>
		</div>
	</div> -->
	<div data-role="footer" data-position="fixed" data-id="navbar">
		<div data-role="navbar">
			<ul>
						<li><a href="home.php" class="ui-btn-active" class="ui-state-presist" data-icon="home">Home</a></li>
						<li><a href="my_Lists.php"data-icon="grid">List</a></li>
						<li><a href="friends.php" data-icon="search">Friends</a></li>
						<li><a href="matches.php" data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->
</body>
</html
