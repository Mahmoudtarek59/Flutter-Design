import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './SecondPage.dart';
import './local_notications_helper.dart';

void main(){
  runApp(
    new MaterialApp(
      home: MyApp(),
    ));
}

class MyApp extends StatefulWidget{

  @override
  _State createState() => new _State();
}

class _State extends State<MyApp>{

  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();


    final settingsAndroid = AndroidInitializationSettings('app_icon');//for android notification
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => onSelectNotification(payload));//for IOS notification

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification,);
  }

  Future onSelectNotification(String payload)  =>  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => new SecondPage(payload: payload)),
  );//when click on notification move to second page

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Name Here"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              title('Basics'),
              RaisedButton(
                child: Text('Show notification'),
                onPressed: () => showOngoingNotification(notifications, title: 'Tite', body: 'Body'),
              ),
            ],
          ),
        ),
      ),
    );

  }
  Widget title(String text) => Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Text(
      text,
      style: Theme.of(context).textTheme.title,
      textAlign: TextAlign.center,
    ),
  );
}