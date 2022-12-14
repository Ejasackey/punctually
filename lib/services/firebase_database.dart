import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punctually/models/month.dart';
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
        return User.fromMap(doc.data(), doc.id);
      } catch (e) {
        log(e.toString(), name: "Firestore : getProfile");
        rethrow;
      }
    }
  }

  //--------------------------------------------------------------------------------------------
  registerAttendance(String userId) async {
    DateTime now = DateTime.now();
    String monthId = DateTime(now.year, now.month).toIso8601String();
    String thisMonth = DateTime(now.year, now.month, now.day)
        .toIso8601String()
        .substring(0, 19);
    try {
      // try to register attendance
      await _usersCollection
          .doc(userId)
          .collection("months")
          .doc(monthId)
          .update({'days.$thisMonth': now.hour < 8 ? "A" : "L"}).timeout(
              const Duration(seconds: 10));
      log("attendance registered", name: "Firebase : register attendance");
    } catch (e) {
      // if exception is not a time out exception
      // auto populate and register attendance
      if (e is! TimeoutException) {
        log("creating new month ", name: "Firestore: registerAttendane");
        try {
          // auto populate this month.
          int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
          Map<DateTime, String> days = {};
          for (int i = 0; i < daysInMonth; i++) {
            days.addAll(
                {DateTime(now.year, now.month).add(Duration(days: i)): "M"});
          }
          days[DateTime(now.year, now.month, now.day)] =
              now.hour < 8 ? "A" : "L";
          Month thisMonth =
              Month(date: DateTime(now.year, now.month), days: days);

          // upload to firebase
          await _usersCollection
              .doc(userId)
              .collection("months")
              .doc(thisMonth.date.toIso8601String())
              .set(thisMonth.toMap)
              .timeout(const Duration(seconds: 10));
          log("new month created and registered", name: "Firebase");
        } catch (e) {
          log(e.toString(), name: "Firestore: registerAttendance");
          rethrow;
        }
      } else {
        rethrow;
      }
    }
  }
}
