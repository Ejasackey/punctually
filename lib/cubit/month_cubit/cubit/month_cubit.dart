import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:punctually/models/month.dart';

part 'month_state.dart';

class MonthCubit extends Cubit<MonthState> {
  MonthCubit() : super(MonthInitial());

  getMonths() {
    return Month.months;
  }

  static Month getMonthDetailData([Month? month]) {
    (month ?? Month.thisMonth).days.removeWhere((key, value) {
      return key.weekday == 6 || key.weekday == 7;
    });

    return Month.thisMonth;
  }

  static double getPercentage(Month month) {
    int att = getMonthDetailData(month).days.values.where((value) => value == true).length;
    return (att / month.days.values.length);
  }

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
