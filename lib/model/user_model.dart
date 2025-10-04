class UserModel {
  final String userCode;
  final String name;
  final String email;
  final String password;
  final String contact;
  final String designation;
  final String address;
  final String joiningDate;
  final String salary;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String aadharNumber;
  final String userImage;
  final String chequebookImage;
  final DateTime createdAt;
  final bool isActive; // Add this property

  UserModel({
    required this.userCode,
    required this.name,
    required this.email,
    required this.password,
    required this.contact,
    required this.designation,
    required this.address,
    required this.joiningDate,
    required this.salary,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.aadharNumber,
    required this.userImage,
    required this.chequebookImage,
    required this.createdAt,
    this.isActive = true, // Default to active
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userCode': userCode,
      'name': name,
      'email': email,
      'password': password,
      'contact': contact,
      'designation': designation,
      'address': address,
      'joiningDate': joiningDate,
      'salary': salary,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'ifscCode': ifscCode,
      'aadharNumber': aadharNumber,
      'userImage': userImage,
      'chequebookImage': chequebookImage,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive, // Include isActive in JSON
    };
  }

  // Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userCode: json['userCode'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      contact: json['contact'] ?? '',
      designation: json['designation'] ?? '',
      address: json['address'] ?? '',
      joiningDate: json['joiningDate'] ?? '',
      salary: json['salary'] ?? '',
      bankName: json['bankName'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      ifscCode: json['ifscCode'] ?? '',
      aadharNumber: json['aadharNumber'] ?? '',
      userImage: json['userImage'] ?? '',
      chequebookImage: json['chequebookImage'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      isActive: json['isActive'] ?? true, // Load isActive from JSON
    );
  }
}
