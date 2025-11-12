import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../routes/routes.dart';

class RegistrationController extends GetxController {
  final isLoading = false.obs;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();

  void showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  bool validateForm() {
    if (usernameController.text.isEmpty) {
      showToast('Username is required', isError: true);
      return false;
    }
    if (emailController.text.isEmpty) {
      showToast('Email is required', isError: true);
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      showToast('Enter a valid email address', isError: true);
      return false;
    }
    if (mobileController.text.isEmpty) {
      showToast('Mobile number is required', isError: true);
      return false;
    }
    if (mobileController.text.length != 10) {
      showToast('Mobile number must be 10 digits', isError: true);
      return false;
    }
    if (addressController.text.isEmpty) {
      showToast('Address is required', isError: true);
      return false;
    }
    if (cityController.text.isEmpty) {
      showToast('City is required', isError: true);
      return false;
    }
    if (pincodeController.text.isEmpty) {
      showToast('PIN code is required', isError: true);
      return false;
    }
    if (pincodeController.text.length != 6) {
      showToast('PIN code must be 6 digits', isError: true);
      return false;
    }
    return true;
  }

  Future<void> registerUser() async {
    if (!validateForm()) return;

    isLoading.value = true;

    final uri = Uri.parse(
      'http://192.168.0.118/har_bhole_farsan/api/register.php',
    );

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "full_name": usernameController.text.trim(),
          "email": emailController.text.trim(),
          "mobile": mobileController.text.trim(),
          "address": addressController.text.trim(),
          "city": cityController.text.trim(),
          "pincode": pincodeController.text.trim(),
        }),
      );

      log("🟠 Registration Request: ${uri.toString()}");
      log(
        "🟠 Registration Body: ${{"full_name": usernameController.text.trim(), "email": emailController.text.trim(), "mobile": mobileController.text.trim(), "address": addressController.text.trim(), "city": cityController.text.trim(), "pincode": pincodeController.text.trim()}}",
      );

      log("🟣 Response Status: ${response.statusCode}");
      log("🟣 Response Body: ${response.body}");

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          showToast('✅ Registration successful!');

          final userData = jsonResponse['user'];
          log(
            "👤 Registered User: ${userData['name']} (${userData['customer_code']})",
          );

          // ✅ Navigate to bottom navigation bar
          log("🔄 Navigating to: ${Routes.bottomNavigationBar}");
          Get.offAllNamed(Routes.bottomNavigationBar);
        } else {
          final errorMessage =
              jsonResponse['error'] ??
              jsonResponse['message'] ??
              '❌ Registration failed';
          showToast(errorMessage, isError: true);
        }
      } else {
        showToast('❌ Server error: ${response.statusCode}', isError: true);
      }
    } catch (e) {
      isLoading.value = false;
      log("❌ Registration error: $e");
      showToast('❌ Network error: Please check your connection', isError: true);
    }
  }

  void clearForm() {
    usernameController.clear();
    emailController.clear();
    mobileController.clear();
    addressController.clear();
    cityController.clear();
    pincodeController.clear();
  }
}
