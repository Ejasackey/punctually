import 'dart:developer';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:punctually/cubit/profile_cubit/cubit/profile_cubit.dart';
import 'package:punctually/models/user.dart';
import 'package:punctually/shared.dart';
import 'package:punctually/style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          bloc: profileCubit,
          builder: (context, state) {
            User user = (state as ProfileLoaded).user;
            return WillPopScope(
              onWillPop: () async {
                profileCubit.saveProfileDetails(state.user);
                return Future.value(true);
              },
              child: Column(
                children: [
                  profileImg(
                    screenWidth,
                    context,
                    profileCubit,
                    user.profileUrl,
                  ),
                  const SizedBox(height: 20),
                  textField(
                    onchanged: (val) {
                      user.name = val;
                    },
                    label: "Name",
                    value: user.name,
                  ),
                  const SizedBox(height: 15),
                  textField(
                    onchanged: (val) => user.portfolio = val,
                    label: "Portfolio",
                    value: user.portfolio,
                  ),
                  const SizedBox(height: 15),
                  textField(
                    onchanged: (val) => user.department = val,
                    label: "Department",
                    value: user.department,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget profileImg(
    double screenWidth,
    BuildContext context,
    ProfileCubit profileCubit,
    String profileUrl,
  ) {
    return Container(
      padding: const EdgeInsets.all(25),
      height: screenWidth,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.yellow,
        image: profileUrl.isNotEmpty
            ? DecorationImage(
                image: FileImage(
                  File(profileUrl),
                ),
                fit: BoxFit.cover,
              )
            : DecorationImage(
                image: AssetImage("assets/profile_img.png"), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: roundedButton(context: context),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: roundedButton(
              context: context,
              icon: const Icon(Icons.edit_rounded),
              onPressed: profileCubit.saveProfileImage,
            ),
          )
        ],
      ),
    );
  }

  Container textField({String label = "", String value = "", onchanged}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primaryColorLight.withOpacity(.6),
      ),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        onChanged: onchanged,
        initialValue: value,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(.75)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontWeight: FontWeight.normal),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
