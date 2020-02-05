import 'package:flutter/material.dart';
import './Screen/home.dart';
import './Screen/SecondScreen.dart';

void main()=>runApp(new MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "navigation",
      routes: <String,WidgetBuilder>{
        "/Home":(BuildContext context)=>new Home(),
        "/Second":(BuildContext context)=>new SecondScreen(),
      },
      home: new Home(),
    );
  }
}