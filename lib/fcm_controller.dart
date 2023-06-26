import 'dart:convert';

import 'package:http/http.dart' as http;

sendNotificationCall(String token, String? title, String body) async {
  http.Response response = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAMtiT2IA:APA91bEHqOn4hWzdZVuLS6NazF9Y6RxW5o6mGdHGD1MPkJ7hm_mnH3gimkAFy'
              'Hh-Duna6cBBELy2t3wp3tZlIYy3gCgzjQ1GZaPP6sgo_l5_NToGmtmIrTtzgD2yTKs767mtev1FJULa',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{'body': title, 'title': body},
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
          'route': '/notification_screen',
        },
        'to': token
      },
    ),
  );
}

sendNotificationCallTopicBase(String topic, String? title, String body) async {
  http.Response response = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
      'key=AAAAMtiT2IA:APA91bEHqOn4hWzdZVuLS6NazF9Y6RxW5o6mGdHGD1MPkJ7hm_mnH3gimkAFyHh-'
          'Duna6cBBELy2t3wp3tZlIYy3gCgzjQ1GZaPP6sgo_l5_NToGmtmIrTtzgD2yTKs767mtev1FJULa',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{'body': body, 'title': title},
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
          'route': '/notification_screen',
        },
        'to': "/topics/$topic"
      },
    ),
  );

  print(response.statusCode);
}
