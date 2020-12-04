import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_reminder/PatientController/Cards/details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//This widget is called first wherever an image is needed to be uploaded
//must return the file pertaining to the image to be uploaded
typedef fileChange = File Function(File);

/// Widget to capture and crop the image
class ImageCapture extends StatefulWidget {
  // fileChange file;
  // ImageCapture(this.file);
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
      // ratioX: 1.0,
      // ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
      toolbarColor: Color(0xff292929),
      toolbarWidgetColor: Color(0xffbb86fe),
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
    });
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
    newFile:
    (File F) {
      widget.newFile(F);
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff121212),
        // Select an image from the camera or gallery
        bottomNavigationBar: BottomAppBar(
          color: Color(0xff292929),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.photo_library,
                  color: Color(0xffbb86fe),
                ),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
              IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Color(0xffbb86fe),
                ),
                onPressed: () => _pickImage(ImageSource.camera),
              ),

              IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Color(0xffbb86fe),
                  ),
                  onPressed: () {
                    widget.newFile(widget.finalFile);
                    Navigator.pop(context);
                  }),
              // IconButton(icon: Icon(Icons.upload_file), onPressed: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               ImageCapture(
              //             newFile: (f){
              //             testfile = f;
              //             print('new : ${testfile.path}');
              //           },
              //           )
              //       ));
              // })
            ],
          ),
        ),

        // Preview the image and crop it
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: _imageFile == null
                    ? Container(
                        color: Color(0xff121212),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Pick An Image", style: TextStyle(
                            color: Color(0xfff2e7fe).withOpacity(0.6),
                            fontFamily: 'Circular',
                            fontWeight: FontWeight.bold,
                            fontSize: 24)),
                        Container(
                          child: FlatButton(
                            child: Icon(
                              FontAwesomeIcons.arrowDown,
                              color: Color(0xffbb86fe).withOpacity(0.5),
                            ),
                            onPressed: (){

                            },
                          ),
                        )
                      ],
                    ),
                  ),
                      )
                    : Image.file(_imageFile),
              ),
            ),
            Container(
              color: Color(0xff242424),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    child: Icon(
                      Icons.crop,
                      color: Color(0xffbb86fe),
                    ),
                    onPressed: _cropImage,
                  ),
                  FlatButton(
                    child: Icon(
                      Icons.refresh,
                      color: Color(0xffbb86fe),
                    ),
                    onPressed: _clear,
                  ),
                ],
              ),
            ),
          ],
        ),
        // ListView(
        //   children: <Widget>[
        //     if (_imageFile != null) ...[
        //
        //       Image.file(_imageFile),
        //
        //       Row(
        //         children: <Widget>[
        //           FlatButton(
        //             child: Icon(Icons.crop),
        //             onPressed: _cropImage,
        //           ),
        //           FlatButton(
        //             child: Icon(Icons.refresh),
        //             onPressed: _clear,
        //           ),
        //         ],
        //       ),
        //
        //       imageUpload(_imageFile,widget.imagePath)
        //       //Uploader(file: _imageFile)
        //     ]
        //   ],
        // ),
      ),
    );
  }
}

// imageUpload(File _imgFile,String _imagePath) async {
//   var _storage = FirebaseStorage.instanceFor(bucket: 'gs://medicine-reminder-406a5.appspot.com/');
//    _storage.ref().child(_imagePath).putFile(_imgFile);
//    String url = await _storage.ref(_imagePath).getDownloadURL();
//   print(imgUrl);
// }

/*
class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key,this.file}) : super(key: key);
  @override
  _UploaderState createState() => _UploaderState();
}


class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://fireship-lessons.appspot.com');

  StorageUploadTask _uploadTask;

  /// Starts an upload task
  void _startUpload() {

    /// Unique file name for the file
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {

      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(

              children: [
                if (_uploadTask.isComplete)
                  Text('ABC'),


                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text(
                    '${(progressPercent * 100).toStringAsFixed(2)} % '
                ),
              ],
            );
          });


    } else {

      // Allows user to decide when to start the upload
      return FlatButton.icon(
        label: Text('Upload to Firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );

    }
  }
}
*/
