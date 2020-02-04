import 'package:flutter/material.dart';
import './Screen/home.dart';
import './Screen/SecondScreen.dart';
import './Screen/ThirdScreen.dart';
void main()=>runApp(new MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Navigation",
      routes: <String,WidgetBuilder>{
        "/Home":(BuildContext context)=> new Home(),
        "/Second": (BuildContext context) => new SecondScreen(),
        "/Third": (BuildContext context) => new ThirdScreen(),
      },
      home:new Home(),
    );
  }
}