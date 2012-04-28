<!DOCTYPE html> 
<html xmlns:fb="http://ogp.me/ns/fb#">> 
  <head> 
    <title>Welcome to Rendezvous</title> 
    
	<!--><!-->

    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta property="og:title" content="Rendezvous"/>
	<meta property="og:type" content="website"/>
	<meta property="og:url" content="http://www.rendezvous.cs147.org"/>
	<meta property="og:image" content="http://www.akonig.cs147.org/rendezvous/Konigsberg.jpg"/>

    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.3.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/mobile/1.0b3/jquery.mobile-1.0b3.min.js"></script>
</head> 

<body> 
	<div id="fb-root"></div>
	<script>(function(d, s, id) {
	  var js, fjs = d.getElementsByTagName(s)[0];
	  if (d.getElementById(id)) {return;}
	  js = d.createElement(s); js.id = id;
	  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=235693846448097";
	  fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));</script>
	
<div data-role="page" id= "index">
	
	<div data-role="header" data-position="fixed">
		<h1>Welcome to Rendezvous!</h1>
	</div><!-- /header -->

	<div data-role="content">
		<a href="https://graph.facebook.com/oauth/authorize?type=web_server&display=touch&scope=offline_access,user_photos,friends_photos,sms,user_location &client_id=235693846448097&redirect_uri=http://rendezvous.cs147.org/fbcallback.php" data-role="button">Log In</a>
		
		

</div><!-- /page -->
</body>
</html>

