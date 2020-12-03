import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/MedicineDescription.dart';


/*Instructions To Upload an Image
*
* Call ImageHandler and obtain the image file from the callback newFile ... example
*
* ImageHandler(
*   newFile(File imageFile){
*     localImageFile = imageFile;
*   }
* )
*
* Then create and object of ImageService i.e this very class and pass in the localImageFile ... example
*
*ImageService _instanceImageService.MedicineImage(imageFile);
*
* and perform operations as required
*
* */

//Takes a file as input
//Uploads it to firebase storage
//Sets the download url


class ImageService{

  FirebaseStorage storage;
  File pickedImageFile;
  String imagePath;
  String targetUrl;

  ImageService.MedicineImage(File imageFile,String medicineName){
    dataInitialization(imageFile);
    this.imagePath = 'MedicineImages/${MedicineDescription.getId(medicineName)}.png';
    uploadFetchImage();
    fetchImageUrl();
  }

  ImageService.CareGiverImage(File imageFile,String caregiverEmail){
    dataInitialization(imageFile);
    this.imagePath = 'CareGiverImages/$caregiverEmail.png';
    uploadFetchImage();
    fetchImageUrl();
  }

  ImageService.PatientImage(File imageFile,String patientContactNumber){
    dataInitialization(imageFile);
    this.imagePath = 'PatientImages/$patientContactNumber.png';
    uploadFetchImage();
    fetchImageUrl();
  }

  dataInitialization(File imageFile){
    storage = FirebaseStorage.instanceFor(bucket: 'gs://medicine-reminder-406a5.appspot.com/');
    pickedImageFile = File(imageFile.path);
  }

  uploadFetchImage() async {
    var snapShot = storage.ref().child(imagePath).putFile(pickedImageFile);
    //targetUrl = await snapShot.snapshot.ref.getDownloadURL();
    targetUrl = await storage.ref('MedicineImages/qr.PNG').getDownloadURL();
  }

  fetchImageUrl() async {
    targetUrl = await storage.ref(imagePath).getDownloadURL();
  }

  String getImageUrl(){
    return targetUrl;
  }
}