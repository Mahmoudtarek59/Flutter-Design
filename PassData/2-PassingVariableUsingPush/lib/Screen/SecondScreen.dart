import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget{

  String name;

  SecondScreen(this.name);
  @override
  _SecondScreenState createState()=> new _SecondScreenState(name);
}

class _SecondScreenState extends State<SecondScreen>{

  String name;

  _SecondScreenState(this.name);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("SecondScreen"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text("Hello ${name}"),
              new RaisedButton(onPressed:()=>Navigator.of(context).pop(),child: new Text("back"),)
            ],
          ),
        ),
      ),
    );
  }
}