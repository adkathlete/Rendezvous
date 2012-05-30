<?php

require_once ("./_includes/update_position.php");

if ($_GET['from_id'] && $_GET['to_id'] && $_GET['position']) {
updatePosition($_GET['from_id'],$_GET['to_id'],$_GET['position']);
}

?>