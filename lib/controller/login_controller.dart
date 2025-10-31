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

  /// ✅ Request OTP
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
          "otp": "", // 👈 send empty string instead of omitting
        },
      );

      log("📩 OTP Request Response: ${response.body}");
      final data = jsonDecode(response.body);

      // ✅ If mobile found or OTP sent successfully
      if (data["status"] == "success" ||
          (data["message"]?.toString().toLowerCase().contains("otp") ??
              false)) {
        mobileNumber.value = mobile;
        Get.snackbar("Success", "OTP sent successfully!");
        Get.toNamed(Routes.logInOTPScreen);
      } else {
        Get.snackbar("Invalid", data["message"] ?? "Mobile number not found");
      }
    } catch (e) {
      log("❌ Error requesting OTP: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// ✅ Verify OTP and Login
  Future<void> verifyOtp(String otp) async {
    try {
      isLoading(true);

      if (otp == "123456") {
        await _setAdminData();
        Get.offAll(() => const BottomNavigationBarScreen());
        return;
      }

      final response = await http.post(
        Uri.parse("http://192.168.0.118/har_bhole_farsan/api/login_api.php"),
        body: {"mobile": mobileNumber.value, "otp": otp},
      );

      log("🔹 Login Response: ${response.body}");
      final data = jsonDecode(response.body);

      if (data["status"] == "success") {
        final user = data["user"];

        token.value = data["token"] ?? "";
        userId.value = user["user_id"];
        name.value = user["name"];
        email.value = user["email"];
        mobileNumber.value = user["mobile_number"];
        userRole.value = userId.value == 1 ? UserRole.admin : UserRole.customer;

        _saveUserToStorage();
        Get.offAll(() => const BottomNavigationBarScreen());
      } else {
        Get.snackbar("Invalid", data["message"] ?? "Invalid OTP");
      }
    } catch (e) {
      log("❌ Error verifying OTP: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
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
  }

  /// ✅ Load stored data
  void loadUser() {
    token.value = box.read("token") ?? "";
    userId.value = box.read("user_id") ?? 0;
    name.value = box.read("name") ?? "";
    email.value = box.read("email") ?? "";
    mobileNumber.value = box.read("mobile") ?? "";

    final savedRole = box.read("role");
    if (savedRole != null && savedRole.contains("admin")) {
      userRole.value = UserRole.admin;
    } else if (savedRole != null && savedRole.contains("customer")) {
      userRole.value = UserRole.customer;
    } else {
      userRole.value = UserRole.guest;
    }
  }

  /// ✅ Logout
  void logout() {
    box.erase();
    token.value = "";
    userRole.value = UserRole.guest;
    Get.offAllNamed(Routes.loginScreen);
  }

  /// ✅ Quick Admin login for testing
  Future<void> _setAdminData() async {
    userId.value = 1;
    name.value = "Admin";
    email.value = "admin@gmail.com";
    mobileNumber.value = "1234567891";
    token.value = "test_token_123";
    userRole.value = UserRole.admin;

    _saveUserToStorage();

    Get.snackbar("Success", "Logged in as Admin (Test Mode)");
    Get.offAll(() => const BottomNavigationBarScreen());
  }
}
