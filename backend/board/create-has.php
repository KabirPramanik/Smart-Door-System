<?php

include("./../db_conn.php");

$haskey = "U_" . uniqid();


$data = " `has` = '$haskey' ";
$data .= ", `time` = '$time' ";
$data .= ", `status` = 'create' ";
$data .= ", `gate_open_by` = '' ";
$data .= ", `gate_open_time` = '$time' ";
$data .= ", `gate_close_by` = '' ";
$data .= ", `gate_close_time` = '$time' ";
$save = $conn->query("INSERT INTO `gate_auth` SET " . $data);
