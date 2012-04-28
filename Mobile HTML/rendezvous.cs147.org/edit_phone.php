<?php
require_once ("./_includes/add_phone_number.php");
require_once ("./_includes/check_for_phone.php");

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

if (@$_POST['submitted']) {
$phonenumber = @$_POST['thephone'];
if(strlen($phonenumber)==10 && is_numeric($phonenumber)){
	addPhoneNumber($_SESSION['id'],$phonenumber);
	header ('Location: settings.php');
}else{
	$error=true;
}

}

?>

<!DOCTYPE html> 
<html xmlns:fb="http://ogp.me/ns/fb#">> 
  <head> 
    <title>Phone Registration</title> 
    
	<!--><!-->

    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta property="og:title" content="Rendezvous"/>
	<meta property="og:type" content="website"/>
	<meta property="og:url" content="http://www.rendezvous.cs147.org"/>
	<meta property="og:image" content="http://www.akonig.cs147.org/rendezvous/Konigsberg.jpg"/>

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
	<link rel="stylesheet" href="themes/AquaOrange.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.js"></script>
</head> 

<body> 
<div data-role="page" id= "index">
	
	<div data-role="header" data-position="fixed">
		<h1 style="white-space: normal">Add Your Phone #</h1>
	</div><!-- /header -->

	<div data-role="content">
		<?php
		if($error){
			print"Woops! You entered an invalid phone number. Please try to update your number again.";
		}
		?>
		<p>Please give us your phone number we can send updates directly to your phone. We will never give out your number without your permission.</p>
		<form action="edit_phone.php" method="post">
		<input type="text" name="thephone" id="thephone" value="" />
	    	<input type="submit" value="Save" name="submitted"/>
		</form>


		

</div><!-- /page -->
</body>
</html>
