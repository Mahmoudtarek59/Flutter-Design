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
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  final GlobalKey<FormState> _globalKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  void _login() async {
    final formData = _globalKey.currentState;
    if (formData.validate()) {
      formData.save();
      try {
        FirebaseUser user = (await _auth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .user;

        assert(user != null);

        print(user.email);
        //navigator
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => new Home(
                  user: user,
                )));
      } catch (e) {
        //Go to sign Up
        //TODO add snack bar here to inform user
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>new Signup()));
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
