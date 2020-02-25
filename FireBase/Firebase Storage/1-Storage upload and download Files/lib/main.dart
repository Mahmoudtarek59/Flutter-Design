import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert' show utf8;
import './storage.dart' as fbStorage;
import 'package:path/path.dart'; //needed for basename
import 'dart:async';
import 'dart:io';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app=await FirebaseApp.configure(
      name: 'firebaseApp',//project name in firebase
      options: FirebaseOptions(
        googleAppID: "1:615625363396:android:844d57ce9f50b831665e91",//mobilesdk_app_id
        gcmSenderID: "615625363396",//project_number
        apiKey: "AIzaSyCV-N3esHs5B4eRnzYkSLId44LCCjXVBgk",//api_key
        projectID:"fir-app-c4040",//project_id
        //databaseURL: "https://fir-app-c4040.firebaseio.com",//firebase_url
      ));

  final FirebaseStorage storage= new FirebaseStorage(
      app: app,
      storageBucket:'gs://fir-app-c4040.appspot.com'//Storage_url from firebase
  );
  runApp(new MaterialApp(
    home: MyApp(storage:storage),
  ));
}

class MyApp extends StatefulWidget{
  MyApp({this.storage});
  final FirebaseStorage storage;
  @override
  _State createState()=> new _State(storage: storage);
}

class _State extends State<MyApp>{
  _State({this.storage});
  final FirebaseStorage storage;

  String _status;
  String _location;


  @override
  void initState() {
    _status ="NoData";
    _location = "";
  }

  void _upload() async{
    Directory systemTempDir=Directory.systemTemp;
    File file=await File('${systemTempDir.path}/test.txt').create();//any file i want to upload
    await file.writeAsString("Hello World");//you don't have to write this you can upload old file from directory

    String location=await fbStorage.upload(file, basename(file.path));

    setState(() {
      _location=location;
      _status="Uploaded!";
    });
    print("uploaded to ${location}");
  }

  void _download()async{
    if(_location.isEmpty) {
      setState(() {
        _status = 'Please upload first!';
      });
      return;
    }
    Uri location = Uri.parse(_location);
    print(_location);
    String data = await fbStorage.download(location);
    setState(() {
      _status="Downloaded: ${data}";
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
              new Text(_status,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              new SizedBox(
                width: MediaQuery.of(context).size.width,
                child:
                new RaisedButton(onPressed: _upload,child: new Text("Upload"),),
              ),
              new SizedBox(
                width: MediaQuery.of(context).size.width,
                child:
                new RaisedButton(onPressed: _download,child: new Text("Download"),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}