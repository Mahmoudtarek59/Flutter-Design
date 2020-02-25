import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import './imagePicker.dart';
import './storage.dart' as fbStorage;
import 'package:path/path.dart'; //needed for basename


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
      name: "firebaseApp",
      options: FirebaseOptions(
        googleAppID: "1:615625363396:android:844d57ce9f50b831665e91",//mobilesdk_app_id
        gcmSenderID: "615625363396",//project_number
        apiKey: "AIzaSyCV-N3esHs5B4eRnzYkSLId44LCCjXVBgk",//api_key
        projectID:"fir-app-c4040",//project_id
        //databaseURL: "https://fir-app-c4040.firebaseio.com",//firebase_url
      ),);
  final FirebaseStorage storage = new FirebaseStorage(
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
  _State createState()=> new _State();
}

class _State extends State<MyApp>{
  _State({this.storage});
  final FirebaseStorage storage;

  String _status;
  String _image;
  String _location;


  @override
  void initState() {
    _status ="";
    _location ="";
  }

  void _uploadImage()async{
    var image  = await getImage();

    String location=await fbStorage.upload(image, basename(image.path));
    print("uploaded to ${location}");

  setState(() {

      _location=location;
      _status="Uploaded!";
    });

  }

  void _download()async{
    if(_location.isEmpty) {
      setState(() {
        _status = 'Please upload first!';
      });
      return;
    }
    Uri location = Uri.parse(_location);
    print("$_location");
//    var image=await fbStorage.download(location); //don't need body we only need Uri
    setState(() {
      _image =location.toString();
      //_location=location.toString();
      _status="Downloaded!";
    });

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Name Here"),
        actions: <Widget>[new FlatButton(onPressed: _download, child: new Text("Get Iamges"))],
      ),
      body: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text(_status),
              new Center(
                child: _image == null
                  ? Text('No image selected.')
                  : Image.network(_image),)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}