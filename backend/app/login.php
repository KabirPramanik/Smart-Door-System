<?php

include("./../db_conn.php");

if (!(isset($_POST["username"]) and isset($_POST["password"]))) {
    die("error");
}

$username = $_POST["username"];
$password = $_POST["password"];

$check_email = $conn->query("SELECT *FROM `auth` WHERE `username` = '$username' AND `password` = '$password' ")->num_rows;

if ($check_email == 1) { 
        die("1");
}else if($check_email>1){
    die("More the one deta available");
}else{
    die("Something else...");
}






