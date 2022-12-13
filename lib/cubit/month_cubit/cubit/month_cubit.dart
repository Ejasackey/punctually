import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:punctually/models/month.dart';
import 'package:punctually/services/firebase_database.dart';

part 'month_state.dart';

class MonthCubit extends Cubit<List<Month>> {
  FirestoreService firestoreService;
  MonthCubit({required this.firestoreService}) : super([]);

  static Month getMonthDetailData(Month month) {
    month.days.removeWhere((key, value) {
      return key.weekday == 6 || key.weekday == 7;
    });
    return month;
  }

  // ----------------------------------------------------------------------------------------
  registerAttendance(userId) async {
    try {
      await firestoreService.registerAttendance(userId);
    } catch (e) {
      log(e.toString(), name: "Month Cubit: registerAttendance");
    }
  }

  // ----------------------------------------------------------------------------------------
  updateMonthData(thisDate) {
    // Month thisMonth = monthBox.values.singleWhere((month) =>
    //     DateTime(
    //       month.date.year,
    //       month.date.month,
    //     ) ==
    //     DateTime(
    //       thisDate.year,
    //       thisDate.month,
    //     ));
    // // if this month exists, change today's value to true

    // for (DateTime day in thisMonth.days.keys) {
    //   if (day == DateTime(thisDate.year, thisDate.month, thisDate.day)) {
    //     thisMonth.days[day] = true;
    //     thisMonth.save();
    //     break;
    //   }
    // }
  }

  // ----------------------------------------------------------------------------------------
  static double getPercentage(Month month) {
    int att = getMonthDetailData(month)
        .days
        .values
        .where((value) => value == true)
        .length;
    return (att / month.days.values.length);
  }

  // ----------------------------------------------------------------------------------------
  static getMonthName(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "Febuary";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
    }
  }
}
