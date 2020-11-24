import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

String iurl;

String uploadImage(){
  imageUpload();

  FirebaseMessaging fM = FirebaseMessaging();
  Future<String> token = fM.getToken();
  String sToken = token.toString();
  print('Token : $sToken');

}

imageUpload() async {
  final _storage = FirebaseStorage.instance;
  final _picker = ImagePicker();
  PickedFile image;

  //Check Permissions

  var permissionStatus;

    // await Permission.photos.request();
     permissionStatus = await Permission.photos.status;
     permissionStatus = await Permission.camera.status;
  if (permissionStatus.isGranted){
    //Select Image
    image = await _picker.getImage(source: ImageSource.camera);
    var file = File(image.path);
    if (image != null){
      //Upload to Firebase
      /*StorageTaskSnapshot snapshot = await _storage
          .ref()
          .child("images/imageName")
          .putFile(file)
          .onComplete;


      iurl = await snapshot.ref.getDownloadURL();
*/
    }
  }
}