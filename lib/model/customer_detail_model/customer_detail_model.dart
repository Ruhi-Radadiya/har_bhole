class CustomerDetailModel {
  final String id;
  final String customerCode;
  final String name;
  final String email;
  final String mobile;
  final String city;
  final String pincode;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String? lastLoginAt;
  final String loginCount;

  CustomerDetailModel({
    required this.id,
    required this.customerCode,
    required this.name,
    required this.email,
    required this.mobile,
    required this.city,
    required this.pincode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    required this.loginCount,
  });

  factory CustomerDetailModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailModel(
      id: json['id'] ?? '',
      customerCode: json['customer_code'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      city: json['city'] ?? '',
      pincode: json['pincode'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      lastLoginAt: json['last_login_at'],
      loginCount: json['login_count'] ?? '0',
    );
  }
}
