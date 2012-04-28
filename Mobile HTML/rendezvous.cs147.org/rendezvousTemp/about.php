<?php

session_start();

if ($_SESSION['logged_in'] != 1) {
header ('Location: welcome.php');
}

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

<!-- Start of second page -->
<div data-role="page" id="About">

	<div data-role="header">
		<h1>About</h1>
		<a href="home.php" data-role="button" data-icon="back" data-direction="reverse">Home</a>
	</div><!-- /header -->

	<div data-role="content">	
		<h2>Rejection sucks.</h2>
		<p>Rendezvous is here to help.</p>
		<p>This is the no bullshit, totally risk-free app that finds
		out if your curshes are also crushing on you.</p>
		<p>We know you've got an "i-would-totally-makeout-with-this-person" list in your head.
		So do all of your friends and classmates.  Wouldn't it be cool if there was some way to
		match people with a mutual interest in eachother?</p>
		<p>Rendezvous does just that. We've written a super smart, totally awesome algorithm that
		finds secret connections you and your friends have to the hottties arround campus. How does
		it all work, you ask? Each user can add friends, strangers, or anyone in between to their list of Rendezvous candidates. Each weekend we will match up all of the bros, dudes, jocks, nerds, techies and fuzzies who appear on one another's list, and send out your match. You will never be alerted of a match unless that person was interested in a Rendezvous with you as well. We will give you their phone number, but the rest is up to you...  </p> 
		<p>	Icons By <a href="http://glyphish.com/">Glyphish</a> </p>			
	</div><!-- /content -->
</div><!-- /page -->

</body>
</html
