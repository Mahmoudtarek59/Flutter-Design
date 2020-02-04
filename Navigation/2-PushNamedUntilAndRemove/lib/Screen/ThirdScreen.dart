import 'package:flutter/material.dart';


class ThirdScreen extends StatefulWidget{
  @override
  _ThirdScreenState createState()=> new _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ThirdScreen"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text("ThirdScreen"),
              new RaisedButton(onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil("/Second",(Route<dynamic> route)=>false),child: new Text("Back"),)
            ],
          ),
        ),
      ),
    );
  }
}