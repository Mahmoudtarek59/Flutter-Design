import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';


NotificationDetails get _ongoing {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel description',
    importance: Importance.Max,
    priority: Priority.High,
    ongoing: false,//removable
    autoCancel: true,//when clicked it canceled
  );
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}


Future _showNotification(
    FlutterLocalNotificationsPlugin notifications, {
      @required String title,
      @required String body,
      @required NotificationDetails type,
      int id = 0,
    }) =>
    notifications.show(id, title, body, type);


Future showOngoingNotification(
    FlutterLocalNotificationsPlugin notifications, {
      @required String title,
      @required String body,
      int id = 0,
    }) =>
    _showNotification(notifications,
        title: title, body: body, id: id, type: _ongoing);
