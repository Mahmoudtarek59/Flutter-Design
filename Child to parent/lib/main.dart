import 'package:flutter/material.dart';
import 'Login.dart';

void main(){
  runApp(new MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  _State createState()=> new _State();
}

class _State extends State<MyApp>{

  String _value="";

  void _onAuthenticated(bool val){
    setState(() {
      _value = val.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Name Here"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text("Hello World"),
              new Login(
                onAuthenticated:_onAuthenticated,),
              new Text(_value)
            ],
          ),
        ),
      ),
    );
  }
}