import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:punctually/cubit/profile_cubit/cubit/profile_cubit.dart';
import 'package:punctually/screens/home.dart';
import 'package:punctually/services/firebase_database.dart';
import 'package:punctually/shared.dart';
import 'package:punctually/style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static final ProfileCubit _profileCubit =
      ProfileCubit(firestoreService: FirestoreService());
  static String _userId = "";
  static bool isVisible = false;
  static bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            // color: Colors.pink,
            child: Column(
          children: [
            appBar(),
            const SizedBox(height: 180),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textField(),
                const SizedBox(height: 20),
                verifyButton(context)
              ],
            ),
          ],
        )),
      ),
    );
  }

  //----------------------------------------------------------------------------------------------
  Widget verifyButton(context) {
    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        height: 50,
        width: 140,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: () async {
            isLoading = true;
            setState(() {});
            await _profileCubit.verifyUser(_userId, context);
            setState(() => isLoading = false);
          },
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text("Verify",
                  style: TextStyle(color: Colors.white, fontSize: 17)),
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------------------------
  Widget textField() {
    return StatefulBuilder(
      builder: (context, setState) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          obscureText: !isVisible,
          onChanged: (val) => _userId = val,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () => setState(() => isVisible = !isVisible),
                icon: Icon(
                  isVisible ? Icons.visibility : Icons.visibility_off,
                )),
            labelText: "User ID",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            fillColor: primaryColorLight,
            filled: true,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------------------------
  Container appBar() {
    return Container(
      height: 170,
      width: double.infinity,
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/scan_icon.png",
            width: 90,
            height: 90,
          ),
          const SizedBox(width: 40),
          const Text(
            "Punctually",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
