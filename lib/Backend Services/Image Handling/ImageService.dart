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
  }

  ImageService.CareGiverImage(File imageFile,String caregiverEmail){
    dataInitialization(imageFile);
    this.imagePath = 'CareGiverImages/$caregiverEmail.png';
    uploadFetchImage();

  }

  ImageService.PatientImage(File imageFile,String patientContactNumber){
    dataInitialization(imageFile);
    this.imagePath = 'PatientImages/$patientContactNumber.png';
    uploadFetchImage();

  }

  dataInitialization(File imageFile){
    storage = FirebaseStorage.instanceFor(bucket: 'gs://medicine-reminder-406a5.appspot.com/');
    pickedImageFile = File(imageFile.path);
  }

  uploadFetchImage() async {
    print("Oxygen:");
    print(imagePath);
    var snapShot = storage.ref().child(imagePath).putFile(pickedImageFile).snapshot;
    //targetUrl = await storage.ref(imagePath).getDownloadURL();
   // targetUrl = await  snapShot.ref.getDownloadURL();
  }

}