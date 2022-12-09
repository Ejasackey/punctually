class Organization {
  String name;
  String qrCode;

  Organization({required this.name, required this.qrCode});

  factory Organization.fromMap(Map<String, dynamic>? map) {
    return Organization(
      name: map!['name'],
      qrCode: map['qr_code'],
    );
  }
}
