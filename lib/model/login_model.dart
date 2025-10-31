class LoginModel {
  final String status;
  final String message;
  final String token;
  final String tokenExpiresAt;
  final User user;

  LoginModel({
    required this.status,
    required this.message,
    required this.token,
    required this.tokenExpiresAt,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      tokenExpiresAt: json['token_expires_at'] ?? '',
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int userId;
  final String name;
  final String email;
  final String mobileNumber;
  final String status;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
