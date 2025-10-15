import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CreateB2BOrderController extends GetxController {
  // Controllers for all fields
  final customerNameController = TextEditingController();
  final customerEmailController = TextEditingController();
  final customerPhoneController = TextEditingController();
  final customerAddressController = TextEditingController();
  final customerCompanyController = TextEditingController();
  final customerGstController = TextEditingController();
  final totalAmountController = TextEditingController();
  final statusController = TextEditingController(text: "Pending");
  final paymentStatusController = TextEditingController(text: "Pending");
  final productController = TextEditingController();
  final variationController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final totalController = TextEditingController();
  final gstController = TextEditingController();

  var isLoading = false.obs;

  Future<void> addB2BOrder() async {
    final url = Uri.parse(
      "https://harbhole.eihlims.com/Api/b2b_orders_api.php?action=add",
    );

    final body = {
      "customer_name": customerNameController.text,
      "customer_email": customerEmailController.text,
      "customer_phone": customerPhoneController.text,
      "customer_address": customerAddressController.text,
      "customer_company": customerCompanyController.text,
      "customer_gst": customerGstController.text,
      "total_amount": double.tryParse(totalAmountController.text) ?? 0.0,
      "status": statusController.text,
      "payment_status": paymentStatusController.text,
    };

    try {
      isLoading.value = true;
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["success"] == true) {
          Get.snackbar(
            "Success",
            "Order added successfully!",
            snackPosition: SnackPosition.BOTTOM,
          );

          // Clear all fields
          customerNameController.clear();
          customerEmailController.clear();
          customerPhoneController.clear();
          customerAddressController.clear();
          customerCompanyController.clear();
          customerGstController.clear();
          totalAmountController.clear();
          productController.clear();
          variationController.clear();
          quantityController.clear();
          priceController.clear();
          totalController.clear();
          gstController.clear();

          Get.back();
          log("Order Added: $data");
        } else {
          Get.snackbar(
            "Error",
            data["message"] ?? "Failed to add order",
            snackPosition: SnackPosition.BOTTOM,
          );
          log("Error************: ${data["message"]}");
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to add order: ${response.statusCode}",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      log("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
