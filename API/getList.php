<?php

require_once ("./_includes/read_user_list.php");

if ($_GET['id']) {

$rows = array();
$record = readUserList($_GET['id']);
while ($r = mysql_fetch_assoc($record)) {
$rows[] = $r;
}
print json_encode($rows);
}

?>