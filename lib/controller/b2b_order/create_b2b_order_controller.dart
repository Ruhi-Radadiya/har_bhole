import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import '../../model/product_model/product_model.dart';

class CreateB2BOrderController extends GetxController {
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
  Rxn<Product> selectedProduct = Rxn<Product>();
  RxDouble unitPrice = 0.0.obs;

  var isLoading = false.obs;

  Future<void> addB2BOrder() async {
    final url = Uri.parse(
      "https://harbhole.eihlims.com/Api/b2b_orders_api.php?action=add",
    );

    final Map<String, dynamic> orderItem = {
      "product_id": 1,
      "product_name": productController.text,
      "variation_id": 0,
      "variation_name": variationController.text,
      "variation_value": "",
      "quantity": double.tryParse(quantityController.text) ?? 0,
      "price": double.tryParse(priceController.text) ?? 0,
      "total": double.tryParse(totalController.text) ?? 0,
      "gst": double.tryParse(gstController.text) ?? 0,
    };

    final Map<String, dynamic> body = {
      "customer_name": customerNameController.text,
      "customer_email": customerEmailController.text,
      "customer_phone": customerPhoneController.text,
      "customer_address": customerAddressController.text,
      "customer_company": customerCompanyController.text,
      "customer_gst": customerGstController.text,
      "status": statusController.text,
      "payment_status": paymentStatusController.text,
      "total_amount": double.tryParse(totalAmountController.text) ?? 0.0,
      "items": [orderItem],
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
        Fluttertoast.showToast(
          msg: "Order created successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xff4CAF50),
          textColor: Colors.white,
        );
        b2bOrderController.fetchOrders();

        clearAll();
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: data["message"] ?? "Failed to add order",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xffF44336),
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xffF44336),
        textColor: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateB2BOrder(String orderId) async {
    final url = Uri.parse(
      "https://harbhole.eihlims.com/Api/b2b_orders_api.php?action=edit",
    );

    final Map<String, dynamic> orderItem = {
      "product_id": 1,
      "product_name": productController.text,
      "variation_id": 0,
      "variation_name": variationController.text,
      "variation_value": "",
      "quantity": double.tryParse(quantityController.text) ?? 0,
      "price": double.tryParse(priceController.text) ?? 0,
      "total": double.tryParse(totalController.text) ?? 0,
      "gst": double.tryParse(gstController.text) ?? 0,
    };

    final Map<String, dynamic> body = {
      "id": orderId,
      "customer_name": customerNameController.text,
      "customer_email": customerEmailController.text,
      "customer_phone": customerPhoneController.text,
      "customer_address": customerAddressController.text,
      "customer_company": customerCompanyController.text,
      "customer_gst": customerGstController.text,
      "status": statusController.text,
      "payment_status": paymentStatusController.text,
      "total_amount": double.tryParse(totalAmountController.text) ?? 0.0,
      "items": [orderItem],
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
        Fluttertoast.showToast(
          msg: "Order updated successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xff4CAF50),
          textColor: Colors.white,
        );
        b2bOrderController.fetchOrders();
        clearAll();
        Get.back();
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: data["message"] ?? "Failed to update order",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xffF44336),
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xffF44336),
        textColor: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteB2bOrder(String orderId) async {
    try {
      final uri = Uri.parse(
        "https://harbhole.eihlims.com/Api/b2b_orders_api.php?action=delete",
      );

      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"}, // important
        body: jsonEncode({"id": orderId}), // send as JSON
      );

      print("🔁 Delete B2B Order Response: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        Fluttertoast.showToast(
          msg: "Order deleted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xff4CAF50),
          textColor: Colors.white,
        );
        return true;
      } else {
        Fluttertoast.showToast(
          msg: data["message"] ?? "Failed to delete order",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xffF44336),
          textColor: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xffF44336),
        textColor: Colors.white,
      );
      return false;
    }
  }

  void updateTotal() {
    // Get quantity from controller
    double quantity =
        double.tryParse(createB2BOrderController.quantityController.text) ?? 0;

    // Use selected product's price if available
    double price =
        createB2BOrderController.selectedProduct.value?.sellingPrice ??
        double.tryParse(createB2BOrderController.priceController.text) ??
        0;

    // Update price field automatically
    createB2BOrderController.priceController.text = price.toStringAsFixed(2);

    // GST
    double gst =
        double.tryParse(createB2BOrderController.gstController.text) ?? 0;

    // Calculate total
    double total = (quantity * price) + gst;

    createB2BOrderController.totalController.text = total.toStringAsFixed(2);
    createB2BOrderController.totalAmountController.text = total.toStringAsFixed(
      2,
    ); // for API
  }

  void clearAll() {
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
