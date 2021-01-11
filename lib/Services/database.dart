import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;
final String uid = AuthService().getUserUid();

class DatabaseServices {
  Future<void> updateTask(FirebaseUser user) async {
    return await _firestore.collection('Users').document(user.uid).setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }
}
