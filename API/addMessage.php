<?php

require_once ("./_includes/add_chat.php");

if ($_GET['from_id'] && $_GET['to_id'] && $_GET['message']) {

addChat($_GET['from_id'],$_GET['to_id'],$_GET['message']);

}

?>