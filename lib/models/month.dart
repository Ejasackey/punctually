import 'package:hive/hive.dart';
part 'month.g.dart';

@HiveType(typeId: 0)
class Month {
  @HiveField(0)
  DateTime date = DateTime.now();

  @HiveField(1)
  Map<DateTime, bool> days = {};

  Month({required this.date, required this.days});

  static List<Month> months = [
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
    thisMonth,
  ];

  static Month thisMonth = Month(date: DateTime(2022, 9), days: {
    DateTime(2022, 9): false,
    DateTime(2022, 9).add(Duration(days: 1)): true,
    DateTime(2022, 9).add(Duration(days: 2)): true,
    DateTime(2022, 9).add(Duration(days: 3)): true,
    DateTime(2022, 9).add(Duration(days: 4)): true,
    DateTime(2022, 9).add(Duration(days: 5)): true,
    DateTime(2022, 9).add(Duration(days: 6)): false,
    DateTime(2022, 9).add(Duration(days: 7)): false,
    DateTime(2022, 9).add(Duration(days: 8)): false,
    DateTime(2022, 9).add(Duration(days: 9)): false,
    DateTime(2022, 9).add(Duration(days: 10)): false,
    DateTime(2022, 9).add(Duration(days: 11)): false,
    DateTime(2022, 9).add(Duration(days: 12)): false,
    DateTime(2022, 9).add(Duration(days: 13)): false,
    DateTime(2022, 9).add(Duration(days: 14)): false,
    DateTime(2022, 9).add(Duration(days: 15)): false,
    DateTime(2022, 9).add(Duration(days: 16)): false,
    DateTime(2022, 9).add(Duration(days: 17)): false,
    DateTime(2022, 9).add(Duration(days: 18)): false,
    DateTime(2022, 9).add(Duration(days: 19)): false,
    DateTime(2022, 9).add(Duration(days: 20)): false,
    DateTime(2022, 9).add(Duration(days: 21)): false,
    DateTime(2022, 9).add(Duration(days: 22)): false,
    DateTime(2022, 9).add(Duration(days: 23)): false,
    DateTime(2022, 9).add(Duration(days: 24)): false,
    DateTime(2022, 9).add(Duration(days: 25)): false,
    DateTime(2022, 9).add(Duration(days: 26)): false,
    DateTime(2022, 9).add(Duration(days: 27)): false,
    DateTime(2022, 9).add(Duration(days: 28)): false,
    DateTime(2022, 9).add(Duration(days: 29)): false,
  });
}
