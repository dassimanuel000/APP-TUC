<?php
  $db = "t1c"; //database name
  $dbuser = "root"; //database user_login
  $dbpassword = "mjuZzV54gv2EMJG7789e"; //database user_pass
  $dbhost = "mariadb-mastert1c"; //database host

$return["error"] = false;
$return["message"] = "";
$return["success"] = false;


$hostname = basename($_SERVER['REQUEST_URI']);

$category = substr($hostname, strpos($hostname, "=") + 1);
$location = substr($hostname, strpos($hostname, "&") + 1);

$category = current(explode("&", $category, 2));

//echo $location."*".$category;

$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);


$rows = array();
$offres = array();
$Big_offre = array();


function RemoveSpecialChar($str)
{

    // Using str_ireplace() function 
    // to replace the word 
    $res = str_ireplace(array('\'', '"', ',', ';', '<', '>'), ' ', $str);
    $res =iconv(mb_detect_encoding($res, mb_detect_order(), true), "UTF-8", $res);

    // returning the result 
    return $res;
}

$sql_category = "SELECT DISTINCT `object_id` FROM wp_term_relationships WHERE term_taxonomy_id=" . $category . "  ";
//$sql = "SELECT `post_title`,`post_modified`  FROM wp_posts WHERE ID=" . $JOBid . "   ";
$sth = mysqli_query($link, $sql_category);

while ($r = mysqli_fetch_assoc($sth)) {

    $sql_location = "SELECT DISTINCT `object_id` FROM wp_term_relationships WHERE object_id=" . $r['object_id'] . " AND term_taxonomy_id=" . $location . "  ";
    $sth_location = mysqli_query($link, $sql_location);

    while ($r_location = mysqli_fetch_assoc($sth_location)) {
        $rows['ID'] = $r_location['object_id'];
        array_push($offres, $rows);

        $offre_sql = "SELECT `post_title`,`post_modified`,`post_name`  FROM wp_posts WHERE ID=" . $r_location["object_id"] . "   ";
        $offre_sth = mysqli_query($link, $offre_sql);
    

        $link_sql = "SELECT DISTINCT `meta_value` FROM wp_postmeta WHERE post_id=" . $r_location["object_id"] . " AND meta_key='_job_apply_url'  ";
    
        $link_sth = mysqli_query($link, $link_sql);
        while (($link_r = mysqli_fetch_assoc($link_sth)) && ($offre_r = mysqli_fetch_assoc($offre_sth))) {
            //sleep(2);
            $post_title = (RemoveSpecialChar($offre_r['post_title']));
            //var_dump($post_title);
            $Big_offre[] = [
                'date' => $offre_r['post_modified'],
                'post_title ' =>  $post_title,
                'link' => $link_r['meta_value'],
            ];
        }
    }
}


/*
    /*$link_sql = "SELECT `meta_value` FROM wp_postmeta WHERE post_id=" . $JOBid . " AND meta_key='_job_apply_url'  ";
    $link_sth = mysqli_query($link, $link_sql);
    while ($link_r = mysqli_fetch_assoc($link_sth)) {
        $rows['link'] = $link_r['meta_value'];
    }

*/
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



$return["category"] = $category;

$return["location"] = $location;
$return["listes"] = $offres;
$return["job"] = $Big_offre;




mysqli_close($link);

header('Content-Type: application/json');


echo json_encode($return);
//converting array to JSON string
?>

