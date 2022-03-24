<?php

$db = "t1c"; //database name
$dbuser = "root"; //database user_login
$dbpassword = ""; //database user_pass
$dbhost = "localhost"; //database host

$return["error"] = false;
$return["message"] = "";
$return["success"] = false;

$rows = array();
$rox = array();

function RemoveSpecialChar($str)
{

    // Using str_ireplace() function 
    // to replace the word 
    $res = str_ireplace(array('\'', '"', ',', ';', '<', '>'), ' ', $str);
    $res =iconv(mb_detect_encoding($res, mb_detect_order(), true), "UTF-8", $res);

    // returning the result 
    return $res;
}


$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db); 

$query = "SELECT `id`,`title`,`created`,`page`,`object_id` FROM wp_rank_math_analytics_objects WHERE `object_subtype`='post' ORDER BY `created` DESC ";
$result = mysqli_query($link, $query) or die(mysqli_error($link));

$rox["news"] = ($result->fetch_all(MYSQLI_ASSOC));
//while ($row = mysqli_fetch_array($result, MYSQLI_BOTH)) {


    for ($i=0; $i < count($rox["news"]); $i++) { 
        $link_sql = "SELECT `post_title`,`post_modified` FROM wp_posts WHERE ID=" . $rox["news"][$i]['object_id'] . " AND post_type='post'  ";
        $result_link = mysqli_query($link, $link_sql) or die(mysqli_error($link));

        ///////////
        
        $attachment_sql = "SELECT `guid` FROM wp_posts WHERE post_parent=" . $rox["news"][$i]['object_id'] . " AND post_type='attachment'  ";
        $result_attachment_ = mysqli_query($link, $attachment_sql) or die(mysqli_error($link));

        $numrows = mysqli_num_rows($result_link);
        while (($r_link = mysqli_fetch_array($result_link, MYSQLI_BOTH)) && ($r_attachment = mysqli_fetch_array($result_attachment_, MYSQLI_BOTH))) {
            $_title = (RemoveSpecialChar($rox["news"][$i]['title'])); 
            $_title = iconv('utf-8', 'ascii//TRANSLIT', $_title);
                $rows[] = [
                    'ID' =>  $rox["news"][$i]['object_id'],
                    'date' => date('d F Y ', strtotime($r_link['post_modified'])),
                    '_title' =>  $_title,
                    'link' => "https://trouver-un-candidat.com".strip_tags($rox["news"][$i]['page']),
                    'img' => $r_attachment['guid'],
                ];
        }
    }

   
if (count($rows) > 1) {
    $return["error"] = false;
    $return["message"] = "job_done";
    $return["success"] = true;
} else {
    $return["error"] = true;
    $return["message"] = "Aucune offre trouvé";
    $return["success"] = false;
}



$return["news"] = $rows;

mysqli_close($link);

header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);


//converting array to JSON string
