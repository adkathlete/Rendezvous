<?php
require_once ("./_includes/read_user_record.php");
require_once ("./_includes/read_user_list.php");
require_once ("./_includes/return_user_names.php");

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

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
		<a href="my_Lists_edit.php" data-role="button">Edit</a>
		<a href="newList.php" data-role="button" data-icon="add" data-iconpos="notext"></a>
	</div><!-- /header -->

	<div data-role="content">
		<?php
		
		if($_SESSION['newUser']){
			print"<p> This is the List Tab. You can click the plus button to add new people to your list, or click the edit button to delete users from your list or rearrange the order of your list. Click on a user to view their profile page. <p>";
		}
		
		?>
			<ol data-role="listview" data-theme="g" data-inset="true">
			
<?php
while ($row = mysql_fetch_array($userList)) {

      $urlstring = "https://graph.facebook.com/".$row['to_id'];
      $json = file_get_contents($urlstring);
      $decoded = json_decode($json);
	print "<li id=\"target\"><a class=\"mylist\" id=\"".$row['to_id']."\" href=\"demoUser.php?to_id=".$row['to_id']."\">".$decoded->{'name'}."<img src=\"http://graph.facebook.com/".$decoded->{'id'}."/picture\" alt=\"No Image\"/> </a></li>";
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
