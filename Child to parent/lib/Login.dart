import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  Login({Key key,this.onAuthenticated});
  final ValueChanged<bool> onAuthenticated;
  @override
  _LoginState createState() => new _LoginState(onAuthenticated: onAuthenticated);
}

class _LoginState extends State<Login> {

  _LoginState({Key key,this.onAuthenticated});
  TextEditingController _user;
  TextEditingController _pass;
  final ValueChanged<bool> onAuthenticated;


  @override
  void initState() {
    _user = new TextEditingController();
    _pass = new TextEditingController();
  }

  void _onPressed(){
    if(_user.text != "user" || _pass.text != "12345" ){
      onAuthenticated(false);
    }else{
      onAuthenticated(true);
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Padding(
          padding: new EdgeInsets.all(15.0),
          child: new Column(
            children: <Widget>[
              new TextField(
                  decoration: new InputDecoration(
                    icon: new Icon(Icons.person),
                    labelText: "Username",
                    hintText: "Username",
                  ),
                  textInputAction: TextInputAction.next,
                  controller: _user,
                ),
              new TextField(
                decoration: new InputDecoration(
                  icon: new Icon(Icons.person),
                  labelText: "Password",
                  hintText: "Password",
                ),
                textInputAction: TextInputAction.done,
                controller: _pass,
                obscureText: true,
              ),
              new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new RaisedButton(onPressed: _onPressed,child: new Text('Login'),),
              )
            ],
          ),
      ),
    );
  }
}
