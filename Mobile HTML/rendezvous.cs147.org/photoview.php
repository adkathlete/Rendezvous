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
	<link rel="stylesheet" href="general.css" type="text/css" media="screen" />
	<script src="http://jqueryjs.googlecode.com/files/jquery-1.2.6.min.js" type="text/javascript"></script>
	<script src="photoPopup.js" type="text/javascript"></script>

</head> 
<body> 

<!-- Start of First List Page -->
<div data-role="page">
	<div data-role="header">
		<h1></h1>
		<a href="userphotos.php" data-direction="reverse" data-rel="back" data-icon="delete" class="ui-btn-right" data-iconpos="notext"></a>
		</div><!-- /header -->

		<div data-role="content" data-theme="d">	
			<?php
			
			$source=$_GET['source'];
			print "<img src=".$source." width=50% alt=\"No Image\"/>";
			
			
			?>	
		</div><!-- /content -->

</div><!-- /page -->

</body>
</html