import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'b2b_user_controller.dart';

class EditB2bUserController extends GetxController {
  // User ID for editing
  final userId = "".obs;

  // TextEditingControllers for form fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final gstinController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final statusController = TextEditingController();

  // Loading state
  var isLoading = false.obs;

  void setUserId(String id) {
    userId.value = id;
  }

  // API PUT method
  Future<void> updateB2BUser() async {
    if (userId.value.isEmpty) {
      Get.snackbar('Error', 'User ID is required');
      return;
    }

    final url = Uri.parse(
      'https://harbhole.eihlims.com/Api/b2busers_api.php?action=edit',
    );

    final body = {
      'user_id': userId.value,
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'company': companyController.text,
      'gstin': gstinController.text,
      'address': addressController.text,
      'password_hash': passwordController.text,
      'status': statusController.text,
    };

    try {
      isLoading.value = true;

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          Get.snackbar(
            'Success',
            'User updated successfully!',
            snackPosition: SnackPosition.BOTTOM,
          );
          // Refresh user list
          if (Get.isRegistered<B2BUserController>()) {
            final userController = Get.find<B2BUserController>();
            await userController.fetchUsers();
          }
          log("User updated: $data");
        } else {
          Get.snackbar(
            'Error',
            data['message'] ?? 'Failed to update user',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to update user: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      log("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void clearAllFields() {
    userId.value = "";
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    companyController.clear();
    gstinController.clear();
    addressController.clear();
    passwordController.clear();
    statusController.clear();
  }
}