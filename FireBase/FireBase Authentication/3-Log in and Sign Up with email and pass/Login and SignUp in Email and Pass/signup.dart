import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Home.dart';
import './main.dart';

final FirebaseAuth _auth=FirebaseAuth.instance;
class Signup extends StatefulWidget {
  @override
  _signState createState() => new _signState();
}

class _signState extends State<Signup> {
  String _username,_email,_password;
  final GlobalKey<FormState> _formState=new GlobalKey<FormState>();


  void _sign() async{
    final _formData=_formState.currentState;
    if(_formData.validate()){
      _formData.save();
      try{
        final FirebaseUser user= (await _auth.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        assert(user != null);
        assert(await user.getIdToken()!=null);
        print(user.email);

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => new Home(user:user),));
      }catch(e){
        print(e);
        //already have an account
        //TODO add snack bar here to inform user
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => new MyApp(),));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.all(30.0),
        child:  new SingleChildScrollView(
          child: new Form(
            key: _formState,
            child: new Column(
              children: <Widget>[
                new SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: new FlutterLogo(
                    size: 150,
                    style: FlutterLogoStyle.horizontal,
                  ),
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    icon: new Icon(Icons.person),
                    hintText: "Full name",
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your name";
                    }
                  },
                  onSaved: (val)=>_username=val,
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
                      onPressed: _sign,
                      child: new Text("SignUp"),
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
