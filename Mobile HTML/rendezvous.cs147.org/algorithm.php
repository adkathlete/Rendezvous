
<?php

$list;

PopulateList($list);


usort($list, "CompareID");

Match($list);
usort($list, "CompareRank");
PrintList($list);
PrintOccurences($occurences);


?>

<?php
function PopulateList(&$list){
    for ($i = 0; $i < 3; $i++) {
        for ($j = 0; $j < rand(1, 2); $j++){
            $j = rand(0, 6);
            if ($i == $j) continue;
            $list[] = array($i, $j, rand(1, 15));
            $list[] = array($j, $i, rand(1, 15));
        } 
    }
}
?>

<?php
function GetOccurences(&$list, &$occurences){
    foreach ($list as $i){
        if ($occurences == NULL) {
            $occurences = array($i[0] => 1);
        }
        else if (!array_key_exists($i[0], $occurences)) {
            $occurences[$i[0]] = 1;
        } else {
            $occurences[$i[0]] = $occurences[$i[0]] + 1;
            
        }
        unset($j);
    }
    unset($i);
}
?>

<?php
function Match($list) {
    $matches;
    while(sizeof($list) > 0) {
        echo "<li> -=-=-=-=-=New Match Round-=-=-=-=-=-";
        
    $occurences;
    GetOccurences($list, $occurences);
    asort($occurences);
    echo "<li> ____________Sorted Occurences______________";
    PrintOccurences($occurences);
    
    $boolean = 1;
    foreach ($occurences as $id => $value) {
        if ($boolean == 1) $number = $value;
        if ($value > $number) break;
        $fewestOccurencesList[] = array($id, $list[$id][1], $list[$id][2]);
        $boolean = 0;
    }
    usort($fewestOccurencesList, "CompareRank");
    echo "<li> ____________List of Fewest Occurences:____________";
    PrintFewestList($fewestOccurencesList);
    echo "<li>________________Removing Occurences From List_____________";
    foreach($fewestOccurencesList as $ToBeRemoved){
        
        $ToID = $ToBeRemoved[1];
        $FromID = $ToBeRemoved[0];
        
        foreach($list as $membe => $val) {
            if ($val[0] == $FromID || $val[0] == $ToID || $val[1] == $FromID || $val[1] == $ToID) {
                echo "<li>";
                echo $FromID;
                echo "->";
                echo $ToID;
                echo "<li>";
                echo $val[0];
                echo "->";
                echo $val[1];
                echo "<li>===========";
                PrintList($list);
                unset($list[$membe]);
                echo "<li>^^^^^^^^^^^";
                PrintList($list);
                echo "<li>===========";
            }
        }
        echo "<li>________________Done Removing Occurences From List_____________";
        echo "<li>________________Removing Occurences From Fewest_____________";
        unset($occurences);
        foreach($fewestOccurencesList as $member) {
            if ($member[0] == $FromID || $member[0] == $ToID || $member[1] == $FromID || $member[1] == $ToID) {
                unset($fewestOccurencesList[key($member)]);
               PrintFewestList($fewestOccurencesList);
            }
            //$fewestOccurencesList = array_values($fewestOccurencesList);
            echo "<li>-----";
        }
        $matches[] = array($FromID, $ToID, 0);
        
    }
    
    PrintFewestList($fewestOccurencesList);
    }
    echo "<li>";
    echo "<id> MATCHES!";
    PrintList($matches);
}
?>

<?php
function PrintList(&$list){
    foreach ($list as $value)
    {
        echo "<li>";
        echo $value[0];
        echo " --> ";
        echo $value[1];
        echo " = ";
        echo $value[2];
    }
    unset($value);
}
?>

<?php
function PrintFewestList(&$fewestOccurencesList){
    foreach ($fewestOccurencesList as $value)
    {
        echo "<li>";
        echo $value[0];
        echo " *--> ";
        echo $value[1];
        echo " = ";
        echo $value[2];
    }
    unset($value);
}
?>

<?php
function PrintFewestOccurences(&$fewestOccurencesList){
    foreach ($fewestOccurencesList as $id => $number)
    {
        echo "<li> ID: ";
        echo $id;
        echo " occurences: ";
        echo $number;
    }
    unset($id);
}
?>

<?php
function PrintOccurences(&$occurences){
    foreach ($occurences as $id => $number)
    {
        echo "<li> ID: ";
        echo $id;
        echo " occurences: ";
        echo $number;
    }
    unset($id);
}
?>

<?php
function CompareRank( $first, $second)
{
    return ($first[2] < $second[2]) ? -1 : 1;
}
?>

<?php
function CompareID( $first, $second)
{
    return ($first[0] < $second[0]) ? -1 : 1;
}
?>








