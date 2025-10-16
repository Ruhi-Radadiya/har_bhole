import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:har_bhole/main.dart';
import 'package:http/http.dart' as http;

class DeleteRawMaterialController extends GetxController {
  // Material ID for deleting
  final materialId = "".obs;

  RxBool isLoading = false.obs;

  final String deleteApiUrl =
      'https://harbhole.eihlims.com/Api/raw_material_api.php?action=delete';

  void setMaterialId(String id) {
    materialId.value = id;
  }

  /// ✅ Delete raw material
  Future<void> deleteRawMaterial() async {
    if (materialId.value.isEmpty) {
      Get.snackbar('Error', 'Material ID is required');
      return;
    }

    try {
      isLoading.value = true;

      final body = {
        "material_id": materialId.value,
      };

      final response = await http.post(
        Uri.parse(deleteApiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Raw material deleted successfully");
        rawMaterialController.fetchRawMaterials();
        Get.back();
        log(
          "Raw material deleted successfully with status code: ${response.statusCode}",
        );
      } else {
        Get.snackbar("Error", "Failed to delete material: ${response.statusCode}");
        log("Failed to delete material: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      log("Error deleting material: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Delete raw material with confirmation
  Future<void> deleteRawMaterialWithConfirmation() async {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Raw Material'),
        content: Text('Are you sure you want to delete this raw material?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              deleteRawMaterial();
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}