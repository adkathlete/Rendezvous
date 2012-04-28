<?php
session_start();
require_once ("./_includes/read_user_matches.php");
require_once ("./_includes/return_user_names.php");

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

$userId = $_SESSION['id'];
$userMatches = readUserMatches($userId);

?>

<!DOCTYPE html> 
<html> 
  <head> 
    <title>Page Title</title> 
    
    <meta name="viewport" content="width=device-width, initial-scale=1"> 

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.js"></script>
</head> 

<body> 
<div data-role="page" id="Matches">

	<div data-role="header" data-position="fixed">
		<h1>My Matches</h1>
	</div><!-- /header -->

	<div data-role="content">	
		<?php
			if($_SESSION['newUser']){
				
				print"<p> This is the Matches Tab. Here you can view your current match, as well as previous matches. Click on your match to view his or her profile and have the option to text that user a personal message.";
			}
		
		?>
		
		
			<ul data-role="listview" data-theme="g" list-dividertheme="b" data-inset="true">
			
<?php
			
				//Print Current Match
				print "<li data-role=\"list-divider\">Current Match</li>";
				$currentMatch = mysql_fetch_array($userMatches);
				$listnames = returnUserNames($currentMatch['to_id']);
				$first_name = @mysql_result($listnames,0,'first_name');
				$last_name = @mysql_result($listnames,0,'last_name');
				print "<li><a href=\"demoUser.php?to_id=".$currentMatch['to_id']."\">".$first_name." ".$last_name."</a></li>";
				
				//Print Previous Matches
				//$pastMatches = mysql_fetch_array($userMatches);
				print "<li data-role=\"list-divider\">Previous Matches</li>";
				
				while ($pastMatches = mysql_fetch_array($userMatches)) {
					$listnames = returnUserNames($pastMatches['to_id']);
					$first_name = @mysql_result($listnames,0,'first_name');
					$last_name = @mysql_result($listnames,0,'last_name');
					print "<li><a href=\"demoUser.php?to_id=".$pastMatches['to_id']."\">".$first_name." ".$last_name."</a></li>";
				}
?>
			</ul>
				
	</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-id="navbar">
		<div data-role="navbar">
			<ul>
					<li><a href="home.php" data-direction="reverse" data-icon="home">Home</a></li>
					<li><a href="my_Lists.php"data-direction="reverse" data-icon="grid">My List</a></li>
					<li><a href="friends.php" data-icon="grid" data-direction="reverse">Friends</a></li>
					<li><a href="matches.php" class="ui-btn-active" data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->

</body>
</html
