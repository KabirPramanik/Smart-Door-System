<?php

include("./../db_conn.php");


$check_email = $conn->query("SELECT *FROM `gate_auth` WHERE `status` = 'ex-open' ")->num_rows;

if ($check_email > 0) {   

    $res = $conn->prepare("SELECT `has` FROM `gate_auth` WHERE `status` = 'ex-open' ");
    $res->execute();
    $res->bind_result($has);
    while ($res->fetch()) {
        $has = $has;
    } 
    die($has);
}else{
    die("error");
}