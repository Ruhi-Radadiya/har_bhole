import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddSemiFinishedStockController extends GetxController {
  // Form controllers
  final stockCodeController = TextEditingController();
  final productNameController = TextEditingController();
  final quantityController = TextEditingController();
  final unitController = TextEditingController();
  final costPriceController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final statusController = TextEditingController();

  RxBool isLoading = false.obs;
  var selectedStatus = ''.obs;

  final String apiUrl =
      'https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=add';

  /// ✅ Submit data to API
  Future<void> addSemiFinishedStock() async {
    try {
      isLoading.value = true;

      final body = {
        "stock_code": stockCodeController.text,
        "product_name": productNameController.text,
        "quantity": double.tryParse(quantityController.text) ?? 0.0,
        "unit": unitController.text,
        "cost_price": double.tryParse(costPriceController.text) ?? 0.0,
        "location": locationController.text,
        "description": descriptionController.text,
        "status": int.tryParse(statusController.text) ?? 1,
        "created_by": 1,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Semi-finished stock added successfully");
        clearFields();
        log(
          "Semi-finished stock added successfully with status code: ${response.statusCode}",
        );
      } else {
        Get.snackbar("Error", "Failed to add stock: ${response.statusCode}");
        log("Failed to add stock: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      log("Error adding stock: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Clear all fields
  void clearFields() {
    stockCodeController.clear();
    productNameController.clear();
    quantityController.clear();
    unitController.clear();
    costPriceController.clear();
    locationController.clear();
    descriptionController.clear();
    statusController.clear();
  }
}