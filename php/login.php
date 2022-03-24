<?php

$db = "t1c"; //database name
$dbuser = "root"; //database user_login
$dbpassword = ""; //database user_pass
$dbhost = "localhost"; //database host

$return["error"] = false;
$return["message"] = "";
$return["success"] = false;


$hostname = basename($_SERVER['REQUEST_URI']);
$user_login = substr($hostname, strpos($hostname, "=") + 1);
$user_email = substr($hostname, strpos($hostname, "&") + 1);

$user_login = current(explode("&", $user_login, 2));


$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);


if(isset($user_login) && isset($user_email)){

    $sql = "SELECT * FROM wp_users WHERE user_login = '$user_login'";
    //building SQL query
    $res = mysqli_query($link, $sql);
    $numrows = mysqli_num_rows($res);
    //check if there is any row
    if($numrows > 0){
        //is there is any data with that user_login
        $obj = mysqli_fetch_object($res);
        //get row as object
        if($user_email == $obj->user_email){
            $return["success"] = true;
            $return["uid"] = $obj->ID;
            $return["user_email"] = $obj->user_email;
            $return["user_login"] = $obj->user_login;
        }else{
            $return["error"] = true;
            $return["message"] = "Your user_pass is Incorrect.";
        }
    }else{
        $return["error"] = true;
        $return["message"] = 'No user_login found.';
    }
}else{
   $return["error"] = true;
   $return["message"] = 'Send all parameters.';
}


mysqli_close($link);

header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);


//converting array to JSON string
?>

