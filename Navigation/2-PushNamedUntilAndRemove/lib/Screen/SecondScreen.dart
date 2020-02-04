import 'package:flutter/material.dart';


class SecondScreen extends StatefulWidget{
  @override
  _SecondScreenState createState()=> new _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>{

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
              new Text("SecondScreen"),
              new RaisedButton(onPressed: ()=>Navigator.of(context).pushNamedAndRemoveUntil("/Third",(Route<dynamic> route)=>false),child: new Text("Next"),),
              new RaisedButton(onPressed: ()=>Navigator.of(context).pushNamedAndRemoveUntil("/Home",(Route<dynamic> route)=>false),child: new Text("Back"),)
            ],
          ),
        ),
      ),
    );
  }
}