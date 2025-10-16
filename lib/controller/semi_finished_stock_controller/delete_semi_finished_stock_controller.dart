import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteSemiFinishedStockController extends GetxController {
  // Stock ID for deleting
  final stockId = "".obs;

  RxBool isLoading = false.obs;

  final String apiUrl =
      'https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=delete';

  void setStockId(String id) {
    stockId.value = id;
  }

  /// ✅ Delete semi-finished stock
  Future<void> deleteSemiFinishedStock() async {
    if (stockId.value.isEmpty) {
      Get.snackbar('Error', 'Stock ID is required');
      return;
    }

    try {
      isLoading.value = true;

      final body = {
        "stock_id": stockId.value,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Semi-finished stock deleted successfully");
        Get.back();
        log(
          "Semi-finished stock deleted successfully with status code: ${response.statusCode}",
        );
      } else {
        Get.snackbar("Error", "Failed to delete stock: ${response.statusCode}");
        log("Failed to delete stock: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      log("Error deleting stock: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Delete semi-finished stock with confirmation
  Future<void> deleteSemiFinishedStockWithConfirmation() async {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Semi-Finished Stock'),
        content: Text('Are you sure you want to delete this stock item?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              deleteSemiFinishedStock();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}