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
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
	<script>
	$(document).bind("mobileinit", function(){
	  $.mobile.touchOverflowEnabled = true;
	});
	</script>
</head> 
<body> 

<!-- Start of First List Page -->
<div data-role="page" id="popup">
	<div data-role="content">";
			
	</div><!-- /content -->

</div><!-- /page -->

</body>
</html