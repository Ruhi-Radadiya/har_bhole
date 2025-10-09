class B2BUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String company;
  final String gstin;
  final String address;
  final String status;

  B2BUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.gstin,
    required this.address,
    required this.status,
  });

  factory B2BUser.fromJson(Map<String, dynamic> json) {
    return B2BUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      company: json['company'],
      gstin: json['gstin'],
      address: json['address'],
      status: json['status'],
    );
  }
}
