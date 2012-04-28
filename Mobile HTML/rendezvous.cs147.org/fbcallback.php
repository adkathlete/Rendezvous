<?php
require_once ("./_includes/check_user_exists.php");
require_once ("./_includes/add_new_user.php");
require_once ("./_includes/check_for_phone.php");

session_start();
?>


<?php 

    $app_id = "235693846448097";
    $app_secret = "803b07bd05274040a4e73c1156ab4cf9";
    
    $code = $_GET["code"];
	$error = $_GET["error_reason"];
	if ($error == "user_denied") {
	
		print	"<p>I'm sorry you weren't interested in using Facebook.</p>";
			
				
	
	
		
	} else {

    $token_url = "https://graph.facebook.com/oauth/access_token?type=web_server&client_id="
        . $app_id . "&redirect_uri=http://rendezvous.cs147.org/fbcallback.php&client_secret="
        . $app_secret . "&code=" . $code;

    $access_token = file_get_contents($token_url);

	$_SESSION['accesstoken'] = $access_token;
	$_SESSION['code'] = $code;
 	$_SESSION["facebook"] = "true";
	$_SESSION['tempId']=NULL;
		?>
		
		<?php
		$json=file_get_contents("https://graph.facebook.com/me?".$access_token);
		$decoded = json_decode($json);
		
		$tempId = $decoded->{'id'};
		
		//$_SESSION['newUser']=true;
		if (!checkUserExists($tempId)) {
		   addNewUser($tempId,$decoded->{'first_name'},$decoded->{'last_name'},"",$decoded->{'gender'},"");
			$_SESSION['newUser']=true;
		}
		
		$_SESSION['id'] = $tempId;
		$_SESSION['logged_in'] = 1;

		if (!checkForPhone($tempId)) {
		header('Location: post_phone.php');
		} else {
		header('Location: home.php');
		}
	    } ?>
