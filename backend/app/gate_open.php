<?php

include("./../db_conn.php");

if (!(isset($_POST["username"]) and isset($_POST["password"]))) {
    die("error");
}

$username = $_POST["username"];
$password = $_POST["password"];
$position = $_POST["position"];

$check_email = $conn->query("SELECT *FROM `auth` WHERE `username` = '$username' AND `password` = '$password' ")->num_rows;

if ($check_email == 1) { 

    $res = $conn->prepare("SELECT `time` FROM `gate_auth` ORDER BY `id` DESC LIMIT 1 ");
    $res->execute();
    $res->bind_result($this_time);
    while ($res->fetch()) {
        $this_time = $this_time;
    }

    $res = $conn->prepare("SELECT `status` FROM `gate_auth` ORDER BY `id` DESC LIMIT 1 ");
    $res->execute();
    $res->bind_result($status);
    while ($res->fetch()) {
        $status = $status;
    }

    $res = $conn->prepare("SELECT `gate_open_time` FROM `gate_auth` ORDER BY `id` DESC LIMIT 1 ");
    $res->execute();
    $res->bind_result($gate_open_time);
    while ($res->fetch()) {
        $gate_open_time = $gate_open_time;
    }

    $res = $conn->prepare("SELECT `id` FROM `gate_auth` ORDER BY `id` DESC LIMIT 1 ");
    $res->execute();
    $res->bind_result($id);
    while ($res->fetch()) {
        $id = $id;
    }

    if (($status == "create") && ($this_time >= ($time-(1000*60*5)))) {
    
        $data = " `status` = 'open' ";
        $data .= ", `gate_open_by` = '$username' ";
        $data .= ", `gate_open_time` = '$time' ";
        $data .= ", `gate_open_position` = '$position' ";
        $update = $conn->query("UPDATE `gate_auth` SET " . $data . " WHERE `id` = '" . $id  . "' ");

        if($update){
            die("1");
        }else{
            die("Server error...");
        }
    }else{
        die("0");
    }

}else if($check_email>1){
    die("More the one deta available");
}else{
    die("Something else...");
}
