import 'package:medicine_reminder/PatientList/HomeScreen.dart';

class MedicineDescription{
  final String medName;
  String medUrl;
  String medId;
  String availableQuantity;

  MedicineDescription({this.medName,this.availableQuantity,this.medUrl}){
    this.medId = getId(medName);
  }

  // Hash Function to obtain case-insensitive medicine id from medicine name

  static String getId(String mName){
    String mId='';
    Map<String,String> chars = {

      'a':'1','A':'1',
      'b':'2','B':'2',
      'c':'3','C':'3',
      'd':'4','D':'4',
      'e':'5','E':'5',
      'f':'6','F':'6',
      'g':'7','G':'7',
      'h':'8','H':'8',
      'i':'9','I':'9',
      'j':'a','J':'a',
      'k':'b','K':'b',
      'l':'c','L':'c',
      'm':'d','M':'d',
      'n':'e','N':'e',
      'o':'f','O':'f',
      'p':'g','P':'g',
      'q':'h','Q':'h',
      'r':'i','R':'i',
      's':'j','S':'j',
      't':'k','T':'k',
      'u':'l','U':'l',
      'v':'m','V':'m',
      'w':'n','W':'n',
      'x':'o','X':'o',
      'y':'p','Y':'p',
      'z':'q','Z':'q',
      '0':'A', ' ':' ',
      '1':'B',
      '2':'C',
      '3':'D',
      '4':'E',
      '5':'F',
      '6':'G',
      '7':'H',
      '8':'I',
      '9':'J',
    };
    for(int i = 0;i<mName.length;i++){
      mId=mId+chars[mName[i]];
    }
    return mId;
  }

  Map<String,dynamic> toMap(){

    return {
      'medId' : medId,
      'medName' : medName,
      'availableQuantity' : availableQuantity,
      'imageUrl': imageUrl
    };
  }

}

class MedicineDB{
  String MedName;
  String Type;

  MedicineDB({this.MedName, this.Type});

  factory MedicineDB.fromJson(Map<String, dynamic> json){
    return MedicineDB(
      MedName: json['MedName'],
      Type: json['Type'],
    );
  }

  Map<String,dynamic> toMap() {
    return {
      'MedName': MedName,
      'Type': Type
    };
  }
}