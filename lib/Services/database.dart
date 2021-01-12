import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/Services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class DatabaseServices extends ChangeNotifier {
  Future updateUser(BuildContext context, String collection) async {
    return await _firestore
        .collection(collection)
        .doc(Provider.of<AuthService>(context, listen: false).userID)
        .set(
      {
        'uid': Provider.of<AuthService>(context, listen: false).userID,
        'email': Provider.of<AuthService>(context, listen: false).userEmail,
        'photoURL':
            Provider.of<AuthService>(context, listen: false).userPicture,
        'displayName':
            Provider.of<AuthService>(context, listen: false).userDisplayName,
        'lastSeen': DateTime.now()
      },
    );
  }

  Future addexpense(BuildContext context, dynamic data) async {
    return await _firestore
        .collection('Users')
        .doc(Provider.of<AuthService>(context, listen: false).userID)
        .collection('2020')
        .doc()
        .set(data);
  }

  Stream<QuerySnapshot> fetchData(
      BuildContext context, String collection) async* {
    yield* _firestore
        .collection('Users')
        .doc(Provider.of<AuthService>(context, listen: false).userID)
        .collection(collection)
        .snapshots();
  }
}
