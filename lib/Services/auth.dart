import 'package:expense_tracker/Screens/home.dart';
import 'package:expense_tracker/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

String userID;
String userDisplayName;
String userPicture;
String userEmail;
bool isEmailVerified;

class AuthService {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount _googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleSignInAuthentication =
          await _googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _googleSignInAuthentication.idToken,
        accessToken: _googleSignInAuthentication.accessToken,
      );

      final AuthResult result =
          await _firebaseAuth.signInWithCredential(credential);
      if (result != null) {
        FirebaseUser user = await _firebaseAuth.currentUser();
        userID = user.uid;
        userDisplayName = user.displayName;
        userPicture = user.photoUrl;
        userEmail = user.email;

        if (user.isEmailVerified == true) {
          isEmailVerified = true;
        } else {
          isEmailVerified = false;
        }
        DatabaseServices().updateTask(user);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
    } catch (e) {
      print(e.message);
    }
  }

  void signOut() {
    _googleSignIn.signOut();
  }

  String getUserUid() {
    return userID;
  }

  String getUserdisplayname() {
    return userDisplayName;
  }

  String getUserPicture() {
    return userPicture;
  }

  String getUserEmail() {
    return userEmail;
  }

  String isUserApproved() {
    if (isEmailVerified == false) {
      return 'Your email verification is pending';
    } else {
      return 'Your email is verified';
    }
  }
}
