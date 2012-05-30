<?php

require_once ("./_includes/remove_from_list.php");

if ($_GET['from_id'] && $_GET['to_id']) {
removeFromList($_GET['from_id'],$_GET['to_id']);
}

?>