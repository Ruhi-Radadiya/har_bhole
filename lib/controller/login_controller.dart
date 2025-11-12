import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../routes/routes.dart';
import '../view/screens/bottom_navigation_bar.dart';

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

  /// ✅ Check if mobile number exists and send OTP
  Future<void> requestOtp(String mobile) async {
    try {
      if (mobile.isEmpty || mobile.length != 10) {
        Get.snackbar("Invalid", "Please enter a valid 10-digit number");
        return;
      }

      isLoading(true);

      final response = await http.post(
        Uri.parse("http://192.168.0.118/har_bhole_farsan/api/login_api.php"),
        body: {
          "mobile": mobile,
          "otp": "", // Send empty string for OTP request
        },
      );

      log("📩 OTP Request Response: ${response.body}");
      final data = jsonDecode(response.body);

      // ✅ Check if mobile exists (success response)
      if (data["status"] == "success" ||
          (data["message"]?.toString().toLowerCase().contains("otp") ??
              false) ||
          (data["message"]?.toString().toLowerCase().contains("sent") ??
              false)) {
        mobileNumber.value = mobile;
        Get.snackbar("Success", "OTP sent successfully!");
        Get.toNamed(Routes.logInOTPScreen);
      } else if (data["message"]?.toString().toLowerCase().contains(
            "not found",
          ) ??
          false) {
        Get.snackbar(
          "Not Found",
          "Mobile number not registered. Please sign up first.",
        );
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed to send OTP");
      }
    } catch (e) {
      log("❌ Error requesting OTP: $e");
      Get.snackbar("Error", "Network error: Please check your connection");
    } finally {
      isLoading(false);
    }
  }

  /// ✅ Verify OTP and Login
  Future<void> verifyOtp(String otp) async {
    try {
      if (otp.isEmpty || otp.length != 6) {
        Get.snackbar("Invalid", "Please enter 6-digit OTP");
        return;
      }

      isLoading(true);

      log("🔐 Verifying OTP: $otp for mobile: ${mobileNumber.value}");

      // ✅ Fixed OTP for testing (you can remove this in production)
      if (otp == "123456") {
        log("🎯 Using fixed OTP flow");
        await _handleFixedOtpLogin();
        return;
      }

      final response = await http.post(
        Uri.parse("http://192.168.0.118/har_bhole_farsan/api/login_api.php"),
        body: {"mobile": mobileNumber.value, "otp": otp},
      );

      log("🔹 Login Response Status: ${response.statusCode}");
      log("🔹 Login Response Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        log("✅ API Login Success - Processing user data...");
        await _handleSuccessfulLogin(data);
      } else {
        log("❌ API Login Failed: ${data["message"]}");
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
      final user = data["user"];

      // Extract user data
      token.value = data["token"] ?? "";
      userId.value = int.tryParse(user["user_id"]?.toString() ?? "0") ?? 0;
      name.value = user["name"] ?? "";
      email.value = user["email"] ?? "";
      mobileNumber.value = user["mobile_number"] ?? mobileNumber.value;

      // ✅ Determine user role based on user_id or email
      userRole.value = _determineUserRole(userId.value, email.value);

      // Save user data
      _saveUserToStorage();

      log("✅ Login Successful - User: ${name.value}, Role: ${userRole.value}");
      log("🔄 Attempting navigation to bottom navigation bar...");

      Get.snackbar("Success", "Login successful! Welcome ${name.value}");

      // Wait a bit for snackbar to show
      await Future.delayed(const Duration(milliseconds: 500));

      // Try navigation with multiple approaches
      await _navigateToHome();
    } catch (e) {
      log("❌ Error in successful login handler: $e");
      Get.snackbar("Error", "Login successful but navigation failed");
    }
  }

  /// ✅ Navigate to home screen with multiple fallbacks
  Future<void> _navigateToHome() async {
    try {
      log("📍 Attempting Method 1: Get.offAll with widget");
      Get.offAll(() => const BottomNavigationBarScreen());
      log("🎉 Navigation Method 1 Successful!");
      return;
    } catch (e) {
      log("❌ Method 1 failed: $e");
    }

    try {
      log("📍 Attempting Method 2: Get.offAllNamed");
      Get.offAllNamed(Routes.bottomNavigationBar);
      log("🎉 Navigation Method 2 Successful!");
      return;
    } catch (e) {
      log("❌ Method 2 failed: $e");
    }

    try {
      log("📍 Attempting Method 3: Get.offUntil");
      Get.offUntil(
        GetPageRoute(page: () => const BottomNavigationBarScreen()),
        (route) => false,
      );
      log("🎉 Navigation Method 3 Successful!");
      return;
    } catch (e) {
      log("❌ Method 3 failed: $e");
    }

    // Final fallback
    log("⚠️ All navigation methods failed, using basic navigation");
    Get.offAll(() => const BottomNavigationBarScreen());
  }

  /// ✅ Determine if user is admin or customer
  UserRole _determineUserRole(int userId, String email) {
    log("🔍 Determining user role - UserID: $userId, Email: $email");

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

    // Method 3: Check by mobile number (if you have specific admin numbers)
    if (mobileNumber.value == "1234567891") {
      log("👑 User determined as ADMIN by Mobile");
      return UserRole.admin;
    }

    // Default to customer
    log("👤 User determined as CUSTOMER");
    return UserRole.customer;
  }

  /// ✅ Handle fixed OTP login (for testing)
  Future<void> _handleFixedOtpLogin() async {
    log("🔧 Handling fixed OTP login for mobile: ${mobileNumber.value}");

    // For fixed OTP "123456", we need to determine if it's admin or customer
    if (mobileNumber.value == "1234567891") {
      // Admin login with fixed OTP
      userId.value = 1;
      name.value = "Admin";
      email.value = "admin@gmail.com";
      mobileNumber.value = "1234567891";
      token.value = "admin_fixed_token_123";
      userRole.value = UserRole.admin;

      _saveUserToStorage();

      log("👑 Fixed OTP Admin Login Successful");
      Get.snackbar("Success", "Logged in as Admin (Fixed OTP)");

      await Future.delayed(const Duration(milliseconds: 500));
      await _navigateToHome();
    } else {
      // Customer login with fixed OTP - we need to verify with API
      log("🔧 Attempting API verification for fixed OTP customer");

      final response = await http.post(
        Uri.parse("http://192.168.0.118/har_bhole_farsan/api/login_api.php"),
        body: {
          "mobile": mobileNumber.value,
          "otp": "123456", // Send the fixed OTP to API
        },
      );

      log("🔹 Fixed OTP API Response: ${response.body}");
      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        await _handleSuccessfulLogin(data);
      } else {
        // If API fails with fixed OTP, treat as test customer
        log("🔧 Creating test customer for fixed OTP");

        userId.value = 2;
        name.value = "Test Customer";
        email.value = "customer@test.com";
        token.value = "customer_fixed_token_123";
        userRole.value = UserRole.customer;

        _saveUserToStorage();

        log("👤 Fixed OTP Customer Login Successful (Test Mode)");
        Get.snackbar("Success", "Logged in as Customer (Test Mode)");

        await Future.delayed(const Duration(milliseconds: 500));
        await _navigateToHome();
      }
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
