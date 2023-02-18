<?php

include("./../db_conn.php");

$time01 = $time - ((5*60*1000)*6);
$time02 = $time - ((5*60*1000)*5);
$time03 = $time - ((5*60*1000)*4);
$time04 = $time - ((5*60*1000)*3);
$time05 = $time - ((5*60*1000)*2);
$time06 = $time - ((5*60*1000)*1);

// $sql = "SELECT * FROM `data` WHERE `time` BETWEEN $time01 AND $time06";

$dataSet = array();

$sql01 = $conn->query("SELECT * FROM `auth` ");
while ($row01=$sql01->fetch_assoc() ){
    
    $timecal02 = 0;
    $timecal03 = 0;
    $timecal04 = 0;
    $timecal05 = 0;
    $timecal06 = 0;
    $timecal07 = 0;
    
    $sql02 = $conn->query("SELECT * FROM `gate_auth` WHERE `gate_open_by` = '".$row['username']."' AND `exit_time` != '0' AND  `gate_open_time` BETWEEN $time05 AND $time06 ");
    while ($row02= $sql02->fetch_assoc() ){
        $timecal02 += ($row02["exit_time"]-$row02["gate_open_time"])/1000;
    }

    $sql03 = $conn->query("SELECT * FROM `gate_auth` WHERE `gate_open_by` = '".$row['username']."' AND `exit_time` != '0' AND  `gate_open_time` BETWEEN $time04 AND $time05 ");
    while ($row03= $sql03->fetch_assoc() ){
        $timecal03 += ($row03["exit_time"]-$row03["gate_open_time"])/1000;
    }


    $sql04 = $conn->query("SELECT * FROM `gate_auth` WHERE `gate_open_by` = '".$row['username']."' AND `exit_time` != '0' AND  `gate_open_time` BETWEEN $time03 AND $time04 ");
    while ($row04= $sql04->fetch_assoc() ){
        $timecal04 += ($row04["exit_time"]-$row04["gate_open_time"])/1000;
    }


    $sql05 = $conn->query("SELECT * FROM `gate_auth` WHERE `gate_open_by` = '".$row['username']."' AND `exit_time` != '0' AND  `gate_open_time` BETWEEN $time02 AND $time03 ");
    while ($row05=$sql05->fetch_assoc()){
        $timecal05 += ($row05["exit_time"]-$row05["gate_open_time"])/1000;
    }


    $sql06 = $conn->query("SELECT * FROM `gate_auth` WHERE `gate_open_by` = '".$row['username']."' AND `exit_time` != '0' AND  `gate_open_time` BETWEEN $time01 AND $time02 ");
    while ($row06=$sql06->fetch_assoc() ){
        $timecal06 += ($row06["exit_time"]-$row06["gate_open_time"])/1000;
    }


    $sql07 = $conn->query("SELECT * FROM `gate_auth` WHERE `gate_open_by` = '".$row['username']."' AND `exit_time` != '0' AND  `gate_open_time` BETWEEN $time AND $time01 ");
    while ($row07=$sql07->fetch_assoc() ){
        $timecal07 += ($row07["exit_time"]-$row07["gate_open_time"])/1000;
    }


    $dataSetValue[] = array(
        "label" => $row01['username'],
        "data" => array($timecal02, $timecal03, $timecal04, $timecal05, $timecal06, $timecal07),
        "fill" => false,
        "borderColor" => "rgb(".rand(0,255).", ".rand(0,255).", ".rand(0,255).")",
        "lineTension" => 0.1
    );
    array_push($dataSet,$dataSetValue);

}
die(json_encode($dataSet)) ;

