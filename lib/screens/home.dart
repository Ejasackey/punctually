import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:punctually/cubit/month_cubit/cubit/month_cubit.dart';
import 'package:punctually/cubit/profile_cubit/cubit/profile_cubit.dart';
import 'package:punctually/cubit/qr_cubit/qr_cubit.dart';
import 'package:punctually/models/month.dart';
import 'package:punctually/models/user.dart';
import 'package:punctually/screens/profile.dart';
import 'package:punctually/screens/report.dart';
import 'package:punctually/shared.dart';
import 'package:punctually/style.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);
    QRCubit _qrCubit = context.read<QRCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<QRCubit, bool?>(
        bloc: _qrCubit,
        listener: (context, state) {
          if (state != null) {
            scanStatusDialog(context, state);
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
                    profileSection(profileCubit),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: Month.months.length,
                          itemBuilder: (context, index) =>
                              monthCard(context, Month.months[index]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    scanButton(_qrCubit, context)
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
  Widget monthCard(context, Month month) {
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
              MonthCubit.getMonthName(month.date.month),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                      value: MonthCubit.getPercentage(month),
                      minHeight: double.infinity,
                      backgroundColor: primaryColorLight,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${(MonthCubit.getPercentage(month) * 100).ceil()}%",
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
  SizedBox scanButton(QRCubit _qrCubit, context) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: () => _qrCubit.scanQR(context),
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
  Widget profileSection(profileCubit) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: double.infinity,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          User user = (state as ProfileLoaded).user;
          return Row(
            children: [
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                  image: user.profileUrl.isNotEmpty
                      ? DecorationImage(
                          image: FileImage(
                            File(state.user.profileUrl),
                          ),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: AssetImage("assets/profile_img.png"),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      user.portfolio,
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
                ),
              )
            ],
          );
        },
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
