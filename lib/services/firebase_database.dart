import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punctually/models/org.dart';
import 'package:punctually/models/user.dart';

class FirestoreService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> _usersCollection =
      firestore.collection("users");

  CollectionReference<Map<String, dynamic>> _organizationCollection =
      firestore.collection("organizations");

  //--------------------------------------------------------------------------------------------
  Future<dynamic> login(String userId) async {
    try {
      // check if useId is organizational ID
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _organizationCollection.doc(userId).get();
      return Organization.fromMap(doc.data());
    } catch (e) {
      // check if user is a normal user
      log("User not organization", name: "Firestore : getProfile");
      try {
        DocumentSnapshot<Map<String, dynamic>> doc =
            await _usersCollection.doc(userId).get();
        return User.fromMap(doc.data());
      } catch (e) {
        log(e.toString(), name: "Firestore : getProfile");
        rethrow;
      }
    }
  }

  //--------------------------------------------------------------------------------------------
  registerAttendance(String userId, String value) async {
    DateTime now = DateTime.now();
    String monthId = DateTime(now.year, now.month).toIso8601String();
    String thisMonth = DateTime(now.year, now.month, now.day)
        .toIso8601String()
        .substring(0, 19);
    try {
      await _usersCollection
          .doc(userId)
          .collection("months")
          .doc(monthId)
          .update({'days.$thisMonth': value}).timeout(
              const Duration(seconds: 10));
    } catch (e) {
      log(e.toString(), name: "Firestore: registerAttendance");
      throw e;
    }
  }
}
