<?php

session_start();

?>

<!DOCTYPE html> 
<html> 
  <head> 
    <title>About</title> 
    
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
</head> 

<body> 

<!-- Start of second page -->
<div data-role="page" id="About">

	<div data-role="header" data-position="fixed">
		<h1>About</h1>
		<a href="home.php" data-role="button" data-rel="back" data-icon="back" rel="external">Back</a>
	</div><!-- /header -->

	<div data-role="content">	
		<h2>Rejection sucks.</h2>
		<p>Rendezvous is here to help.</p>
		<p>This is the no nonsense, totally risk-free app that finds
		out if your crushes are crushing on you.</p>
		<p>We know you've got an "i-would-totally-makeout-with-this-person" list in your head.
		So do all of your friends and classmates.  Wouldn't it be cool if there was some way to
		discreetly match people with a mutual interest in each other?</p>
		<p>Rendezvous does just that. We've written a super smart, totally awesome algorithm that
		finds secret connections you and your friends have to the hottties around campus. </p>
		<p>How does it all work, you ask?</p>
		<p>Add friends, strangers, or anyone in between to your private list of people you'd like to get to know a little (or a lot) better.
		Consider the rank in which you order these people, because we'll try to match you to users in the order of their appearance on your list. 
		Every weekend, our algorithm will dig up the latest connections between our users. If you're lucky enough to have a match, you and
		your interest will be notified promptly.</p>
		<p>We make the connection. You rendezvous. Good luck! </p> 
		<!--<p>	Icons By <a href="http://glyphish.com/">Glyphish</a> </p>			-->
	</div><!-- /content -->
</div><!-- /page -->

</body>
</html
