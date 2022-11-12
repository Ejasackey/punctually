import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:punctually/models/month.dart';

part 'month_state.dart';

class MonthCubit extends Cubit<List<Month>> {
  MonthCubit({required this.monthBox}) : super([]) {
    getMonths();
  }
  Box<Month> monthBox;

  getMonths() {
    List<Month> months = monthBox.values.toList();
    emit(months);
  }

  static Month getMonthDetailData(Month month) {
    month.days.removeWhere((key, value) {
      return key.weekday == 6 || key.weekday == 7;
    });
    return month;
  }

  // ----------------------------------------------------------------------------------------
  registerAttendance() {
    // get today's date
    DateTime thisDate = DateTime.now();
    try {
      // check and get this month in the database
      // update month data
      updateMonthData(thisDate);
      getMonths();
    } catch (e) {
      //if month doesn't already exist in database, create and save it.
      int daysInMonth = DateTime(thisDate.year, thisDate.month + 1, 0).day;
      Map<DateTime, bool> days = {};
      for (int i = 0; i < daysInMonth; i++) {
        days.addAll({
          DateTime(thisDate.year, thisDate.month).add(Duration(days: i)): false
        });
      }
      days[DateTime(thisDate.year, thisDate.month, thisDate.day)] = true;
      Month thisMonth =
          Month(date: DateTime(thisDate.year, thisDate.month), days: days);
      monthBox.add(thisMonth);
      getMonths();
    }
    // check if a month object of that date already extits
    // if so, change this day in the days to true
    // if not, create month object, with this date
    // change this day to rue
  }

  // ----------------------------------------------------------------------------------------
  updateMonthData(thisDate) {
    Month thisMonth = monthBox.values.singleWhere((month) =>
        DateTime(
          month.date.year,
          month.date.month,
        ) ==
        DateTime(
          thisDate.year,
          thisDate.month,
        ));
    // if this month exists, change today's value to true

    for (DateTime day in thisMonth.days.keys) {
      if (day == DateTime(thisDate.year, thisDate.month, thisDate.day)) {
        thisMonth.days[day] = true;
        thisMonth.save();
        break;
      }
    }
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
