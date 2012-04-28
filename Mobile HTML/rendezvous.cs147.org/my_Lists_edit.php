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
    <title>Edit My List</title> 
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
	<link rel="stylesheet" href="themes/AquaOrange.min.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
	<script src="touchEvents.js"></script>
	<script>
	$(document).bind("mobileinit", function(){
	  $.mobile.touchOverflowEnabled = true;
	});
	</script>
	<script>
	  $(document).ready(function() {
	   		$("#myList").sortable();
			$("#myList").addTouch();
			$('#save').click(function() {
			  	var order = $('#myList').sortable('serialize'); 
				     	$.post("saveList.php?"+order);
			});
	  });
	</script>

</head>
<body> 

<!-- Start of First List Page -->
<div data-role="page" id="myLists">

	<div data-role="header" data-position="fixed">
		<h1>Edit My List</h1>
		<a href="my_Lists.php" data-role="button" data-direction="reverse" data-rel="back" data-icon="back" >Cancel</a>
		<a href="my_Lists.php?refresh=1" data-role="button" id="save" data-icon="check" data-iconpos="right">Save</a>
	</div><!-- /header -->

	<div data-role="content">
		
				<?php
	/*if ($_SESSION['newUser']) {
		print "<div id=\"button\"><input type=\"submit\" value=\"See Page Tutorial\" /></div><a href=\"disable_tutorials.php?\" data-role=\"button\"> Disable Tutorials</a>";
}
?>

	<?php
	if ($_SESSION['newUser']) {
	print "<div id=\"popupContact\">
		<a id=\"popupContactClose\">x</a>
		<h4>This is the Edit My List Page.</h4>
		<p id=\"contactArea\">
		Here you can edit the order of your list by dragging and dropping the list items. You can also delete people from your list by clicking the X button.
		</p>
	</div>
	<div id=\"backgroundPopup\"></div>";
}*/
?>

		<ol id= "myList" data-role="listview" data-theme="g" data-inset="true">
			
<?php

while ($row = mysql_fetch_array($userList)) {
	$count ++;
      $urlstring = "https://graph.facebook.com/".$row['to_id'];
      $json = file_get_contents($urlstring);
      $decoded = json_decode($json);
	print "<li id=\"userID_".$row['to_id']."\"><a class=\"mylist\" style=\"white-space:normal\"> <img src=\"http://graph.facebook.com/".$decoded->{'id'}."/picture?type=large\" width=100% height=100% alt=\"avatar.jpg\"/>".$decoded->{'name'}."</a> <a href=\"delete_from_list.php?to_id=".$row['to_id']."\" data-icon=\"delete\"></a></li>";
}

/*while ($row = mysql_fetch_array($userList)) {
    $count++;
    $urlstring = "https://graph.facebook.com/".$row['to_id'];
    $json = file_get_contents($urlstring);
    $decoded = json_decode($json);
	

	$data = file_get_contents("https://graph.facebook.com/".$row['to_id']."/albums?".$_SESSION['accesstoken']);
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
	if($decodedPicData==NULL){
		
			print "<li id=\"userID_".$row['to_id']."\"><a class=\"mylist\"> <img src=\"http://graph.facebook.com/".$decoded->{'id'}."/picture\" width=100% alt=\"No Image\"/>".$decoded->{'name'}."</a> <a href=\"delete_from_list.php?to_id=".$row['to_id']."\" data-icon=\"delete\"></a></li>";
			//print "<a href=\"move_up.php?to_id=".$row['to_id']."\">Move Up</a> <a href=\"move_down.php?to_id=".$row['to_id']."\">Move Down</a>";
		
	}else{
		print "<li id=\"userID_".$row['to_id']."\"><a class=\"mylist\"> <img src=".$decodedPicData->{'source'}." width=100% alt=\"No Image\"/>".$decoded->{'name'}."</a> <a href=\"delete_from_list.php?to_id=".$row['to_id']."\" data-icon=\"delete\"></a></li>";

	}
	$decodedPicData=NULL;
}*/
				
?>
			</ol>

<?php
if ($count == 0) {
   print "Your list is currently empty - go back and add someone to your list!";
}

?>

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
