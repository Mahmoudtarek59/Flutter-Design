import 'package:flutter/material.dart';
import '../code/GlobalState.dart';
class SecondScreen extends StatefulWidget{
  @override
  _SecondScreenState createState()=> new _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>{
  
  GlobalState global=GlobalState.instance;
  
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
              new Text("Hello ${global.get("name")}"),
              new RaisedButton(onPressed:()=>Navigator.of(context).pop(),child: new Text("back"),)
            ],
          ),
        ),
      ),
    );
  }
}