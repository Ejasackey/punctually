import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:punctually/cubit/state_cubit.dart';
import 'package:punctually/screens/profile.dart';
import 'package:punctually/screens/report.dart';
import 'package:punctually/shared.dart';
import 'package:punctually/style.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<StateCubit, StateState>(
        bloc: StateCubit.i,
        listenWhen: (previous, current) => current is HomeScreenState,
        listener: (context, state) {
          if (state is HomeScreenState) {
            scanStatusDialog(context, state.scanStatus);
          }
        },
        child: Stack(
          children: [
            upperColor,
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                child: Column(
                  children: [
                    profileSection(context),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemBuilder: (context, index) => monthCard(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    scanButton(context)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Scan Status Dialog Widget:---------------------------------------------------------------------
  scanStatusDialog(context, success) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor:
                    success ? Color(0xFFE0FFE9) : Colors.red.withOpacity(.1),
                child: Icon(
                  success ? Icons.check_rounded : Icons.clear_rounded,
                  size: 80,
                  color: success ? Color(0xFF04A932) : Colors.redAccent,
                ),
              ),
              SizedBox(height: 30),
              Text(
                success ? "Success" : "Invalid Code",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(.75),
                ),
              ),
              SizedBox(height: 20),
              if (success)
                Text(
                  "Checked in today",
                  style: TextStyle(color: Colors.grey[600]),
                )
            ],
          ),
        ),
      ),
    );
  }

  // Month Card Widget:---------------------------------------------------------------------
  Widget monthCard(context) {
    return GestureDetector(
      onTap: () {
        navTo(context, ReportScreen());
      },
      child: Container(
        height: 70,
        width: double.infinity,
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 4),
              blurRadius: 4,
            )
          ],
        ),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            SizedBox(width: 15),
            Text(
              "This Month",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    LinearProgressIndicator(
                      value: .6,
                      minHeight: double.infinity,
                      backgroundColor: primaryColorLight,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "63%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(.8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Scan Button Widget:---------------------------------------------------------------------
  SizedBox scanButton(context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () => StateCubit.i.scanQR(context),
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Scan QR",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.qr_code_2_rounded,
              size: 32,
            )
          ],
        ),
      ),
    );
  }

  // Profile Section Widget:---------------------------------------------------------------------
  Widget profileSection(context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: double.infinity,
      // color: Colors.red,
      child: Row(
        children: [
          BlocBuilder<StateCubit, StateState>(
            bloc: StateCubit.i,
            buildWhen: (prev, cur) => cur is ProfileState,
            builder: (context, state) {
              return Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                  image:
                      state is ProfileState && state.user!.profileUrl.isNotEmpty
                          ? DecorationImage(
                              image: FileImage(
                                File(state.user!.profileUrl!),
                              ),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: AssetImage("assets/profile_img.png"),
                              fit: BoxFit.cover,
                            ),
                ),
              );
            },
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Abigail Mensah",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Ambassador",
                style: TextStyle(
                    fontSize: 16, color: Colors.white.withOpacity(.9)),
              ),
              ElevatedButton(
                onPressed: () => navTo(context, ProfileScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: Text(
                  "Edit profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // Upper backgound color Widget:---------------------------------------------------------------------
  final Column upperColor = Column(
    children: [
      Container(
        height: 260,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: primaryColor,
        ),
      )
    ],
  );
}
