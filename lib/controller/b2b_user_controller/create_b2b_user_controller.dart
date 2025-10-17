import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'b2b_user_controller.dart';

class CreateB2bUserController extends GetxController {
  // ------------------- FORM CONTROLLERS -------------------
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();
  final gstinController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final statusController = TextEditingController();

  // ------------------- LOADING STATE -------------------
  var isLoading = false.obs;

  // ------------------- TOAST FUNCTION -------------------
  void showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? Colors.red.shade400 : Colors.green.shade400,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  // ------------------- ADD B2B USER -------------------
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
          showToast("User added successfully!");
          clearFields();

          // Refresh user list
          if (Get.isRegistered<B2BUserController>()) {
            final userController = Get.find<B2BUserController>();
            await userController.fetchUsers();
          }

          log("User Added: $data");
          Get.back(); // Close form page
        } else {
          showToast(data['message'] ?? "Failed to add user", isError: true);
        }
      } else {
        showToast("Failed to add user: ${response.statusCode}", isError: true);
      }
    } catch (e) {
      showToast("Something went wrong: $e", isError: true);
      log("Add User Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------- UPDATE B2B USER -------------------
  Future<void> updateB2BUser(String userId) async {
    final url = Uri.parse(
      'https://harbhole.eihlims.com/Api/b2busers_api.php?action=edit',
    );

    final body = {
      'id': userId,
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
          showToast("User updated successfully!");
          clearFields();

          // Refresh user list
          if (Get.isRegistered<B2BUserController>()) {
            final userController = Get.find<B2BUserController>();
            await userController.fetchUsers();
          }

          Get.back(); // Close form page
          log("User Updated: $data");
        } else {
          showToast(data['message'] ?? "Failed to update user", isError: true);
        }
      } else {
        showToast(
          "Failed to update user: ${response.statusCode}",
          isError: true,
        );
      }
    } catch (e) {
      showToast("Something went wrong: $e", isError: true);
      log("Update User Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------- DELETE B2B USER -------------------
  Future<void> deleteB2BUser(String userId) async {
    final url = Uri.parse(
      'https://harbhole.eihlims.com/Api/b2busers_api.php?action=delete',
    );

    final body = {'id': userId};

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
          showToast("User deleted successfully!");

          // Refresh user list
          if (Get.isRegistered<B2BUserController>()) {
            final userController = Get.find<B2BUserController>();
            await userController.fetchUsers();
          }

          log("User Deleted: $data");
        } else {
          showToast(data['message'] ?? "Failed to delete user", isError: true);
          log("Delete User Error1: $data");
        }
      } else {
        showToast(
          "Failed to delete user: ${response.statusCode}",
          isError: true,
        );
        log("Delete User Error2: ${response.statusCode}");
      }
    } catch (e) {
      showToast("Something went wrong: $e", isError: true);
      log("Delete User Error3: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ------------------- CLEAR FORM -------------------
  void clearFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    companyController.clear();
    gstinController.clear();
    addressController.clear();
    passwordController.clear();
    statusController.clear();
  } // ------------------- PREFILL USER DATA (FOR UPDATE) -------------------

  void prefillUserData(Map<String, dynamic> user) {
    nameController.text = user['name'] ?? '';
    emailController.text = user['email'] ?? '';
    phoneController.text = user['phone'] ?? '';
    companyController.text = user['company'] ?? '';
    gstinController.text = user['gstin'] ?? '';
    addressController.text = user['address'] ?? '';
    passwordController.text = ''; // keep blank for security
    statusController.text = user['status'] ?? '';
  }
}
