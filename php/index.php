
<?php
$db = "t1c"; //database name
$dbuser = "root"; //database user_login
$dbpassword = ""; //database user_pass
$dbhost = "localhost"; //database host

$return["error"] = false;
$return["message"] = "";
$return["success"] = false;


$hostname = basename($_SERVER['REQUEST_URI']);
$userID = substr($hostname, strpos($hostname, "=") + 1);

$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);


if ($userID) {
    $sql = "SELECT * FROM wp_posts WHERE post_author='.$userID.' AND post_type='job_alert' ";
    //building SQL query
    $result_alert = mysqli_query($link, $sql);
    $numrows = mysqli_num_rows($result_alert);

    $filtres = array();
    $category = array();
    //check if there is any row
    if ($numrows > 0) {

        $return["error"] = false;
        $return["message"] = "job_done";
        $return["success"] = true;
        $return["job_alert"] = $result_alert->fetch_all(MYSQLI_ASSOC);
        if (count($return) > 2) {
            for ($i = 0; $i < $numrows; $i++) {
                //$return["count".$i] = $return["job_alert"][$i]["ID"];
                //$job_alertID = "";
                //$sql_filtre = "SELECT meta_value FROM wp_postmeta WHERE post_id=" . $return['job_alert'][$i]['ID'] . " AND meta_key='_job_alert_alert_query' ";


                $sql_filtre = "SELECT meta_value FROM wp_postmeta WHERE post_id=" . $return['job_alert'][$i]['ID'] . " AND meta_key='_job_alert_alert_query' ";
                $result_filtre = mysqli_query($link, $sql_filtre);

                while ($row = mysqli_fetch_assoc($result_filtre)) {

                    array_push($filtres, json_decode(($row["meta_value"]), true));
                }

            }
            $return["filtre"] = $filtres;
            
            /*********************** */

            for ($j = 0; $j < count($filtres); $j++ ) {
                array_push($category,
                    $return["filtre"][$j]['filter-category']
                );
                
                $sql_relation = "SELECT object_id FROM wp_term_relationships WHERE term_taxonomy_id=" . $return["filtre"][$j]['filter-category'] . " ";
                $result_relation = mysqli_query($link, $sql_relation);

                while ($row_relation = mysqli_fetch_assoc($result_relation)) {

                    $return["zzzzzzzzfziltre"] = $row_relation;

                }

            }
            $return["category"] = $category;

            /*********************** */
            


        } else {
            $return["error"] = true;
            $return["message"] = 'No user_login found.';
        }
    } else {
        $return["error"] = true;
        $return["message"] = 'No user_login found.';
    }
} else {
    $return["error"] = true;

    $return["message"] = 'Send all parameters.';
}
/*
$Big_offre = array();
$offre = array();


$sql_filtre = "SELECT `object_id` FROM wp_term_relationships WHERE term_taxonomy_id ='1066' ";
$result_filtre = mysqli_query($link, $sql_filtre);

$offre["wp_term_relationships"] = ($result_filtre->fetch_all(MYSQLI_ASSOC));


while ($row = mysqli_fetch_assoc($result_filtre)) {

    $s__ql_link_ = "SELECT `meta_value` FROM wp_postmeta WHERE post_id=" .$row["object_id"] . " AND meta_key='_job_apply_url'  ";
    $__result_link_ = mysqli_query($link, $s__ql_link_);


    //$offre["link"] = ($__result_link_->fetch_all(MYSQLI_ASSOC));
    
    while ($link_row = mysqli_fetch_assoc($__result_link_)) {
        $offre["link"] = $row["meta_value"];
    }
    


    $_ql_filtre = "SELECT `post_content`,`post_title` FROM wp_posts WHERE ID=" .$row["object_id"] . "  ";
    $_result_filtre = mysqli_query($link, $_ql_filtre);
    
    while ($offer_row = mysqli_fetch_assoc($_result_filtre)) {
        $offre["title"] = $row["post_title"];
        $offre["post_content"] = $row["post_content"];
    }
    
    $offre["post_content"] = ($_result_filtre->fetch_all(MYSQLI_ASSOC));

    array_push($Big_offre, $offre);
}



array_push($Big_offre, $offre);
$return["offre"] = $Big_offre;
*/

//array_push($return["filtre"], $result_filtre->fetch_all(MYSQLI_ASSOC));

mysqli_close($link);

header('Content-Type: application/json');
// tell browser that its a json data
echo json_encode($return);
//converting array to JSON string
?>

