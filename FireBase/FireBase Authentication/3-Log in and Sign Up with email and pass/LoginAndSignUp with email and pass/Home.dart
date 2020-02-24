import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './main.dart';

class Home extends StatelessWidget{
  final FirebaseUser user;

  Home({Key key,this.user}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text(user.email,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
              new RaisedButton(onPressed:(){
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>new MyApp()));
              },child: new Text("Sign out"),)
            ],
          ),
        ),
      ),
    );
  }
}