import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_reminder/PatientController/Cards/details.dart';

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
        // toolbarColor: Colors.purple,
        // toolbarWidgetColor: Colors.white,
        // toolbarTitle: 'Crop It'
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

      home: Scaffold(
        backgroundColor: Colors.black,
        // Select an image from the camera or gallery
        bottomNavigationBar: BottomAppBar(
          color: Color(0xffbb86fe),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
              IconButton(icon: Icon(Icons.done), onPressed: (){
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
        body:
          ListView(
            children: [
              Center(
                child: _imageFile == null ? Container():Image.file(_imageFile) ,
              ),
              Row(
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