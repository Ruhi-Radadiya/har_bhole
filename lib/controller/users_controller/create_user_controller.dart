import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import '../../model/user_model/dashboard_user_model.dart';

class CreateUserController extends GetxController {
  final isLoading = false.obs;

  // Reactive file fields
  var userImage = Rx<File?>(null);
  var chequebookImage = Rx<File?>(null);

  // For edit mode
  String? editingUserId;

  // Controllers
  final userCodeController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final contactController = TextEditingController();
  final addressController = TextEditingController();
  final designationController = TextEditingController();
  final joiningDateController = TextEditingController();
  final salaryController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final aadharNumberController = TextEditingController();

  // Designation options
  final List<String> designationOptions = [
    'Manager',
    'Supervisor',
    'Employee',
    'Admin',
    'Accountant',
    'Sales Executive',
    'Marketing Manager',
    'HR Manager',
    'IT Support',
    'Operations Manager',
    'Team Lead',
    'Developer',
    'Designer',
    'Analyst',
    'Consultant',
  ];

  var selectedDesignation = ''.obs;

  // 🧩 Toast helper
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  // ✅ Validation (auto-generate user code if missing)
  bool validateForm({bool isEdit = false}) {
    // Auto-generate user code if empty
    if (userCodeController.text.isEmpty) {
      showToast('Generating user code...');
      generateNextUserCode();
      return false;
    }

    if (nameController.text.isEmpty) {
      showToast('Name is required');
      return false;
    }
    if (emailController.text.isEmpty) {
      showToast('Email is required');
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      showToast('Enter a valid email');
      return false;
    }
    if (!isEdit && passwordController.text.isEmpty) {
      showToast('Password is required');
      return false;
    }
    if (contactController.text.isEmpty) {
      showToast('Contact number is required');
      return false;
    }
    if (contactController.text.length != 10) {
      showToast('Contact number must be 10 digits');
      return false;
    }
    if (addressController.text.isEmpty) {
      showToast('Address is required');
      return false;
    }
    if (selectedDesignation.value.isEmpty) {
      showToast('Please select a designation');
      return false;
    }
    if (joiningDateController.text.isEmpty) {
      showToast('Joining date is required');
      return false;
    }
    if (salaryController.text.isEmpty) {
      showToast('Salary is required');
      return false;
    }
    if (bankNameController.text.isEmpty) {
      showToast('Bank name is required');
      return false;
    }
    if (accountNumberController.text.isEmpty) {
      showToast('Account number is required');
      return false;
    }
    if (ifscCodeController.text.isEmpty) {
      showToast('IFSC code is required');
      return false;
    }
    if (aadharNumberController.text.isEmpty) {
      showToast('Aadhar number is required');
      return false;
    }
    if (aadharNumberController.text.length != 12) {
      showToast('Aadhar number must be 12 digits');
      return false;
    }
    return true;
  }

  Future<void> submitForm() async {
    isLoading.value = true;

    final uri = Uri.parse(
      'https://harbhole.eihlims.com/Api/user_api.php?action=add',
    );

    final request = http.MultipartRequest('POST', uri);

    // --- Fields ---
    request.fields.addAll({
      "user_code": userCodeController.text,
      "user_name": nameController.text,
      "user_email": emailController.text,
      "user_password": passwordController.text,
      "user_phone": contactController.text,
      "user_address": addressController.text,
      "designation": selectedDesignation.value,
      "joining_date": joiningDateController.text,
      "salary": salaryController.text,
      "bank_name": bankNameController.text,
      "account_number": accountNumberController.text,
      "ifsc_code": ifscCodeController.text,
      "aadhar_number": aadharNumberController.text,
      "ui_prefs": jsonEncode({"appTheme": "dark", "colorTheme": "blue"}),
    });

    // --- Upload images if any ---
    if (userImage.value != null) {
      request.files.add(
        await http.MultipartFile.fromPath('user_image', userImage.value!.path),
      );
    }

    if (chequebookImage.value != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'chequebook_image',
          chequebookImage.value!.path,
        ),
      );
    }

    log("🟠 Sending multipart request to: $uri");
    log("🟠 Fields: ${request.fields}");

    try {
      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      log("🟣 Response Status: ${response.statusCode}");
      log("🟣 Response Body: $respStr");

      isLoading.value = false;

      final jsonResponse = jsonDecode(respStr);

      if (jsonResponse['success'] == true) {
        Fluttertoast.showToast(msg: 'User added successfully!');
        Get.back();
        dashboardUsersController.fetchUsers(); // refresh list after add
      } else {
        Fluttertoast.showToast(
          msg: jsonResponse['message'] ?? 'Failed to add user',
        );
      }
    } catch (e) {
      isLoading.value = false;
      log("❌ Error submitting user: $e");
      Fluttertoast.showToast(msg: 'Server error');
    }
  }

  Future<void> generateNextUserCode() async {
    try {
      final url = Uri.parse(
        "https://harbhole.eihlims.com/Api/user_api.php?action=list",
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // ✅ Try both possible keys: 'data' or 'items'
        final usersList = (data['data'] ?? data['items'] ?? []) as List;

        if (usersList.isNotEmpty) {
          // Extract user codes like 'U001'
          final codes = usersList
              .map((u) => (u['user_code'] ?? '').toString())
              .where((c) => c.startsWith('U'))
              .toList();

          int maxNum = 0;
          for (final c in codes) {
            final numPart =
                int.tryParse(c.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
            if (numPart > maxNum) maxNum = numPart;
          }

          final newCode = 'U${(maxNum + 1).toString().padLeft(3, '0')}';
          userCodeController.text = newCode;
          log('🆕 Generated user code: $newCode');
        } else {
          userCodeController.text = 'U001';
          log('🆕 Default user code set: U001');
        }
      } else {
        userCodeController.text = 'U001';
        log('⚠️ API returned status ${response.statusCode}');
      }
    } catch (e) {
      log("⚠️ Error generating user code: $e");
      userCodeController.text = 'U001';
    }
  }

  Future<void> updateUser(String? userId) async {
    final idToUse = userId ?? editingUserId;

    if (idToUse == null || idToUse.isEmpty) {
      Get.snackbar("Error", "Missing user ID for update");
      return;
    }

    isLoading(true);
    try {
      final url = Uri.parse(
        "https://harbhole.eihlims.com/Api/user_api.php?action=edit",
      );

      final body = {
        "user_id": idToUse,
        "user_code": userCodeController.text.trim(),
        "user_name": nameController.text.trim(),
        "user_email": emailController.text.trim(),
        "user_password": passwordController.text.trim(),
        "user_phone": contactController.text.trim(),
        "designation": selectedDesignation.value,
        "user_address": addressController.text.trim(),
        "joining_date": joiningDateController.text.trim(),
        "salary": salaryController.text.trim(),
        "bank_name": bankNameController.text.trim(),
        "account_number": accountNumberController.text.trim(),
        "ifsc_code": ifscCodeController.text.trim(),
        "aadhar_number": aadharNumberController.text.trim(),
        "ui_prefs": jsonEncode({"appTheme": "dark", "colorTheme": "blue"}),
      };

      log("🟠 Update body: $body");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: body,
      );

      log("🟣 Update response: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        Fluttertoast.showToast(msg: "✅ User updated successfully");
        await dashboardUsersController.fetchUsers();
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: data["message"] ?? "Failed to update user ❌",
        );
      }
    } catch (e) {
      log("❌ Update error: $e");
      Fluttertoast.showToast(msg: "Server error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteUser(String userId) async {
    if (userId.isEmpty) {
      Fluttertoast.showToast(msg: "User ID is missing!");
      return;
    }

    try {
      final url = Uri.parse(
        "https://harbhole.eihlims.com/Api/user_api.php?action=delete",
      );

      final body = jsonEncode({"user_id": int.parse(userId)});
      log("🟢 Sending delete body: $body");

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json", // ✅ Important
        },
        body: body,
      );

      log("🟠 Delete response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["success"] == true) {
          Fluttertoast.showToast(msg: "User deleted successfully ✅");
          await dashboardUsersController.fetchUsers();
          Get.back();
        } else {
          Fluttertoast.showToast(
            msg: data["message"] ?? "Failed to delete user ❌",
          );
        }
      } else {
        Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
      }
    } catch (e) {
      log("❌ Delete error: $e");
      Fluttertoast.showToast(msg: "Error deleting user: $e");
    }
  }

  void clearForm() {
    editingUserId = null;
    userImage.value = null;
    chequebookImage.value = null;
    userCodeController.clear();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    contactController.clear();
    addressController.clear();
    joiningDateController.clear();
    salaryController.clear();
    bankNameController.clear();
    accountNumberController.clear();
    ifscCodeController.clear();
    aadharNumberController.clear();
    selectedDesignation.value = '';
  }

  // 🔄 Fill fields for edit
  void fillUserData(DashboardUserModel user) {
    editingUserId = user.userId;
    userCodeController.text = user.userCode ?? '';
    nameController.text = user.userName ?? '';
    emailController.text = user.userEmail ?? '';
    contactController.text = user.userPhone ?? '';
    addressController.text = user.userAddress ?? '';
    joiningDateController.text = user.joiningDate ?? '';
    salaryController.text = user.salary ?? '';
    bankNameController.text = user.bankName ?? '';
    accountNumberController.text = user.accountNumber ?? '';
    ifscCodeController.text = user.ifscCode ?? '';
    aadharNumberController.text = user.aadharNumber ?? '';
    selectedDesignation.value = user.designation ?? '';
    log("✏️ Editing user ID: $editingUserId");
  }
}
