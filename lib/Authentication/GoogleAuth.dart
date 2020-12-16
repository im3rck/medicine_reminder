import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);

  final UserCredential userCredential = await _auth.signInWithCredential(credential);
  final User user = userCredential.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentUser = _auth.currentUser;
  assert(currentUser.uid == user.uid);
  print(user);
  return user;
}

// Future loginWithGoogle() async {
//   try {
//     GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();
//
//     GoogleSignInAuthentication authentication =
//     await googleSignInAccount.authentication;
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       idToken: authentication.idToken,
//       accessToken: authentication.accessToken,
//     );
//
//     final UserCredential userCredential =
//     await FirebaseAuth.instance.signInWithCredential(credential);
//
//     User user = userCredential.user;
//     if (user != null) {
//       final QuerySnapshot result = await FirebaseFirestore.instance
//           .collection("users")
//           .where("id", isEqualTo: user.uid)
//           .get();
//
//       final List<DocumentSnapshot> documents = result.docs;
//
//       if (documents.length == 0) {
//         UserModel(user.uid).changeUser(
//           username: user.displayName,
//           email: user.email,
//           picture: user.photoURL,
//         );
//       }
//     }
//   } on PlatformException catch (e) {
//     print("Something wrong $e");
//     return null;
//   }
// }

void signOutGoogle() async {
  await googleSignIn.signOut();
  await googleSignIn.disconnect();
}