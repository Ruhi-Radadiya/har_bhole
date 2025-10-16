import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../users_controller/dashboard_users_controller.dart';

class DeleteUserController extends GetxController {
  final isLoading = false.obs;

  // User ID for deleting
  final userId = "".obs;

  // API endpoint
  final String apiUrl =
      "https://harbhole.eihlims.com/Api/user_api.php?action=delete";

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

  // ✅ Validate user ID
  bool validateUserId() {
    if (userId.value.isEmpty) {
      showToast('User ID is required');
      return false;
    }
    return true;
  }

  // 🚀 Function to delete user
  Future<void> deleteUser() async {
    if (!validateUserId()) return;

    try {
      isLoading.value = true;

      final Map<String, dynamic> body = {
        "action": "delete",
        "user_id": userId.value,
      };

      final response = await http.post(Uri.parse(apiUrl), body: body);

      log('Response Body: ${response.body}');
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['success'] == true) {
          showToast('✅ User deleted successfully!');
          
          // Refresh dashboard users
          await DashboardUsersController.instance.fetchUsers();

          Get.back();
        } else {
          showToast('❌ ${data['message'] ?? 'Failed to delete user'}');
          log('Error: ${data['message']}');
        }
      } else {
        showToast('❌ Failed to delete user (${response.statusCode})');
      }

      log('Response: ${response.body}');
    } catch (e) {
      showToast('⚠️ Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // 🚀 Function to delete user with confirmation
  Future<void> deleteUserWithConfirmation() async {
    Get.dialog(
      AlertDialog(
        title: Text('Delete User'),
        content: Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              deleteUser();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}