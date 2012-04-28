<?php
	session_start();
	$_SESSION['newUser']=false;
	header('Location: home.php');
?>