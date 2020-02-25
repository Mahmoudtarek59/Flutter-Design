import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:http/http.dart' as http;

Future<String> upload(File file, String basename) async {

  StorageReference ref = FirebaseStorage.instance.ref().child('file/test/${basename}');
  StorageUploadTask uploadTask = ref.putFile(file);
  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
  var  location =await storageTaskSnapshot.ref.getDownloadURL();
  //Uri location = (await uploadTask.future).downloadUrl;


  String name = await storageTaskSnapshot.ref.getName();
  String bucket = await storageTaskSnapshot.ref.getBucket();
  String path = await storageTaskSnapshot.ref.getPath();

  print('Url: ${location.toString()}');
  print('Name: ${name}');
  print('Bucket: ${bucket}');
  print('Path: ${path}');

  return location.toString();
}
Future<String> download(Uri location) async {

  http.Response data = await http.get(location);

  return data.body;
}