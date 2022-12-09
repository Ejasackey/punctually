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

  factory User.fromMap(Map<String, dynamic>? map) {
    return User(
      name: map!['name'],
      portfolio: map['portfolio'],
      profileUrl: map['profile_url'],
    );
  }

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
