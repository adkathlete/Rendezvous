<?php
require_once ("./_includes/read_user_record.php");
require_once ("./_includes/read_user_list.php");
require_once ("./_includes/return_user_names.php");

session_start();

$userId = $_SESSION['id'];
//$userRecord = readUserRecord($userId);
$userList = readUserList($userId);

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

<!-- Start of First List Page -->
<div data-role="page" id="myLists">

	<div data-role="header" data-position="fixed">
		<h1>My List</h1>
		<a href="my_Lists.php" data-role="button" data-direction="reverse" data-rel="back" data-icon="back" >Cancel</a>
		<a href="my_Lists.php" data-role="button" data-icon="check" data-iconpos="right">Save</a>
	</div><!-- /header -->

	<div data-role="content">


	<p>Click on someone to delete them from your list!</p>
			<ol data-role="listview" data-theme="g" data-inset="true">
			
<?php
while ($row = mysql_fetch_array($userList)) {

      $urlstring = "https://graph.facebook.com/".$row['to_id'];
      $json = file_get_contents($urlstring);
      $decoded = json_decode($json);
	//$listnames = returnUserNames($row['to_id']);
	//$first_name = @mysql_result($listnames,0,'first_name');
	//$last_name = @mysql_result($listnames,0,'last_name');
	print "<li><a href=\"delete_from_list.php?to_id=".$row['to_id']."\">".$decoded->{'name'}."<img src=\"http://graph.facebook.com/".$decoded->{'id'}."/picture\" alt=\"No Image\"/><a href=\"home.php\">Hello</a></a></li>";
	print "<a href=\"move_up.php?to_id=".$row['to_id']."\">Move Up</a> <a href=\"move_down.php?to_id=".$row['to_id']."\">Move Down</a>";
}
				
?>
			</ol>


		</div><!-- /content -->

	<div data-role="footer" data-position="fixed" data-id="navbar">
		<div data-role="navbar">
			<ul>
					<li><a href="home.php" data-direction="reverse" data-icon="home">Home</a></li>
					<li><a href="my_Lists.php" class="ui-btn-active" data-icon="grid">My List</a></li>
					<li><a href="friends.php" data-icon="grid">Friends</a></li>
					<li><a href="matches.php" data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->

</body>
</html>
