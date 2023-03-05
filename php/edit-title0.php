<?php
  $db = "t1c"; //database name
  $dbuser = "root"; //database user_login
  $dbpassword = "mjuZzV54gv2EMJG7789e"; //database user_pass
  $dbhost = "mariadb-mastert1c"; //database host

$return["error"] = false;
$return["message"] = "";
$return["success"] = false;


$hostname = basename($_SERVER['REQUEST_URI']);

$id_user = substr($hostname, strpos($hostname, "=") + 1);

$link = mysqli_connect($dbhost, $dbuser, $dbpassword, $db);


$rows = array();
$offres = array();


//$sql_profile = "SELECT DISTINCT `meta_value` FROM wp_postmeta WHERE post_id=" . $id_user . " AND meta_key='_candidate_display_name'";

$sql_profile = "SELECT  `post_title` FROM wp_posts WHERE ID=" . $id_user . "";
$sth = mysqli_query($link, $sql_profile);

//echo var_dump($sth);
 
while ($r = mysqli_fetch_assoc($sth)) {
 
    $subject=$r['post_title'];
    echo $subject.'\n';
    
	$pattern='/\b([A-Z]+)\b/';
	//$pattern = "\b\p{Lu}{2,}(?:\s*\p{Lu}{2,})\b";
    if (preg_match($pattern, $subject, $match)){
        $subject = $match[0];
        $new_subject = $match[0][0].'.';


        if (strlen($subject) < 3) {
           return false;
        }else {
                

        echo $match[0];
        echo ' -------------------------        '.$new_subject;
        $update_table = "UPDATE `wp_postmeta` set meta_value = replace(meta_value, '" . $subject . "', '" . $new_subject . "') WHERE post_id='" . $id_user . "' ";
        $sth = mysqli_query($link, $update_table);
        
        $update_table = "UPDATE `wp_posts` set post_content = replace(post_content, '" . $subject . "', '" . $new_subject . "') WHERE ID='" . $id_user . "' ";
        $sth = mysqli_query($link, $update_table);
        $update_table = "UPDATE `wp_posts` set post_title = replace(post_title, '" . $subject . "', '" . $new_subject . "') WHERE ID='" . $id_user . "' ";
        $sth = mysqli_query($link, $update_table);
        if(true){
            echo '555555555555555555';
        	}
	}
    } else{
        echo 'MEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE';
    }

}
mysqli_close($link);

// tell browser that its a json data
echo json_encode($return);


//converting array to JSON string
?>

