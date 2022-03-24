
<?php
$db = "t1c"; //database name
$dbuser = "root"; //database user_login
$dbpassword = ""; //database user_pass
$dbhost = "localhost"; //database host

$return["error"] = false;
$return["message"] = "";
$return["success"] = false;


$hostname = basename($_SERVER['REQUEST_URI']);
$id_user = substr($hostname, strpos($hostname, "=") + 1);

$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);


function RemoveSpecialChar($str)
{

    $res = str_ireplace(array('\'', '"', ',', ';', '<', '>'), ' ', $str);
    $res = iconv(mb_detect_encoding($res, mb_detect_order(), true), "UTF-8", $res);
    return $res;
}

$rows = array();
$offres = array();


$sql_profile = "SELECT DISTINCT `post_id` FROM wp_postmeta WHERE meta_value=" . $id_user . " AND meta_key='_candidate_user_id'";
$sth = mysqli_query($link, $sql_profile);

while ($r = mysqli_fetch_assoc($sth)) {
    $id_post = RemoveSpecialChar($r['post_id']);
    $return["id_post"] = $id_post;
    if ($id_post) {
    
        $count_sql = "SELECT `meta_value` FROM wp_postmeta WHERE post_id=" . $id_post . " AND meta_key='_viewed_count'  ";
        $count_sth = mysqli_query($link, $count_sql);
        //////////
        $_candidate_email_sql = "SELECT `meta_value` FROM wp_postmeta WHERE post_id=" . $id_post . " AND meta_key='_candidate_email'  ";
        $_candidate_email = mysqli_query($link, $_candidate_email_sql);
        
        
        while (($count_r = mysqli_fetch_assoc($count_sth)) && ($candidate_email_r = mysqli_fetch_assoc($_candidate_email))) {
            $return["_candidate_views_count"] = (RemoveSpecialChar($count_r['meta_value']) + 10);
            $return["candidate_email"] = RemoveSpecialChar($candidate_email_r['meta_value']);
        }
    } else {
        $return["error"] = true;
        $return["message"] = "Erreur d'utilisateur";
        $return["success"] = false;
    }
    
}

array_push($offres, $rows);

$numrows = count($return);
if ($numrows > 0) {

    $return["id_user"] = $id_user;
    $return["error"] = false;
    $return["message"] = "job_done";
    $return["success"] = true;
} else {
    $return["error"] = true;
    $return["message"] = "";
    $return["success"] = false;
}




$return["job"] = $offres;




mysqli_close($link);

header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);


//converting array to JSON string
?>

