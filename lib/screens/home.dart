import 'package:flutter/material.dart';
import 'package:punctually/main.dart';
import 'package:punctually/screens/report.dart';
import 'package:punctually/shared.dart';
import 'package:punctually/style.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            upperColor,
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                child: Column(
                  children: [
                    profileSection(),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          itemBuilder: (context, index) => monthCard(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    scanButton()
                  ],
                ),
              ),
            )
          ],
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
  SizedBox scanButton() {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
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
          )),
    );
  }

  // Profile Section Widget:---------------------------------------------------------------------
  Container profileSection() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: double.infinity,
      // color: Colors.red,
      child: Row(
        children: [
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(20),
            ),
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
                onPressed: () {},
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
          color: PrimaryColor,
        ),
      )
    ],
  );
}
