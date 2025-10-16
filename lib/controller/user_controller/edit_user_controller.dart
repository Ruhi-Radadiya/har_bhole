import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../users_controller/dashboard_users_controller.dart';

class EditUserController extends GetxController {
  final isLoading = false.obs;

  // User ID for editing
  final userId = "".obs;

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
  final joiningDate = ''.obs;

  // API endpoint
  final String apiUrl =
      "https://harbhole.eihlims.com/Api/user_api.php?action=edit";

  void setUserId(String id) {
    userId.value = id;
  }

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

  // ✅ Validate all required fields before API call
  bool validateForm() {
    if (userId.value.isEmpty) {
      showToast('User ID is required');
      return false;
    }
    if (userCodeController.text.isEmpty) {
      showToast('User code is required');
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

  // 🚀 Function to send POST request
  Future<void> updateUser() async {
    if (!validateForm()) return;

    try {
      isLoading.value = true;

      final Map<String, dynamic> body = {
        "action": "edit",
        "user_id": userId.value,
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
        "ui_prefs": jsonEncode({"appTheme": "light", "colorTheme": "orange"}),
      };

      final response = await http.post(Uri.parse(apiUrl), body: body);

      log('Response Body: ${response.body}');
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['success'] == true) {
          showToast('✅ User updated successfully!');
          
          // Refresh dashboard users
          await DashboardUsersController.instance.fetchUsers();

          Get.back();
        } else {
          showToast('❌ ${data['message'] ?? 'Failed to update user'}');
          log('Error: ${data['message']}');
        }
      } else {
        showToast('❌ Failed to update user (${response.statusCode})');
      }

      log('Response: ${response.body}');
    } catch (e) {
      showToast('⚠️ Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // 🧹 Clear all form data
  void clearForm() {
    userId.value = "";
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
}