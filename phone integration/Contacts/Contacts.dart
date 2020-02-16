import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'dart:async';


void main() {
  runApp(new MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  @override
  _State createState()=> new _State();
}

class _State extends State<MyApp>{
  final GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  var permission;
  Map<String,String> _contact;

  void _getpermission()async{
    permission= await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
  }


  @override
  void initState() {
    super.initState();
    _getpermission();
    _contact=new Map<String,String>();
  }


  void showSnackBar(String message){
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(message)));
  }

  void _create() async{
    if(await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts) == PermissionStatus.denied){
      _getpermission();
    }else {
      Contact person = new Contact(givenName: "Test", familyName: "Flutter",
        phones: [new Item(label: "work", value: "01014077615"),],
        emails: [new Item(label: "work", value: "tmahmoud974@gmail.com"),],
      );

      await ContactsService.addContact(person);
      showSnackBar('Created contact');
    }
  }

  void _read() async{
    if(await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts)==PermissionStatus.denied){
      _getpermission();
    }else{
      Iterable<Contact> read= await ContactsService.getContacts();
      setState(() {
        for(Contact person in read){
          _contact['${person.givenName.toString()} ${person.familyName.toString()}']=
          person.phones.length == 0 ? "no Element" : person.phones.first.value;
        }
      });
      //showSnackBar(read.first.givenName.toString());
    }

  }

  void _find()async{
    if(await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts) == PermissionStatus.denied){
      _getpermission();
    }else{
      Iterable<Contact> find=await ContactsService.getContacts(query: "Test");
      showSnackBar("${find.length>0}");
    }
  }

  void _delete() async{
    if(await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts) == PermissionStatus.denied){
      _getpermission();
    }else{
      Iterable<Contact> contact= await ContactsService.getContacts(query: "Test");
      Contact person=contact.first;
      await ContactsService.deleteContact(person);
      showSnackBar("Test Deleted");
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("Name Here"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Container(
                child: new Center(
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          padding: new EdgeInsets.only(right: 5.0),
                          child: new RaisedButton(onPressed: _create,child: new Text("Create"),),
                        ),
                      ),
                      new Expanded(
                        child: new Container(
                          padding: new EdgeInsets.only(right: 5.0),
                          child:  new RaisedButton(onPressed: _read,child: new Text("read"),),
                        ),
                      ),
                      new Expanded(
                        child: new Container(
                          padding: new EdgeInsets.only(right: 5.0),
                          child:  new RaisedButton(onPressed: _find,child: new Text("find"),),
                        ),
                      ),
                      new Expanded(
                        child: new Container(
                          padding: new EdgeInsets.only(right: 5.0),
                          child:  new RaisedButton(onPressed: _delete,child: new Text("delete"),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new Expanded(
                child: new ListView.builder(
                  itemCount: _contact.length,
                  itemBuilder: (BuildContext context,int index){
                    String key=_contact.keys.elementAt(index);
                    return new Card(
                      child: new Container(
                        padding: new EdgeInsets.all(5.0),
                        child: new Column(
                          children: <Widget>[
                            new Text(key,style:new TextStyle(fontWeight: FontWeight.bold),),
                            new Text(_contact[key],),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}