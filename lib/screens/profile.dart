import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:punctually/cubit/state_cubit.dart';
import 'package:punctually/shared.dart';
import 'package:punctually/style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<StateCubit, StateState>(
            bloc: StateCubit.i,
            builder: (context, state) {
              ProfileImageState imageState = state as ProfileImageState;
              return Container(
                padding: const EdgeInsets.all(25),
                height: screenWidth,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.yellow,
                  image: imageState.image == null
                      ? DecorationImage(
                          image: AssetImage("assets/profile_img.png"),
                          fit: BoxFit.cover)
                      : DecorationImage(
                          image: FileImage(imageState.image!),
                          fit: BoxFit.cover,
                        ),
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
                        onPressed: StateCubit.i.getImage,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          textField(label: "Name", value: "First Name and Last Name"),
          const SizedBox(height: 15),
          textField(label: "Portfolio", value: "Managing Director"),
          const SizedBox(height: 15),
          textField(label: "Department", value: "Finance"),
        ],
      ),
    ));
  }

  Container textField({String label = "", String value = ""}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primaryColorLight.withOpacity(.6),
      ),
      child: TextFormField(
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
