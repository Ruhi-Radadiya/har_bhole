class DashboardUserModel {
  final String? userId;
  final String? userCode;
  final String? userName;
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
  final String? createdAt;
  final String? updatedAt;
  final Map<String, dynamic>? uiPrefs;
  final String? userImage;
  final String? chequebookImage;

  DashboardUserModel({
    this.userId,
    this.userCode,
    this.userName,
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
    this.createdAt,
    this.updatedAt,
    this.uiPrefs,
    this.userImage,
    this.chequebookImage,
  });

  factory DashboardUserModel.fromJson(Map<String, dynamic> json) {
    return DashboardUserModel(
      userId: json['user_id'],
      userCode: json['user_code'],
      userName: json['user_name'],
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      uiPrefs: json['ui_prefs'] is Map
          ? Map<String, dynamic>.from(json['ui_prefs'])
          : {},
      userImage: json['user_image'],
      chequebookImage: json['chequebook_image'],
    );
  }
}
