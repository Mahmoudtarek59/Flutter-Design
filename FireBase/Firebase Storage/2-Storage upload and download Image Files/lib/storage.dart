import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;


Future<String> upload(File file,String basename) async{
  StorageReference ref=FirebaseStorage.instance.ref().child('images/${basename}');
  StorageUploadTask uploadTask=ref.putFile(file);
  StorageTaskSnapshot snapshot=await uploadTask.onComplete;

  var  location =await snapshot.ref.getDownloadURL();
  String name= await snapshot.ref.getName();
  String bucket = await snapshot.ref.getBucket();
  String path =await snapshot.ref.getPath();

  print('Url: ${location.toString()}');
  print('Name: ${name}');
  print('Bucket: ${bucket}');
  print('Path: ${path}');

  return location.toString();
}


Future<String> download(Uri location) async{
  http.Response data = await http.get(location);

  return data.body;

}