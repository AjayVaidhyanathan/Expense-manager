import 'package:expense_tracker/Screens/home.dart';
import 'package:expense_tracker/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class AuthService extends ChangeNotifier {
  String userID;
  String userDisplayName;
  String userPicture;
  String userEmail;
  bool isEmailVerified;

  String get getUid => userID;
  String get getPhotoURL => userPicture;
  String get getEmail => userEmail;
  String get getName => userDisplayName;
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount _googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleSignInAuthentication =
          await _googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: _googleSignInAuthentication.idToken,
        accessToken: _googleSignInAuthentication.accessToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (userCredential != null) {
        User user = userCredential.user;

        userDisplayName = user.displayName;
        userPicture = user.photoURL;
        userEmail = user.email;
        userID = user.uid;

        if (user.emailVerified == true) {
          isEmailVerified = true;
        } else {
          isEmailVerified = false;
        }
        Provider.of<DatabaseServices>(context, listen: false)
            .updateUser(context, 'Users');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
    } catch (e) {
      print(e.message);
    }
    notifyListeners();
  }

  void signOut() {
    _googleSignIn.signOut();
  }

  String isUserApproved() {
    if (isEmailVerified == false) {
      return 'Your email verification is pending';
    } else {
      return 'Your email is verified';
    }
  }
}
