//@dart=2.9

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
      static List<String> lines = [];

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      int id, String title, String body, int seconds) async {
        
        await flutterLocalNotificationsPlugin.show(
      
      id,
      title,
      body,
      
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'main_channel', 'Main Channel', 'Main channel notifications',
            groupKey: 'notificationGroup',
            importance: Importance.max,
            priority: Priority.high,
            icon: 'ic_launcher', 
            
            
         
            ),
        
      ),
    );
    print("before active notification");
    
            print("before if active notification");
   // if ( number.num>=2 ) {
      
         lines.add(title);
         lines.forEach((element) {
           print(element);
         });
         
        
           
         
       InboxStyleInformation inboxStyleInformation = InboxStyleInformation(lines,
          contentTitle: " new posts",
          summaryText: "new posts");
      AndroidNotificationDetails groupnotificationDetails =
          AndroidNotificationDetails(
              'main_channel', 'Main Channel', 'Main channel notifications',
              groupKey: 'notificationGroup',
              styleInformation: inboxStyleInformation,
              setAsGroupSummary: true,
              
              
             );

      NotificationDetails groupNotificationDetailsPlatformSpecifics =
          NotificationDetails(
        android: groupnotificationDetails,
        
      ); 
      

      print("before show the important group one");
      await flutterLocalNotificationsPlugin.show(
          0, '', '',groupNotificationDetailsPlatformSpecifics);
   // }
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
