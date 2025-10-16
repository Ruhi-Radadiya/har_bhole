import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteSupplierController extends GetxController {
  // Supplier ID for deleting
  final supplierId = "".obs;

  /// Loading state
  RxBool isLoading = false.obs;

  final String apiUrl =
      'https://harbhole.eihlims.com/Api/suppliers_api.php?action=delete';

  void setSupplierId(String id) {
    supplierId.value = id;
  }

  /// Delete supplier
  Future<void> deleteSupplier() async {
    if (supplierId.value.isEmpty) {
      Get.snackbar('Error', 'Supplier ID is required');
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'supplier_id': supplierId.value,
        }),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      dynamic result;
      try {
        result = jsonDecode(response.body);
      } catch (e) {
        log('Response is not JSON: ${response.body}');
        Get.snackbar(
          'Error',
          'Invalid response from server.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (response.statusCode == 200 && result['success'] == true) {
        Get.snackbar(
          'Success',
          'Supplier deleted successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete supplier: ${result['message'] ?? 'Unknown error'}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      log('Error deleting supplier: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete supplier with confirmation
  Future<void> deleteSupplierWithConfirmation() async {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Supplier'),
        content: Text('Are you sure you want to delete this supplier?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              deleteSupplier();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}