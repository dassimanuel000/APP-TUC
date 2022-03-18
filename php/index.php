
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

function RemoveSpecialChar($str)
{

    // Using str_ireplace() function 
    // to replace the word 
    $res = str_ireplace(array('\'', '"', ',', ';', '<', '>'), ' ', $str);
    $res =iconv(mb_detect_encoding($res, mb_detect_order(), true), "UTF-8", $res);

    // returning the result 
    return $res;
}

if ($userID) {
    $sql = "SELECT * FROM wp_posts WHERE post_author='.$userID.' AND post_type='job_alert' ";
    //building SQL query
    $result_alert = mysqli_query($link, $sql);
    $numrows = mysqli_num_rows($result_alert);

    $filtres = array();
    $category = array();
    $offres = array();
    $location = array();
    $Big_offre = array();
    $rows = array();
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
                    //$tempor_filtre = ;
                    $title_filtre = array();
                    $title_filtre =  [
                        'title_filtre ' =>  $return["job_alert"][$i]["post_title"],
                        'post_modified' => $return["job_alert"][$i]["post_modified"],
                        
                    ];
                    $title_filtre +=json_decode(($row["meta_value"]), true);
                    //array_merge($title_filtre, ($tempor_filtre));
                    array_push($filtres, $title_filtre);
                }
            }
            $return["filtre"] = $filtres;

            /*********************** */

            for ($j = 0; $j < count($filtres); $j++) {
                if (array_key_exists('filter-category', $return["filtre"][$j])) {
                    array_push(
                        $category,
                        $return["filtre"][$j]['filter-category']
                    );
                } else {
                    array_push(
                        $category,
                        null
                    );
                }
                if (array_key_exists('filter-location', $return["filtre"][$j])) {
                    array_push(
                        $location,
                        $return["filtre"][$j]['filter-location']
                    );
                }

                $sql_relation = "SELECT DISTINCT `object_id` FROM wp_term_relationships WHERE term_taxonomy_id=" . $return["filtre"][$j]['filter-category'] . " ";
                $result_relation = mysqli_query($link, $sql_relation);

                if (mysqli_num_rows($result_alert) > 0) {
                    while ($row_relation = mysqli_fetch_assoc($result_relation)) {

                        array_push($Big_offre, $row_relation["object_id"]);
                        $id_offre = $row_relation["object_id"];

                        /********************************************LA VERITE ************ */


                        //$sql = "SELECT `post_title`,`post_modified`  FROM wp_posts WHERE ID=" . $JOBid . "   ";
                        $one_by_sql = "SELECT `post_title`,`post_modified`,`post_name`  FROM wp_posts WHERE ID=" . $row_relation["object_id"] . "   ";
                        $sth = mysqli_query($link, $one_by_sql);
                        /*
                        while ($r = mysqli_fetch_assoc($sth)) {
                            $rows[] = [
                                'date' => $r['post_modified'],
                                'post_title' => $r['post_title'],
                            ];
                        }*/



                        $link_sql = "SELECT DISTINCT `meta_value` FROM wp_postmeta WHERE post_id=" . $row_relation["object_id"] . " AND meta_key='_job_apply_url'  ";
                        //$link_sql = "( SELECT DISTINCT meta_value FROM wp_postmeta WHERE post_id=".$id_offre."  AND meta_key='_job_apply_url') UNION (SELECT DISTINCT post_title,post_modified  FROM wp_posts WHERE ID=".$id_offre." ) ";

                        $link_sth = mysqli_query($link, $link_sql);
                        while (($link_r = mysqli_fetch_assoc($link_sth)) && ($r = mysqli_fetch_assoc($sth))) {
                            //sleep(2);
                            $post_title= (RemoveSpecialChar($r['post_title']));
                            //var_dump($post_title);
                            $rows[] = [
                                'date' => $r['post_modified'],
                                'post_title ' =>  $post_title,
                                'link' => $link_r['meta_value'],
                            ];
                        }
                        //array_push($offres, $rows);
                    }
                } else {
                    # code...
                }


                $return["list_offres"] = $Big_offre;
            }
            $return["category"] = $category;
            $return["location"] = $location;
            $return["job_out_category"] = $rows;

            /*********************** */
        } else {
            $return["error"] = true;
            $return["message"] = 'No job found.';
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

