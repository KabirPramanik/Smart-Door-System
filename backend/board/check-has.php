<?php

include("./../db_conn.php");


if (!isset($_GET["unic_uid"])) {
    die("error");
}

$haskey = $_GET["unic_uid"];

$check_email = $conn->query("SELECT *FROM `gate_auth` WHERE `has` = '$haskey' ")->num_rows;

if ($check_email == 1) {   
    $res = $conn->prepare("SELECT `status` FROM `gate_auth` WHERE `has` = '$haskey' ");
    $res->execute();
    $res->bind_result($status);
    while ($res->fetch()) {
        $status = $status;
    } 

    if ($status == "open") {
        die("1");
    }else{
        die("0");
    }
}else{
    die("error");
}