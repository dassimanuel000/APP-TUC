<?php /*
function sendFCM() {
  // FCM API Url
  $url = 'https://fcm.googleapis.com/fcm/send';

  // Put your Server Key here
  $apiKey = "AAAAaupU9yc:APA91bExqSkZEqXaSNXEfdtFtdgOBteO8w2ZDEudoB4XmUtc6vpJmVHYvfAoHGSVxW__83-9rkeWZg_L3_k7YIGUfs7SVea-X4HKxv4sqxL0i1QFCcCJYVBSkMC6MODrWvajX_F4uaWM";

  // Compile headers in one variable
  $headers = array (
    'Authorization:key=' . $apiKey,
    'Content-Type:application/json'
  );

  // Add notification content to a variable for easy reference
  $notifData = [
    'title' => "Test Title",
    'body' => "Test notification body",
    //  "image": "url-to-image",//Optional
    'click_action' => "activities.NotifHandlerActivity" //Action/Activity - Optional
  ];

  $dataPayload = ['to'=> 'My Name', 
  'points'=>80, 
  'other_data' => 'This is extra payload'
  ];

  // Create the api body
  $apiBody = [
    'notification' => $notifData,
    'data' => $dataPayload, //Optional
    'time_to_live' => 600, // optional - In Seconds
    //'to' => '/topics/mytargettopic'
    //'registration_ids' = ID ARRAY
    'to' => 'cc3y906oCS0:APA91bHhifJikCe-6q_5EXTdkAu57Oy1bqkSExZYkBvL6iKCq2hq3nrqKWymoxfTJRnzMSqiUkrWh4uuzzEt3yF5KZTV6tLQPOe9MCepimPDGTkrO8lyDy79O5sv046-etzqCGmKsKT4'
  ];

  // Initialize curl with the prepared headers and body
  $ch = curl_init();
  curl_setopt ($ch, CURLOPT_URL, $url);
  curl_setopt ($ch, CURLOPT_POST, true);
  curl_setopt ($ch, CURLOPT_HTTPHEADER, $headers);
  curl_setopt ($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt ($ch, CURLOPT_POSTFIELDS, json_encode($apiBody));

  // Execute call and save result
  $result = curl_exec($ch);
  print($result);
  
  try {
    //check if
    if($result) {
        // Close curl after call
        curl_close($ch);
      
        return $result;
    }
  }
  
  catch (customException $e) {
    //display custom message
    echo $e->errorMessage();
  }

}

sendFCM();

function sendGCM() {
  $serverKey = "AAAAaupU9yc:APA91bExqSkZEqXaSNXEfdtFtdgOBteO8w2ZDEudoB4XmUtc6vpJmVHYvfAoHGSVxW__83-9rkeWZg_L3_k7YIGUfs7SVea-X4HKxv4sqxL0i1QFCcCJYVBSkMC6MODrWvajX_F4uaWM";
  $notification = array();
  $notification = ["title" => "This is notification title",    "body" => "This is notification text",    "alert" => "Test Push Message",    "sound" => "default",];
  $data = ["title" => "This is notification title",    "body" => "This is notification text",    "priority" => "high",    "content_available" => true];
  $fcmNotification = ["to" => "/topics/alerts",    "notification" => $notification,    "data" => $data,    "priority" => 10];
  $headers = ['Authorization: key=' . $serverKey,    'Content-Type: application/json'];

  $fcmUrl = 'https://fcm.googleapis.com/fcm/send';
  $cRequest = curl_init();
  curl_setopt($cRequest, CURLOPT_URL, $fcmUrl);
  curl_setopt($cRequest, CURLOPT_POST, true);
  curl_setopt($cRequest, CURLOPT_HTTPHEADER, $headers);
  curl_setopt($cRequest, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($cRequest, CURLOPT_SSL_VERIFYPEER, false);
  curl_setopt($cRequest, CURLOPT_POSTFIELDS, json_encode($fcmNotification));
  $result = curl_exec($cRequest);
  curl_close($cRequest);
  if ($result) {
    echo $result;
  } else {
    echo $result.'ERRRORRRR ';
  }
  
}

sendGCM();*/


  // sending push message to single user by firebase reg id
  function send($to, $message) {
      $fields = array(
          'to' => $to,
          'data' => $message,
      );
      return sendPushNotification($fields);
  }

  // Sending message to a topic by topic name
  function sendToTopic($to, $message) {
      $fields = array(
          'to' => '/topics/' . $to,
          'data' => $message,
      );
      return sendPushNotification($fields);
  }

  // sending push message to multiple users by firebase registration ids
  function sendMultiple($registration_ids, $message) {
      $fields = array(
          'to' => $registration_ids,
          'data' => $message,
      );

      return sendPushNotification($fields);
  }

  // function makes curl request to firebase servers
  function sendPushNotification($fields) {
       

    
  $FIREBASE_API_KEY = "AAAAaupU9yc:APA91bExqSkZEqXaSNXEfdtFtdgOBteO8w2ZDEudoB4XmUtc6vpJmVHYvfAoHGSVxW__83-9rkeWZg_L3_k7YIGUfs7SVea-X4HKxv4sqxL0i1QFCcCJYVBSkMC6MODrWvajX_F4uaWM";
 
      // Set POST variables
      $url = 'https://fcm.googleapis.com/fcm/send';

      $headers = array(
          'Authorization: key=' . $FIREBASE_API_KEY,
          'Content-Type: application/json'
      );
      // Open connection
      $ch = curl_init();

      // Set the url, number of POST vars, POST data
      curl_setopt($ch, CURLOPT_URL, $url);

      curl_setopt($ch, CURLOPT_POST, true);
      curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
      curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

      // Disabling SSL Certificate support temporarly
      curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

      curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));

      // Execute post
      $result = curl_exec($ch);
      if ($result === FALSE) {
          die('Curl failed: ' . curl_error($ch));
      }else {
        die('Error'.json_encode($ch));
      }

      // Close connection
      curl_close($ch);

      return $result;
  }


  send("topics/news", "ERRRRRRRRRRE")

?>