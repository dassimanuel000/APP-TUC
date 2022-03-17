
<?php
$db = "t1c"; //database name
$dbuser = "root"; //database user_login
$dbpassword = ""; //database user_pass
$dbhost = "localhost"; //database host

$return["error"] = false;
$return["message"] = "";
$return["success"] = false;


$hostname = basename($_SERVER['REQUEST_URI']);
$JOBid = substr($hostname, strpos($hostname, "=") + 1);

$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);


$rows = array();
$offres = array();


    $sql = "SELECT `post_title`,`post_modified`  FROM wp_posts WHERE ID=" . $JOBid . "   ";
    $sth = mysqli_query($link, $sql);
    $____rows = array();
    while ($r = mysqli_fetch_assoc($sth)) {
        $rows['date'] = $r['post_modified'];
        $rows['post_title'] = $r['post_title'];
    }


    $link_sql = "SELECT `meta_value` FROM wp_postmeta WHERE post_id=" . $JOBid . " AND meta_key='_job_apply_url'  ";
    $link_sth = mysqli_query($link, $link_sql);
    while ($link_r = mysqli_fetch_assoc($link_sth)) {
        $rows['link'] = $link_r['meta_value'];
    }
    array_push($offres, $rows);

$numrows = count($return);
if ($numrows > 0) {

    $return["error"] = false;
    $return["message"] = "job_done";
    $return["success"] = true;
} else {
    $return["error"] = false;
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

