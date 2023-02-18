<?php

include("./../db_conn.php");

if (!(isset($_POST["username"]) and isset($_POST["password"]))) {
    die("error");
}

$username = $_POST["username"];
$password = $_POST["password"];

$check_email = $conn->query("SELECT *FROM `auth` WHERE `username` = '$username' AND `password` = '$password' ")->num_rows;

if ($check_email == 1) { 
    
    $res = $conn->prepare("SELECT `status` FROM `gate_auth`  WHERE `gate_open_by` = '$username' ORDER BY `id` DESC LIMIT 1 ");
    $res->execute();
    $res->bind_result($status);
    while ($res->fetch()) {
        $status = $status;
    }
    
    
    if($status == "open"){
        die("2");
    }else if($status == "close"){
        die("3");
    }else if($status == "ex-open"){
        die("4");
    }else {
        
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
    
        if (($status == "create") && ($this_time >= ($time-(1000*60*5)))) {
            die("1");
        }else{
            
            die("0");
            
        }
    }

}else if($check_email>1){
    die("More the one deta available");
}else{
    die("Something else...");
}
