import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteFinishedGoodsStockController extends GetxController {
  // Product ID for deleting
  final productId = "".obs;

  RxBool isLoading = false.obs;

  final String apiUrl =
      'https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=delete';

  void setProductId(String id) {
    productId.value = id;
  }

  /// ✅ Delete finished goods stock
  Future<void> deleteFinishedGoodsStock() async {
    if (productId.value.isEmpty) {
      Get.snackbar('Error', 'Product ID is required');
      return;
    }

    try {
      isLoading.value = true;

      final body = {
        "product_id": productId.value,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Finished goods stock deleted successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.back();
        log(
          "Finished goods stock deleted successfully with status code: ${response.statusCode}",
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete stock: ${response.statusCode}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        log("Failed to delete stock: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      log("Error deleting stock: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Delete finished goods stock with confirmation
  Future<void> deleteFinishedGoodsStockWithConfirmation() async {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Finished Goods Stock'),
        content: Text('Are you sure you want to delete this finished goods stock?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              deleteFinishedGoodsStock();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}