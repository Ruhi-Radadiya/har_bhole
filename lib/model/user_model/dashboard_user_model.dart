class DashboardUserModel {
  final String userId;
  final String userCode;
  final String userName;
  final String? userEmail;
  final String? userPhone;
  final String? designation;
  final String? joiningDate;
  final String? salary;

  DashboardUserModel({
    required this.userId,
    required this.userCode,
    required this.userName,
    this.userEmail,
    this.userPhone,
    this.designation,
    this.joiningDate,
    this.salary,
  });

  factory DashboardUserModel.fromJson(Map<String, dynamic> json) {
    return DashboardUserModel(
      userId: json['user_id'] ?? '',
      userCode: json['user_code'] ?? '',
      userName: json['user_name'] ?? '',
      userEmail: json['user_email'],
      userPhone: json['user_phone'],
      designation: json['designation'],
      joiningDate: json['joining_date'],
      salary: json['salary'],
    );
  }
}
