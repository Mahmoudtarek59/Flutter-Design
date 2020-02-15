import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
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

  PermissionGroup permissionGroup;
  String status;


  @override
  void initState() {
    super.initState();
    status =" Check Buttons";

  }

  List<DropdownMenuItem<PermissionGroup>> __getDropDownItems(){
    List<DropdownMenuItem<PermissionGroup>> _items=new List<DropdownMenuItem<PermissionGroup>>();
    PermissionGroup.values.forEach((permissionGroup){
      var item= new DropdownMenuItem(child: new Text(permissionGroup.toString()),value: permissionGroup,);
      _items.add(item);
    });
    return _items;
  }

  void onDropDownChanged(PermissionGroup permissionGroup){
    setState(() {
      this.permissionGroup=permissionGroup;
      status = 'Click a button below';
    });
  }

  void _requestPermissions()async{
    final permission=await PermissionHandler().requestPermissions([permissionGroup]);
    setState(() {
      status=permission.toString();
    });
  }
  
  void _checkPermissionStatus() async{
    final permission=await PermissionHandler().checkPermissionStatus(permissionGroup);
    setState(() {
      status=permission.toString();
    });
  }

  void _checkServiceStatus() async{ //only for location
    final permission=await PermissionHandler().checkServiceStatus(PermissionGroup.location);
    setState(() {
      status=permission.toString();
    });
  }

  void _openAppSettings() async{
    final permission= await PermissionHandler().openAppSettings();
  }

  void _ShowRequestPermissionRationale()async{ //Android only
    final permission = await PermissionHandler().shouldShowRequestPermissionRationale(permissionGroup);
    setState(() {
      status= permission.toString();
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
              new Text(status),
              new DropdownButton(items: __getDropDownItems(),value: permissionGroup,onChanged: onDropDownChanged),
              new RaisedButton(onPressed: _requestPermissions,child: new Text("Request Permissions"),),
              new RaisedButton(onPressed: _checkPermissionStatus,child: new Text("Check Permission Status"),),
              new RaisedButton(onPressed: _checkServiceStatus,child: new Text("Check Service Status"),),//only for location
              new RaisedButton(onPressed: _openAppSettings,child: new Text("open App Settings"),),
              new RaisedButton(onPressed: _ShowRequestPermissionRationale,child: new Text("ShowRequestPermissionRationale"),),//Android only
            ],
          ),
        ),
      ),
    );
  }
}