class User {
  String name;
  String portfolio;
  String department;
  String profileUrl;

  User({
    this.name = "",
    this.portfolio = "",
    this.department = "",
    this.profileUrl = "",
  });

  static User user = User(
    name: "Diana Asebagu",
    portfolio: "Managing Director",
    department: "Finance",
    profileUrl: "",
  );

  Map<String, String?> toMap() => {
        "name": name,
        "portfolio": portfolio,
        "department": department,
      };
}
