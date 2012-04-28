<!DOCTYPE html> 
<html xmlns:fb="http://ogp.me/ns/fb#">> 
  <head> 
    <title>Welcome to Rendezvous</title> 
    
	<!--><!-->

    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta property="og:title" content="Rendezvous"/>
	<meta property="og:type" content="website"/>
	<meta property="og:url" content="http://www.rendezvous.cs147.org"/>
	<meta property="og:image" content="http://www.akonig.cs147.org/rendezvous/Konigsberg.jpg"/>

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
    <link rel="stylesheet" href="themes/AquaOrange.css">
	<link rel="apple-touch-startup-image" href="startup.png">
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.4.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0/jquery.mobile-1.0.min.js"></script>
	<script>
	$(document).bind("mobileinit", function(){
	  $.mobile.touchOverflowEnabled = true;
	});
	</script>
	<script>
		if (window.navigator.userAgent.indexOf('iPhone') != -1) {
			if (window.navigator.standalone == true) {
			}else{
				
			}
		}
	</script>
	
	<style>

	#index{background-image: url('aquafit.gif'); position:fixed; background-size: 100%;}
	#login{position: fixed; top: 62%; left:25%; right: 25%;}
	#about{position: fixed; top: 75%; left: 20%; right: 20%;}
	</style>
</head> 

<body> 
	
<div data-role="page" id= "index">
	
	<!--<div data-role="header" data-position="fixed">-->
	<!--	<h1 style="white-space:normal">Welcome to Rendezvous!</h1>-->
	<!--</div><!-- /header -->

	<div data-role="content">
		<a id="login" href="https://graph.facebook.com/oauth/authorize?type=web_server&display=touch&scope=offline_access,user_photos,friends_photos,sms,user_location &client_id=235693846448097&redirect_uri=http://rendezvous.cs147.org/fbcallback.php" data-role="button">Log In</a>
		
		<a data-role="button" id="about" href="about.php">Learn More</a>
		
		

</div><!-- /page -->
</body>
</html>

