<?php

include("./../db_conn.php");

$haskey = "HAS_" . uniqid();


$data = " `has` = '$haskey' ";
$data .= ", `time` = '$time' ";
$data .= ", `status` = 'create' ";
$save = $conn->query("INSERT INTO `gate_auth` SET " . $data);

if($save){
    die($haskey);
}else{
    die("error");
}
