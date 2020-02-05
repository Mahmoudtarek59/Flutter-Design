import 'package:flutter/material.dart';
import '../code/GlobalState.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState()=> new _HomeState();
}

class _HomeState extends State<Home>{

  TextEditingController _name;

  GlobalState _globalState =GlobalState.instance;

  @override
  void initState() {
    _name =new TextEditingController();
  }

  void _onpressed(){

    setState(() {
      _globalState.set("name",_name.text);
    });
    Navigator.of(context).pushNamed("/Second");
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(
                  labelText: "Your Name",
                  hintText: "Enter your name"
                ),
                controller: _name,
                autocorrect: true,
                autofocus: true,
              ),
              new RaisedButton(onPressed:_onpressed,child: new Text("next"),),
            ],
          ),
        ),
      ),
    );
  }
}