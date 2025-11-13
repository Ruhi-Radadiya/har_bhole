import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:har_bhole/view/screens/splash_screen/splash_screen.dart';
import 'package:http/http.dart' as http;

import '../routes/routes.dart';

enum UserRole { admin, customer, guest }

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final box = GetStorage();

  var isLoading = false.obs;
  var token = "".obs;
  var userId = 0.obs;
  var name = "".obs;
  var email = "".obs;
  var mobileNumber = "".obs;
  var userRole = UserRole.guest.obs;

  /// ✅ Step 1: Send OTP to mobile number
  Future<void> requestOtp(String mobile) async {
    try {
      if (mobile.isEmpty || mobile.length != 10) {
        Get.snackbar("Invalid", "Please enter a valid 10-digit number");
        return;
      }

      isLoading(true);

      log("📤 Sending OTP to: $mobile");

      final response = await http.post(
        Uri.parse("http://192.168.0.118/har_bhole_farsan/api/send_otp_api.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"mobile_number": mobile}),
      );

      log("📩 Send OTP Response: ${response.body}");
      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        mobileNumber.value = mobile;
        final otp = data["otp"] ?? "123456";
        log("✅ OTP sent successfully: $otp");
        Get.snackbar("Success", "OTP sent successfully! OTP: $otp");
        Get.toNamed(Routes.logInOTPScreen);
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed to send OTP");
      }
    } catch (e) {
      log("❌ Error sending OTP: $e");
      Get.snackbar("Error", "Failed to send OTP. Please try again.");
    } finally {
      isLoading(false);
    }
  }

  /// ✅ Step 2: Verify OTP and Login
  Future<void> verifyOtp(String otp) async {
    try {
      if (otp.isEmpty || otp.length != 6) {
        Get.snackbar("Invalid", "Please enter 6-digit OTP");
        return;
      }

      isLoading(true);

      log("🔐 Verifying OTP: $otp for mobile: ${mobileNumber.value}");

      final response = await http.post(
        Uri.parse(
          "http://192.168.0.118/har_bhole_farsan/api/verify_otp_api.php",
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"mobile_number": mobileNumber.value, "otp": otp}),
      );

      log("🔹 Verify OTP Response Status: ${response.statusCode}");
      log("🔹 Verify OTP Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        log("✅ OTP Verification Success");
        await _handleSuccessfulLogin(data);
      } else {
        log("❌ OTP Verification Failed: ${data["message"]}");
        Get.snackbar("Invalid", data["message"] ?? "Invalid OTP");
      }
    } catch (e) {
      log("❌ Error verifying OTP: $e");
      Get.snackbar("Error", "Network error: Please check your connection");
    } finally {
      isLoading(false);
    }
  }

  /// ✅ Handle successful login
  Future<void> _handleSuccessfulLogin(Map<String, dynamic> data) async {
    try {
      // Extract data from verify OTP response
      token.value = data["token"] ?? "";

      final user = data["user"];
      userId.value = int.tryParse(user["user_id"]?.toString() ?? "0") ?? 0;
      name.value = user["name"] ?? "";
      email.value = user["email"] ?? "";
      mobileNumber.value = user["mobile_number"] ?? mobileNumber.value;

      // ✅ Determine user role
      userRole.value = _determineUserRole(
        userId.value,
        email.value,
        mobileNumber.value,
      );

      // Save user data
      _saveUserToStorage();

      log("✅ Login Successful - User: ${name.value}, Role: ${userRole.value}");
      log("🔄 Attempting navigation to bottom navigation bar...");

      Get.snackbar("Success", "Login successful! Welcome ${name.value}");

      // Wait a bit for snackbar to show
      await Future.delayed(const Duration(milliseconds: 500));

      // Navigate to home
      await _navigateToHome();
    } catch (e) {
      log("❌ Error in successful login handler: $e");
      Get.snackbar("Error", "Login successful but navigation failed");
    }
  }

  /// ✅ Determine if user is admin or customer
  UserRole _determineUserRole(int userId, String email, String mobile) {
    log(
      "🔍 Determining user role - UserID: $userId, Email: $email, Mobile: $mobile",
    );

    // Method 1: Check by user_id (admin usually has ID 1)
    if (userId == 1) {
      log("👑 User determined as ADMIN by UserID");
      return UserRole.admin;
    }

    // Method 2: Check by email pattern
    if (email.toLowerCase().contains("admin") || email == "admin@gmail.com") {
      log("👑 User determined as ADMIN by Email");
      return UserRole.admin;
    }

    // Method 3: Check by mobile number
    if (mobile == "1234567891") {
      log("👑 User determined as ADMIN by Mobile");
      return UserRole.admin;
    }

    // Default to customer
    log("👤 User determined as CUSTOMER");
    return UserRole.customer;
  }

  /// ✅ Navigate to home screen
  Future<void> _navigateToHome() async {
    try {
      log("📍 Navigating to BottomNavigationBarScreen");
      Get.offAll(() => const SplashScreen());
      log("🎉 Navigation Successful!");
    } catch (e) {
      log("❌ Navigation failed: $e");
      // Fallback to named route
      Get.offAllNamed(Routes.splashScreen);
    }
  }

  /// ✅ Save user locally
  void _saveUserToStorage() {
    box.write("token", token.value);
    box.write("user_id", userId.value);
    box.write("name", name.value);
    box.write("email", email.value);
    box.write("mobile", mobileNumber.value);
    box.write("role", userRole.value.toString());

    log("💾 Saved user data to storage: ${name.value} (${userRole.value})");
  }

  /// ✅ Load stored data
  void loadUser() {
    token.value = box.read("token") ?? "";
    userId.value = box.read("user_id") ?? 0;
    name.value = box.read("name") ?? "";
    email.value = box.read("email") ?? "";
    mobileNumber.value = box.read("mobile") ?? "";

    final savedRole = box.read("role");
    if (savedRole != null) {
      if (savedRole.contains("admin")) {
        userRole.value = UserRole.admin;
      } else if (savedRole.contains("customer")) {
        userRole.value = UserRole.customer;
      } else {
        userRole.value = UserRole.guest;
      }
    } else {
      userRole.value = UserRole.guest;
    }

    log("📱 Loaded user from storage: ${name.value} (${userRole.value})");
  }

  /// ✅ Check if user is admin
  bool get isAdmin => userRole.value == UserRole.admin;

  /// ✅ Check if user is logged in
  bool get isLoggedIn => userRole.value != UserRole.guest;

  /// ✅ Logout
  void logout() {
    box.erase();
    token.value = "";
    userId.value = 0;
    name.value = "";
    email.value = "";
    mobileNumber.value = "";
    userRole.value = UserRole.guest;

    log("🚪 User logged out");
    Get.offAllNamed(Routes.loginScreen);
    Get.snackbar("Logged Out", "You have been logged out successfully");
  }

  /// ✅ Quick check for admin access in other parts of app
  static bool hasAdminAccess() {
    return Get.find<LoginController>().isAdmin;
  }
}
