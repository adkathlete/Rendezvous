<?php

require_once ("./_includes/add_to_list.php");

if ($_GET['from_id'] && $_GET['to_id']) {

addToList($_GET['from_id'],$_GET['to_id']);

}

?>