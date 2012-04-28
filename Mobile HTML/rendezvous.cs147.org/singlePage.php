<?php
session_start();
require_once("./_includes/facebook.php");
require_once("./_includes/return_user_names.php");
require_once("./_includes/read_unread_chat.php");

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
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta property="og:title" content="Rendezvous"/>
	<meta property="og:type" content="website"/>
	<meta property="og:url" content="http://www.rendezvous.cs147.org"/>
	<meta property="og:image" content="http://www.akonig.cs147.org/rendezvous/Konigsberg.jpg"/>

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
    <link rel="stylesheet" href="themes/AquaOrange.css">
	<link rel="apple-touch-startup-image" href="startup.png">
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
	<script>
	$(document).bind("mobileinit", function(){
	  $.mobile.touchOverflowEnabled = true;
	});
	</script>
	<script>
		if (window.navigator.userAgent.indexOf('iPhone') != -1) {
			if (window.navigator.standalone == true) {
			}else{

			}
		}
	</script>

	<style>

	#index{background-image: url('aquafit.gif'); position:fixed; background-size: 100%;}
	#login{position: fixed; top: 62%; left:25%; right: 25%;}
	#about{position: fixed; top: 75%; left: 20%; right: 20%;}
	</style> 
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

<div data-role="page" id= "index">

		<!--<div data-role="header" data-position="fixed">-->
		<!--	<h1 style="white-space:normal">Welcome to Rendezvous!</h1>-->
		<!--</div><!-- /header -->

		<div data-role="content">
			<a id="login" href="https://graph.facebook.com/oauth/authorize?type=web_server&display=touch&scope=offline_access,user_photos,friends_photos,sms,user_location &client_id=235693846448097&redirect_uri=http://rendezvous.cs147.org/singlePage.php" data-role="button">Log In</a>

			<a data-role="button" id="about" href="http://rendezvous.cs147.org/singlePage.php#about" data-ajax="false">Learn More</a>



</div><!-- /page -->
<div data-role="page" id="fbcallback">
	<?php
	require_once ("./_includes/check_user_exists.php");
	require_once ("./_includes/add_new_user.php");
	require_once ("./_includes/check_for_phone.php");

	    $app_id = "235693846448097";
	    $app_secret = "803b07bd05274040a4e73c1156ab4cf9";

	    $code = $_GET["code"];
		$error = $_GET["error_reason"];
		if ($error == "user_denied") {

			print	"<p>I'm sorry you weren't interested in using Facebook.</p>";





		} else {

	    $token_url = "https://graph.facebook.com/oauth/access_token?type=web_server&client_id="
	        . $app_id . "&redirect_uri=http://rendezvous.cs147.org/fbcallback.php&client_secret="
	        . $app_secret . "&code=" . $code;

	    $access_token = file_get_contents($token_url);

		$_SESSION['accesstoken'] = $access_token;
		$_SESSION['code'] = $code;
	 	$_SESSION["facebook"] = "true";
		$_SESSION['tempId']=NULL;
			?>

			<?php
			$json=file_get_contents("https://graph.facebook.com/me?".$access_token);
			$decoded = json_decode($json);

			$tempId = $decoded->{'id'};

			//$_SESSION['newUser']=true;
			if (!checkUserExists($tempId)) {
			   addNewUser($tempId,$decoded->{'first_name'},$decoded->{'last_name'},"",$decoded->{'gender'},"");
				$_SESSION['newUser']=true;
			}

			$_SESSION['id'] = $tempId;
			$_SESSION['logged_in'] = 1;

			if (!checkForPhone($tempId)) {
			header('Location: post_phone.php');
			} else {
			header('Location: #home');
			}
		    } ?>
</div>
<div data-role="page" id="about">

	<div data-role="header" data-position="fixed">
		<h1>About</h1>
		<a href="home.php" data-role="button" data-rel="back" data-icon="back" rel="external">Back</a>
	</div><!-- /header -->

	<div data-role="content">	
		<h2>Rejection sucks.</h2>
		<p>Rendezvous is here to help.</p>
		<p>This is the no nonsense, totally risk-free app that finds
		out if your crushes are crushing on you.</p>
		<p>We know you've got an "i-would-totally-makeout-with-this-person" list in your head.
		So do all of your friends and classmates.  Wouldn't it be cool if there was some way to
		discreetly match people with a mutual interest in each other?</p>
		<p>Rendezvous does just that. We've written a super smart, totally awesome algorithm that
		finds secret connections you and your friends have to the hottties around campus. </p>
		<p>How does it all work, you ask?</p>
		<p>Add friends, strangers, or anyone in between to your private list of people you'd like to get to know a little (or a lot) better.
		Consider the rank in which you order these people, because we'll try to match you to users in the order of their appearance on your list. 
		Every weekend, our algorithm will dig up the latest connections between our users. If you're lucky enough to have a match, you and
		your interest will be notified promptly.</p>
		<p>We make the connection. You rendezvous. Good luck! </p> 
		<!--<p>	Icons By <a href="http://glyphish.com/">Glyphish</a> </p>			-->
	</div><!-- /content -->
</div><!-- /page -->

<div data-role="page" id= "home">

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
						<li><a href="#home" class="ui-btn-active" class="ui-state-presist" data-icon="home">Home</a></li>
						<li><a href="#myLists"data-icon="grid">List</a></li>
						<li><a href="friends.php" data-icon="search">Friends</a></li>
						<li><a href="matches.php" data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->


<div data-role="page" id="myLists">
	<?php
	require_once ("./_includes/read_user_record.php");
	require_once ("./_includes/read_user_list.php");
	require_once ("./_includes/return_user_names.php");

	session_start();

	if ($_SESSION['logged_in'] != 1) {
	header ('Location: welcome.php');
	}

	if ($_GET['refresh'] == 1) {
	header ('Location: my_Lists.php');
	}

	$userId = $_SESSION['id'];
	//$userRecord = readUserRecord($userId);
	$userList = readUserList($userId);

	?>
	
	<div data-role="header" data-position="fixed">
		<h1>My List</h1>
		<a href="my_Lists_edit.php" data-ajax="false" data-role="button">Edit</a>
		<a href="newList2.php" data-role="button" data-icon="add" data-iconpos="notext"></a>
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
		<h4>This is the My List Page.</h4>
		<p id=\"contactArea\">
		You can click the plus button to add new people to your list, or click the edit button to delete users from your list or rearrange the order of your list. Click on a user to view their profile page. 
		</p>
	</div>
	<div id=\"backgroundPopup\"></div>";
}
?>

		<?php
		
		if ($_GET['error'] == 1) {
		print "<p>Oops! You've already added this person. We know you're interested, but don't worry, rendezvous will take care of you...</p>";
}

		if ($_GET['error'] == 2) {
		print "<p>Oops! You've hit the maximum number of people you can add to your list. Come on now, save some for the rest of us...</p>";
}
		
		?>
			<ol data-role="listview" data-theme="g" data-inset="true">
			
<?php

$count = 0;

while ($row = mysql_fetch_array($userList)) {
	$count++;
    $urlstring = "https://graph.facebook.com/".$row['to_id'];
    $json = file_get_contents($urlstring);
    $decoded = json_decode($json);
 	print "<li id=\"target\"><a class=\"mylist\" id=\"".$row['to_id']."\" href=\"demoUser.php?to_id=".$row['to_id']."\">".$decoded->{'name'}."<img src=\"http://graph.facebook.com/".$decoded->{'id'}."/picture?type=large\" width=100% height=100% alt=\"Avatar.jpg\"/> </a></li>";
}
			
?>
			</ol>

<?
if($count == 0) {
print "Your list is currently empty. Come on, there must be somebody you're interested in...";
}
?>

		</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-id="navbar">
		<div data-role="navbar">
			<ul>
					<li><a href="#home" data-direction="reverse" data-icon="home">Home</a></li>
					<li><a href="#myLists" class="ui-btn-active" data-icon="grid">List</a></li>
					<li><a href="friends.php" data-icon="search">Friends</a></li>
					<li><a href="matches.php" data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->
</body>
</html