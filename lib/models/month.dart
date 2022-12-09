
class Month {
  DateTime date = DateTime.now();
  Map<DateTime, String> days = {};

  Month({required this.date, required this.days});

  get toMap => {
        'date': date.toIso8601String(),
        'days': days.map((key, value) =>
            MapEntry(key.toIso8601String().substring(0, 19), value)),
      };
}
