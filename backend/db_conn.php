<?php

$servername = "localhost";
$username = "u483648335_auth_enter_01";
$password = "jdhDD23233@!@Cfd.nf@21dEEauth_enter_01";
$database = "u483648335_skosao_auth";

$servername = "localhost";
$username = "root";
$password = "";
$database = "res_project";

$conn = mysqli_connect($servername, $username, $password, $database);


date_default_timezone_set("Asia/Kolkata");
$time = floor(microtime(true) * 1000);;
// $time = time();

  
  
// function encryptIt($q)
// {
//     $cryptKey  = 'qJB0rGtIn5UB1xG03efyCp';
//     $qEncoded      = base64_encode(mcrypt_encrypt(MCRYPT_RIJNDAEL_256, md5($cryptKey), $q, MCRYPT_MODE_CBC, md5(md5($cryptKey))));
//     return ($qEncoded);
// }

// function decryptIt($q)
// {
//     $cryptKey  = 'qJB0rGtIn5UB1xG03efyCp';
//     $qDecoded      = rtrim(mcrypt_decrypt(MCRYPT_RIJNDAEL_256, md5($cryptKey), base64_decode($q), MCRYPT_MODE_CBC, md5(md5($cryptKey))), "\0");
//     return ($qDecoded);
// }


//     $msg = base64_decode($msg);
// $msg = base64_encode($msg);


// htmlentities($ssss,ENT_QUOTES);
// html_entity_decode($dddd);

// $email = base64_encode(htmlentities($email, ENT_QUOTES));
// $email = html_entity_decode(base64_decode($email));

// $res = $conn->prepare("SELECT id FROM stndetails WHERE id = '25' ");
// $res->execute();
// $res->bind_result($event);
// while ($res->fetch()) {
//     $event = $event;
// }
