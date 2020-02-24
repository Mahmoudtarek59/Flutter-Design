import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Home.dart';
import './signup.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
void main() {
  runApp(new MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  String message;
  MyApp({Key key,this.message}):super(key:key);
  @override
  _State createState() => new _State(message: message);
}

class _State extends State<MyApp> {
  String message;
  _State({Key key,this.message});

  final GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _email;
  String _password;


  @override
  void initState() {
    super.initState();
    if(message!=null) {
      print(message);
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          _scaffoldKey.currentState.showSnackBar(
            new SnackBar(content: new Text('$message')),
          ));
  }
  }

  void _login() async {
    final formData = _globalKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: _email, password: _password)).user;

        assert(user != null);

        print(user.email);
        //navigator
        if(user.isEmailVerified){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => new Home(
                  user: user,
                )));
        }else{
          _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Please check you email and verify your account !!")));
        }
      } catch (e) {
        //Go to sign Up
        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("Sign Up now ")));
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>new Signup()));
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new SingleChildScrollView(
          child: new Form(
            key: _globalKey,
            child: new Container(
              child: new Column(
                children: <Widget>[
                  new SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: new FlutterLogo(
                      size: 250,
                      style: FlutterLogoStyle.horizontal,
                    ),
                  ),
                  new TextFormField(
                    decoration: InputDecoration(
                      icon: new Icon(Icons.email),
                      hintText: "Email Address",
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'enter your email';
                      }
                    },
                    onSaved: (val) => _email = val,
                  ),
                  new TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: new Icon(Icons.security), hintText: "Password"),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'enter you password';
                      }
                    },
                    onSaved: (val) => _password = val,
                  ),
                  new SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: new Padding(
                      padding: new EdgeInsets.only(top: 10),
                      child: new RaisedButton(
                        onPressed: _login,
                        child: new Text("Login"),
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                  new SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: new Padding(
                      padding: new EdgeInsets.only(top: 10),
                      child: new RaisedButton(
                        onPressed: ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>new Signup())),
                        child: new Text("Sign Up"),
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
