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

<!DOCTYPE html> 
<html> 
  <head> 
    <title>My List</title> 
    
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
    <link rel="stylesheet" href="themes/AquaOrange.min.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
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

<!-- Start of First List Page -->

<div data-role="page" id="myLists">
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
		
			print "<li id=\"userID_".$row['to_id']."\"><a class=\"mylist\" href=\"demoUser.php?to_id=".$row['to_id']."\"> <img src=\"http://graph.facebook.com/".$decoded->{'id'}."/picture\" width=100% alt=\"No Image\"/>".$decoded->{'name'}."</a></li>";
			//print "<a href=\"move_up.php?to_id=".$row['to_id']."\">Move Up</a> <a href=\"move_down.php?to_id=".$row['to_id']."\">Move Down</a>";
		
	}else{
		print "<li id=\"userID_".$row['to_id']."\"><a class=\"mylist\" href=\"demoUser.php?to_id=".$row['to_id']."\"> <img src=".$decodedPicData->{'source'}." width=100% alt=\"No Image\"/>".$decoded->{'name'}."</a></li>";

	}
	$decodedPicData=NULL;
}*/
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
					<li><a href="home.php?refresh=1" data-direction="reverse" data-icon="home">Home</a></li>
					<li><a href="my_Lists.php" class="ui-btn-active" data-icon="grid">List</a></li>
					<li><a href="friends.php" data-icon="search">Friends</a></li>
					<li><a href="matches.php" data-icon="star">Matches</a></li>
					</ul>
		</div>
	</div><!-- /footer -->
</div><!-- /page -->

<script type="text/javascript">
function makeEdit() {

$(".mylist").each(function() {
var id = $(this).attr("id");
//$(this).append("<a class=\"rio\" href= \"home.php\">Hello</a>");
$(this).after("<a class=\"rio\"  href = \"home.php\">Hi</a>");			     			     
});


$(".rio").page('destroy').page();

}
</script>

<script>
$("p").bind("click", function(event){
var str = "( " + event.pageX + ", " + event.pageY + " )";
$("span").text("Click happened! " + str);
});
$("p").bind("dblclick", function(){
$("span").text("Double-click happened in " + this.nodeName);
});
$("p").bind("mouseenter mouseleave", function(event){
$(this).toggleClass("over");
});

</script>

</body>
</html>
