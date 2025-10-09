class DashboardUserModel {
  final String userId;
  final String userCode;
  final String userName;
  final String? userEmail;
  final String? userPhone;
  final String? userAddress;
  final String? designation;
  final String? joiningDate;
  final String? salary;
  final String? bankName;
  final String? accountNumber;
  final String? ifscCode;
  final String? aadharNumber;
  final String? uiPrefs;

  DashboardUserModel({
    required this.userId,
    required this.userCode,
    required this.userName,
    this.userEmail,
    this.userPhone,
    this.userAddress,
    this.designation,
    this.joiningDate,
    this.salary,
    this.bankName,
    this.accountNumber,
    this.ifscCode,
    this.aadharNumber,
    this.uiPrefs,
  });

  factory DashboardUserModel.fromJson(Map<String, dynamic> json) {
    return DashboardUserModel(
      userId: json['user_id'] ?? '',
      userCode: json['user_code'] ?? '',
      userName: json['user_name'] ?? '',
      userEmail: json['user_email'],
      userPhone: json['user_phone'],
      userAddress: json['user_address'],
      designation: json['designation'],
      joiningDate: json['joining_date'],
      salary: json['salary'],
      bankName: json['bank_name'],
      accountNumber: json['account_number'],
      ifscCode: json['ifsc_code'],
      aadharNumber: json['aadhar_number'],
      uiPrefs: json['ui_prefs'],
    );
  }
}
