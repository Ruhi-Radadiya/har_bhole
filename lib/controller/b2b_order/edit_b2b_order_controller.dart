import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditB2BOrderController extends GetxController {
  // Order ID for editing
  final orderId = "".obs;

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

  void setOrderId(String id) {
    orderId.value = id;
  }

  /// 🟢 This method is called when "Update Order" is tapped
  Future<void> updateB2BOrder() async {
    if (orderId.value.isEmpty) {
      Get.snackbar('Error', 'Order ID is required');
      return;
    }

    final url = Uri.parse(
      "https://harbhole.eihlims.com/Api/b2b_orders_api.php?action=edit",
    );

    // Build item object from the Order Items section
    final Map<String, dynamic> orderItem = {
      "product_id": 1, // you can replace with real product ID later
      "product_name": productController.text,
      "variation_id": 0,
      "variation_name": variationController.text,
      "variation_value": "",
      "quantity": double.tryParse(quantityController.text) ?? 0,
      "price": double.tryParse(priceController.text) ?? 0,
      "total": double.tryParse(totalController.text) ?? 0,
      "gst": double.tryParse(gstController.text) ?? 0,
    };

    // Combine everything in the final body
    final Map<String, dynamic> body = {
      "order_id": orderId.value,
      "customer_name": customerNameController.text,
      "customer_email": customerEmailController.text,
      "customer_phone": customerPhoneController.text,
      "customer_address": customerAddressController.text,
      "customer_company": customerCompanyController.text,
      "customer_gst": customerGstController.text,
      "status": statusController.text,
      "payment_status": paymentStatusController.text,
      "total_amount": double.tryParse(totalAmountController.text) ?? 0.0,
      "items": [orderItem], // 👈 single item added here automatically
    };

    try {
      isLoading.value = true;

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        Get.snackbar(
          "Success",
          "Order updated successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error",
          data["message"] ?? "Failed to update order",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearAll() {
    orderId.value = "";
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
  }
}