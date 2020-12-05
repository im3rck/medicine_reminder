import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_reminder/PatientController/Cards/details.dart';

//This widget is called first wherever an image is needed to be uploaded
//must return the file pertaining to the image to be uploaded
typedef fileChange = File Function(File);
/// Widget to capture and crop the image
class ImageCapture extends StatefulWidget {

  ImageCapture({this.newFile});
  final ValueChanged<File> newFile;
  File finalFile;
  createState() => _ImageCaptureState();

}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File _imageFile;
  File testfile;
  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        toolbarColor: Color(0xff292929),
        toolbarWidgetColor: Color(0xfff2e7fe),
        toolbarTitle: 'Crop It',
        statusBarColor: Color(0xff292929),
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
      widget.finalFile = _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    var imgPicked = await ImagePicker().getImage(source: source);
    File selected = File(imgPicked.path);


    setState(() {
      _imageFile = selected;
      widget.finalFile = _imageFile;
    });
  }

  /// Remove image
  void _clear() {
    setState(() {
      _imageFile = null;
      widget.finalFile = _imageFile;
    }
    );
  }
  // // getImageUrl() async {
  // //   var _storage = FirebaseStorage.instanceFor(bucket: 'gs://medicine-reminder-406a5.appspot.com/');
  // //   String a  = await _storage.ref('PatientImages/karthikDummy.png').getDownloadURL();
  // //   setState(() {
  // //     urlImg = a;
  // //   });
  //
  //   print("AAA $urlImg");
  //   return null;
  // }
  // imageUpload(File _imgFile,String _imagePath) async {
  //   var _storage = FirebaseStorage.instanceFor(bucket: 'gs://medicine-reminder-406a5.appspot.com/');
  //   _storage.ref().child(_imagePath).putFile(_imgFile);
  //
  //    urlImg = await _storage.ref(_imagePath).getDownloadURL();
  //    print(urlImg);
  //
  // }

  @override
  Widget build(BuildContext context) {
    newFile: (File F){
      widget.newFile(F);
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff242424),
        // Select an image from the camera or gallery
        bottomNavigationBar: BottomAppBar(
          color: Color(0xff292929),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_library,color: Color(0xffbb86fe),),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
              IconButton(
                icon: Icon(Icons.photo_camera,color: Color(0xffbb86fe),),
                onPressed: () => _pickImage(ImageSource.camera),
              ),

              IconButton(icon: Icon(Icons.done,color: Color(0xffbb86fe),), onPressed: (){
              widget.newFile(widget.finalFile);
              Navigator.pop(context);
              }),

            ],
          ),
        ),

        // Preview the image and crop it
        body:
          ListView(
            children: [
              Center(
                child: _imageFile == null ? Container(
                  height: (MediaQuery.of(context).size.height)*.82,
                  color: Color(0xff121212),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pick and Image", style: TextStyle(
                            fontFamily: 'Circular',
                            fontSize: 20.0,
                            color: Color(0xfff2e7fe).withOpacity(0.8), fontWeight: FontWeight.bold),),
                        IconButton(
                            icon: FaIcon(FontAwesomeIcons.arrowDown, color: Color(0xffbb86fe).withOpacity(0.6)), onPressed: null)
                      ],
                    ),
                  ),
                ):Image.file(_imageFile) ,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                FlatButton(
                child: Icon(Icons.crop,color: Color(0xffbb86fe),),
                onPressed: _cropImage,
              ),
                FlatButton(
                child: Icon(Icons.refresh,color: Color(0xffbb86fe),),
                onPressed: _clear,
              ),
            ],
          ),
            ],
          ),
      ),
    );
  }
}
