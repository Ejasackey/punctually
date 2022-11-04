class User {
  String? name;
  String? portfolio;
  String? department;

  User({this.name, this.portfolio, this.department});

  static User user = User(
    name: "Diana Asebagu",
    portfolio: "Managing Director",
    department: "Finance"
  );
}
