<?php

$db = "tuc"; //database name
$dbuser = "root"; //database user_login
$dbpassword = ""; //database user_pass
$dbhost = "localhost"; //database host

$return["error"] = false;
$return["message"] = "";
$return["success"] = false;

$rows = array();

function clean($string)
{
    $string = str_replace('wp:paragraph', '', $string); // Replaces all spaces with hyphens.
    //$string = preg_replace('/[^A-Za-z0-9\-]/', '', $string); // Removes special chars.
    $string = str_ireplace( array( '\'', '<', '>','/p','%20','- \/' ), ' ', $string);
    $string = str_replace('-   -', ' ', $string);
    $string = str_replace('!-  - \n p', ' ', $string);
    $string = str_replace('!-', ' ', $string);
    $string = str_replace('-  -', ' ', $string);
    $string = str_replace(' p ', ' ', $string);
    $string = str_replace('- / -', ' ', $string);
    

    $string = preg_replace('@<(\w+)\b.*?>.*?</\1>@si', ' ', $string);

    return preg_replace('/-+/', '-', $string); // Replaces multiple hyphens with single one.
}

$hostname = basename($_SERVER['REQUEST_URI']);
$keyword = substr($hostname, strpos($hostname, "=") + 1);

$keyword = urldecode($keyword);
$keyword = str_replace("'", " ", $keyword);

$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);


$query = "SELECT `ID`, `post_title`,`post_modified`,`post_content` FROM `wp_posts` WHERE `post_title` LIKE '%{$keyword}%' AND post_type='job_listing' ORDER BY `post_modified` DESC ";
$result = mysqli_query($link, $query) or die(mysqli_error($link));
$flag = FALSE;
while ($row = mysqli_fetch_array($result, MYSQLI_BOTH)) {
    $link_sql = "SELECT DISTINCT `meta_value` FROM wp_postmeta WHERE post_id=" . $row["ID"] . " AND meta_key='_job_apply_url'  ";
    $result_link = mysqli_query($link, $link_sql) or die(mysqli_error($link));
    while ($r_link = mysqli_fetch_array($result_link, MYSQLI_BOTH)) {

        $rows[] = [
            'ID ' =>  clean($row['ID']),
            'date' => date('d F Y ', strtotime($row['post_modified'])),
            'post_title ' =>  clean($row['post_title']),
            'post_content' => clean(strip_tags($row['post_content'])),
            'link' => strip_tags($r_link['meta_value']),
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
?>