<?php





function sendNotif ($to, $notif){



    $feilds = array('to'=>$to, 'notification'=>$notif);



    $ch = curl_init();



    curl_setopt($ch, CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send');

    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);

    curl_setopt($ch, CURLOPT_POST, 1);

    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($feilds));

    

    $headers = array();

    $headers[] = 'Authorization: Key= AAAAaupU9yc:APA91bExqSkZEqXaSNXEfdtFtdgOBteO8w2ZDEudoB4XmUtc6vpJmVHYvfAoHGSVxW__83-9rkeWZg_L3_k7YIGUfs7SVea-X4HKxv4sqxL0i1QFCcCJYVBSkMC6MODrWvajX_F4uaWM';

    $headers[] = 'Content-Type: application/json';

    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    

    $result = curl_exec($ch);

    if (curl_errno($ch)) {

        echo 'Error:' . curl_error($ch);

    }else {
        echo("<script>console.log('PHP: " . $ch . "');</script>");
    }

    curl_close($ch);

}



$to = "/topics/news";



$notification = array(

    'title' => "Nouvelle Offres Trouver un candidat !",

    'body' => "A new tournament is ready, Join now or miss out"

);



sendNotif($to, $notification);