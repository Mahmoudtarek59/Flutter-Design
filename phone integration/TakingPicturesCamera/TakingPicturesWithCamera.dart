import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'dart:async';

List<CameraDescription> cameras;//because every device can have more than one camera
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras= await availableCameras();
  await PermissionHandler().requestPermissions([PermissionGroup.camera]);
  await PermissionHandler().requestPermissions([PermissionGroup.storage]);

  runApp(new MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  _State createState()=> new _State();
}

class _State extends State<MyApp>{
  CameraController controller;
  final GlobalKey<ScaffoldState> __scaffoldKey= new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    controller=new CameraController(cameras[0]//for first camera
      ,ResolutionPreset.medium );
    controller.initialize().then((_){
      if(!mounted)return;
      setState(() {
        //TO DO - Anything we want
      });
    });
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<String> saveImage()async{
    String timeStamp = new DateTime.now().millisecondsSinceEpoch.toString();//unique picture name
    String filePath='/storage/emulated/0/DCIM/Camera/${timeStamp}.jpg';

    if(controller.value.isTakingPicture) return null;

    try{
      controller.takePicture(filePath);
    }on CameraException catch(e){
      showSnake(e.toString());
    }

    return filePath;
  }

  void takePicture() async{
    if(await PermissionHandler().checkPermissionStatus(PermissionGroup.camera) != PermissionStatus.granted ||
        await PermissionHandler().checkPermissionStatus(PermissionGroup.storage)!=PermissionStatus.granted){
      showSnake("Lacking permissions to take a picture");
      return;
    }
    saveImage().then((String filePath){
      if(mounted && filePath!=null) showSnake('Picture saved to ${filePath}');
    });
  }

  void showSnake(String message){
    __scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(message)));
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key:__scaffoldKey,
      appBar: new AppBar(
        title: new Text("Name Here"),
      ),
      body: new Container(
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new RaisedButton(onPressed: takePicture,child: new Text("Take Picture"),),
                  new RaisedButton(onPressed: PermissionHandler().openAppSettings,child: new Text("Settings"),),
                ],
              ),
             new Expanded(
                 child:new AspectRatio(
                   aspectRatio: 1,child: new CameraPreview(controller),
                 )
               ,),
            ],
          ),
      ),
    );
  }
}