<?php
session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}


?>
<html> 
  <head> 
    <title>User Photos</title> 
    
    <meta name="viewport" content="width=device-width, initial-scale=1"> 
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.css" />
    <link rel="stylesheet" href="themes/AquaOrange.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
	<script>
	$(document).bind("mobileinit", function(){
	  $.mobile.touchOverflowEnabled = true;
	});
	</script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
	<script type="text/javascript" src="/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
	<script type="text/javascript" src="/fancybox/jquery.mousewheel-3.0.4.pack.js"></script>
	<link rel="stylesheet" href="/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />
	<script>
	$(document).ready(function() {

		$("a.photos").fancybox({
			'transitionIn'	:	'elastic',
			'transitionOut'	:	'elastic',
			'speedIn'		:	600, 
			'speedOut'		:	200, 
			'margin'	:	15
		});

	});</script>
</head> 
<body> 

<!-- Start of First List Page -->
<div data-role="page" id="demoUser">
	<?php
	
	$userId=$_GET['to_id'];
	$userJson=file_get_contents("https://graph.facebook.com/".$userId."?".$_SESSION['accesstoken']);
	$decodedUser = json_decode($userJson);

	$data = file_get_contents("https://graph.facebook.com/".$userId."/albums?".$_SESSION['accesstoken']);
	$decodeddata = json_decode($data);
	$x=0;
	while($x<count($decodeddata->{'data'})){
		if($decodeddata->{'data'}[$x]->{'name'}=="Profile Pictures"){
			$picData=file_get_contents("https://graph.facebook.com/".$decodeddata->{'data'}[$x]->{'id'}."/photos?".$_SESSION['accesstoken']);
			$decodedPicData=json_decode($picData);
			break;
		}
		$x=$x+1;
	} 
	
	print "<div data-role=\"header\" data-position=\"fixed\">
		<h1>".$decodedUser->{'first_name'}."'s Photos</h1>
		<a href=\"demoUser.php?to_id=".$userId."\" data-direction=\"reverse\" data-icon=\"back\">Back</a>
	</div><!-- /header -->


	<div data-role=\"content\">";?>
		<?php
	foreach($decodedPicData->{'data'} as $item){
		//print "<img id=\"button\" src=".$item->{'source'}." width=20% alt=\"Avatar.jpg\"/>";
		print "<a href=".$item->{'source'}." class=\"photos\" rel=\"gallery\"><img src=".$item->{'source'}." width=20%></a><span>        </span>";
	} 
	?>
	
			
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
