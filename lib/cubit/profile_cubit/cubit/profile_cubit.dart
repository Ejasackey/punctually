import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:punctually/models/org.dart';
import 'package:punctually/models/user.dart';
import 'package:punctually/screens/home.dart';
import 'package:punctually/screens/qr_screen.dart';
import 'package:punctually/services/firebase_database.dart';
import 'package:punctually/shared.dart';

part 'profile_state.dart';

class ProfileCubit {
  FirestoreService firestoreService;
  ProfileCubit({required this.firestoreService});
  

  verifyUser(userId, context) async {
    late dynamic me;
    try {
      me = await firestoreService.login(userId);
      if (me is Organization) {
        navTo(context, QRScreen(data: (me as Organization).qrCode));
      } else {
        navTo(context, HomeScreen(user: (me as User)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User does not exist")));
    }
  }
}
