<?php

require_once ("./_includes/read_all_messages.php");

if ($_GET['id']) {

$record = readAllMessages($_GET['id']);

$rows = array();
while($r = mysql_fetch_assoc($record)) {
    $rows[] = $r;
}
print json_encode($rows);



}

?>