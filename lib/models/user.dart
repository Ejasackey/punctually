class User {
  String id;
  String name;
  String portfolio;
  String department;
  String profileUrl;

  User({
    required this.id,
    this.name = "",
    this.portfolio = "",
    this.department = "",
    this.profileUrl = "",
  });

  factory User.fromMap(Map<String, dynamic>? map, id) {
    return User(
      id: id,
      name: map!['name'],
      portfolio: map['portfolio'],
      profileUrl: map['profile_url'],
    );
  }

  Map<String, String?> toMap() => {
        "name": name,
        "portfolio": portfolio,
        "department": department,
      };
}
