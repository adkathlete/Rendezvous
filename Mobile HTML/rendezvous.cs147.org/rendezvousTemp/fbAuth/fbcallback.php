<?php
session_start();
?>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title>Some Site</title>
<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
</head> 
<body> 

<?php 

    $app_id = "235693846448097";
    $app_secret = "803b07bd05274040a4e73c1156ab4cf9";
    
    $code = $_GET["code"];
	$error = $_GET["error_reason"];
	if ($error == "user_denied") {
		?>
			<p>I'm sorry you weren't interested in using Facebook.</p>
			
				
	
		<?php
		
	} else {

    $token_url = "https://graph.facebook.com/oauth/access_token?type=web_server&client_id="
        . $app_id . "&redirect_uri=http://rendezvous.cs147.org/fbAuth/fbcallback.php&client_secret="
        . $app_secret . "&code=" . $code;

    $access_token = file_get_contents($token_url);

	$_SESSION['accesstoken'] = $access_token;
	$_SESSION['code'] = $code;
 	$_SESSION["facebook"] = "true";
		?>
		
	You can now access your friends' shared links using your browser or the plugin.
		<?php
		$json=file_get_contents("https://graph.facebook.com/me/friends?".$access_token);
		print $json;
	    } ?>
