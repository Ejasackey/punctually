import "package:flutter/material.dart";
import 'package:punctually/cubit/month_cubit/cubit/month_cubit.dart';
import 'package:punctually/cubit/qr_cubit/qr_cubit.dart';
import 'package:punctually/main.dart';
import 'package:punctually/models/month.dart';
import 'package:punctually/shared.dart';
import 'package:punctually/style.dart';

class ReportScreen extends StatelessWidget {
  final Month month;
  const ReportScreen({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(context),
                const SizedBox(height: 40),
                _legend,
                const SizedBox(height: 20),
                calendar(screenWidth),
                const SizedBox(height: 30),
                performance,
                const SizedBox(height: 10),
                percentage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //-----------------------------------------------------------------------------------------
  Container calendar(double screenWidth) {
    return Container(
      height: screenWidth * 1.03,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: accentLight,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                day("Mon"),
                day("Tue"),
                day("Wed"),
                day("Thu"),
                day("Fri"),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              primary: false,
              children: [
                ...List.generate(
                    MonthCubit.getMonthDetailData(month)
                            .days
                            .keys
                            .first
                            .weekday -
                        1,
                    (index) => Container()),
                ...MonthCubit.getMonthDetailData(month)
                    .days
                    .entries
                    .map(
                      (map) => Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: map.value ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(18),
                          border: map.value
                              ? Border.all(color: Colors.transparent)
                              : Border.all(color: primaryColor, width: 2),
                        ),
                        child: Text(
                          map.key.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: map.value ? Colors.white : primaryColor,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  //-----------------------------------------------------------------------------------------
  Widget day(day) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          day,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(.75)),
        ),
      ),
    );
  }

  //-----------------------------------------------------------------------------------------
  Container percentage() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            LinearProgressIndicator(
              value: MonthCubit.getPercentage(
                  MonthCubit.getMonthDetailData(month)),
              minHeight: double.infinity,
              backgroundColor: primaryColorLight,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${(MonthCubit.getPercentage(MonthCubit.getMonthDetailData(month)) * 100).ceil()}%",
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
    );
  }

  //-----------------------------------------------------------------------------------------
  static final Padding performance = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Text(
      "Performance",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(.75),
      ),
    ),
  );

  //-----------------------------------------------------------------------------------------
  Widget appBar(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          roundedButton(context: context),
          const SizedBox(width: 30),
          Text(
            "${MonthCubit.getMonthName(month.date.month)} Report",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(.75),
            ),
          )
        ],
      ),
    );
  }

  //-----------------------------------------------------------------------------------------
  static final Widget _legend = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(width: 10),
        Text("Attended"),
        SizedBox(width: 30),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(width: 10),
        Text("Missed"),
      ],
    ),
  );
}
