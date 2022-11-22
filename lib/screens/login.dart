import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:punctually/screens/home.dart';
import 'package:punctually/shared.dart';
import 'package:punctually/style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                SizedBox(height: 20),
                verifyButton(context)
              ],
            ),
          ],
        )),
      ),
    );
  }

  //----------------------------------------------------------------------------------------------
  SizedBox verifyButton(context) {
    return SizedBox(
      height: 50,
      width: 140,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        onPressed: () => navTo(context, HomeScreen()),
        child:
            Text("Verify", style: TextStyle(color: Colors.white, fontSize: 17)),
      ),
    );
  }

  //----------------------------------------------------------------------------------------------
  Padding textField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "User ID",
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          fillColor: primaryColorLight,
          filled: true,
          border: InputBorder.none,
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
          SvgPicture.asset(
            "assets/icons/scan_icon.svg",
            width: 90,
            height: 90,
          ),
          const SizedBox(width: 40),
          Text(
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
