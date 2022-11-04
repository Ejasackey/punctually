import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Month {
  
  @HiveField(0)
  DateTime date = DateTime.now();
  
  @HiveField(1)
  Map<DateTime, bool> days = {};

  Month({required this.date, required this.days});

  static Month thisMonth = Month(date: DateTime(2022, 12), days: {
    DateTime(2023, 1): true,
    DateTime(2023, 1).add(Duration(days: 1)): false,
    DateTime(2023, 1).add(Duration(days: 2)): true,
    DateTime(2023, 1).add(Duration(days: 3)): true,
    DateTime(2023, 1).add(Duration(days: 4)): true,
    DateTime(2023, 1).add(Duration(days: 5)): true,
    DateTime(2023, 1).add(Duration(days: 6)): true,
    DateTime(2023, 1).add(Duration(days: 7)): true,
    DateTime(2023, 1).add(Duration(days: 8)): true,
    DateTime(2023, 1).add(Duration(days: 9)): false,
    DateTime(2023, 1).add(Duration(days: 10)): true,
    DateTime(2023, 1).add(Duration(days: 11)): true,
    DateTime(2023, 1).add(Duration(days: 12)): true,
    DateTime(2023, 1).add(Duration(days: 13)): true,
    DateTime(2023, 1).add(Duration(days: 14)): true,
    DateTime(2023, 1).add(Duration(days: 15)): true,
    DateTime(2023, 1).add(Duration(days: 16)): true,
    DateTime(2023, 1).add(Duration(days: 17)): true,
    DateTime(2023, 1).add(Duration(days: 18)): false,
    DateTime(2023, 1).add(Duration(days: 19)): false,
    DateTime(2023, 1).add(Duration(days: 20)): true,
    DateTime(2023, 1).add(Duration(days: 21)): true,
    DateTime(2023, 1).add(Duration(days: 22)): true,
    DateTime(2023, 1).add(Duration(days: 23)): true,
    DateTime(2023, 1).add(Duration(days: 24)): true,
    DateTime(2023, 1).add(Duration(days: 25)): false,
    DateTime(2023, 1).add(Duration(days: 26)): false,
    DateTime(2023, 1).add(Duration(days: 27)): false,
    DateTime(2023, 1).add(Duration(days: 28)): false,
    DateTime(2023, 1).add(Duration(days: 29)): false,
  });
}
