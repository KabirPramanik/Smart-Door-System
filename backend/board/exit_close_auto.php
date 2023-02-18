<?php
// auth_close-has
include("./../db_conn.php");


if (!isset($_GET["unic_uid"])) {
    die("error");
}

$haskey = $_GET["unic_uid"];

$check_email = $conn->query("SELECT *FROM `gate_auth` WHERE `has` = '$haskey' ")->num_rows;
if ( $check_email == 1) {   


    $res = $conn->prepare("SELECT `status` FROM `gate_auth` WHERE `has` = '$haskey'  ");
    $res->execute();
    $res->bind_result($status);
    while ($res->fetch()) {
        $status = $status;
    }


    if ($status == "ex-open") {
    
        $data = " `status` = 'ex-close' ";
        $update = $conn->query("UPDATE `gate_auth` SET " . $data . " WHERE `has` = '$haskey' ");

        if($update){
            die("1");
        }else{
            die("0");
        }
    }else if ($status == "ex-close") {
    
        $data = " `status` = 'ex-close' ";
        $update = $conn->query("UPDATE `gate_auth` SET " . $data . " WHERE `has` = '$haskey' ");

        if($update){
            die("1");
        }else{
            die("0");
        }
    }else{
        die("error");
    }
}else{
    die("error...");
}