import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'b2b_user_controller.dart';

class CreateB2bUserController extends GetxController {
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

  // API POST method
  Future<void> addB2BUser() async {
    final url = Uri.parse(
      'https://harbhole.eihlims.com/Api/b2busers_api.php?action=add',
    );

    final body = {
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
            'User added successfully!',
            snackPosition: SnackPosition.BOTTOM,
          );
          nameController.clear();
          emailController.clear();
          phoneController.clear();
          companyController.clear();
          gstinController.clear();
          addressController.clear();
          passwordController.clear();
          statusController.clear();
          // Refresh user list
          if (Get.isRegistered<B2BUserController>()) {
            final userController = Get.find<B2BUserController>();
            await userController.fetchUsers();
          }
          log("data Added: $data");
          Get.back();
        } else {
          Get.snackbar(
            'Error',
            data['message'] ?? 'Failed to add user',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to add user: ${response.statusCode}',
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
}
