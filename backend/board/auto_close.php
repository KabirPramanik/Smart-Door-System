<?php
// auth_close-has
include("./../db_conn.php");


if (!isset($_GET["unic_uid"])) {
    die("error");
}

$haskey = $_GET["unic_uid"];

$check_email = $conn->query("SELECT *FROM `gate_auth` WHERE `has` = '$haskey' ")->num_rows;

if ($check_email == 1) {   


    $res = $conn->prepare("SELECT `status` FROM `gate_auth` WHERE `has` = '$haskey'  ");
    $res->execute();
    $res->bind_result($status);
    while ($res->fetch()) {
        $status = $status;
    }

    $res = $conn->prepare("SELECT `gate_open_time` FROM `gate_auth` WHERE `has` = '$haskey'  ");
    $res->execute();
    $res->bind_result($gate_open_time);
    while ($res->fetch()) {
        $gate_open_time = $gate_open_time;
    }

    $res = $conn->prepare("SELECT `id` FROM `gate_auth` WHERE `has` = '$haskey'  ");
    $res->execute();
    $res->bind_result($id);
    while ($res->fetch()) {
        $id = $id;
    }

    if ($status == "open") {
    
        $data = " `status` = 'close' ";
        $data .= ", `gate_auto_close_time` = '$time' ";
        $update = $conn->query("UPDATE `gate_auth` SET " . $data . " WHERE `has` = '$haskey' ");

        if($update){
            die("1");
        }else{
            die("0");
        }
    }
}