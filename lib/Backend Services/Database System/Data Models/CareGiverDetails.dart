class CGD{
  final String emailId;
  final String userName;
  final String passWord;
  String userId;

  CGD({this.emailId, this.userName, this.passWord,this.userId});
  setUserID(String iD){
    this.userId=iD;
  }
  Map<String,dynamic> toMap(){
    return {
      'userId': userId,
      'userName': userName,
      'emailId':emailId,
      'passWord':passWord,
    };
  }
}