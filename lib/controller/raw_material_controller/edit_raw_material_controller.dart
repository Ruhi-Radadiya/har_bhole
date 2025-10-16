import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:har_bhole/main.dart';
import 'package:http/http.dart' as http;

class EditRawMaterialController extends GetxController {
  // Material ID for editing
  final materialId = "".obs;

  // Form controllers
  final materialCodeController = TextEditingController();
  final materialNameController = TextEditingController();
  final categoryIdController = TextEditingController();
  final currentQuantityController = TextEditingController();
  final unitOfMeasureController = TextEditingController();
  final minStockLevelController = TextEditingController();
  final maxStockLevelController = TextEditingController();
  final reorderPointController = TextEditingController();
  final costPriceController = TextEditingController();
  final supplierIdController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final statusController = TextEditingController();

  RxBool isLoading = false.obs;
  var selectedCategory = ''.obs;
  var selectedSupplier = RxnInt();
  var selectedUnit = RxnInt();
  var selectedStatus = ''.obs;
  var descriptionText = ''.obs;
  var materialImagePath = ''.obs;

  final String editApiUrl =
      'https://harbhole.eihlims.com/Api/raw_material_api.php?action=edit';

  void setMaterialId(String id) {
    materialId.value = id;
  }

  /// ✅ Update raw material
  Future<void> updateRawMaterial() async {
    if (materialId.value.isEmpty) {
      Get.snackbar('Error', 'Material ID is required');
      return;
    }

    try {
      isLoading.value = true;

      final body = {
        "material_id": materialId.value,
        "material_code": materialCodeController.text,
        "material_name": materialNameController.text,
        "category_id": int.tryParse(categoryIdController.text) ?? 0,
        "current_quantity":
            double.tryParse(currentQuantityController.text) ?? 0.0,
        "unit_of_measure": unitOfMeasureController.text,
        "min_stock_level": int.tryParse(minStockLevelController.text) ?? 0,
        "max_stock_level": int.tryParse(maxStockLevelController.text) ?? 0,
        "reorder_point": int.tryParse(reorderPointController.text) ?? 0,
        "cost_price": double.tryParse(costPriceController.text) ?? 0.0,
        "supplier_id": int.tryParse(supplierIdController.text) ?? 0,
        "location": locationController.text,
        "description": descriptionController.text,
        "status": int.tryParse(statusController.text) ?? 1,
        "updated_by": 1,
      };

      final response = await http.post(
        Uri.parse(editApiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Raw material updated successfully");
        rawMaterialController.fetchRawMaterials();
        log(
          "Raw material updated successfully with status code: ${response.statusCode}",
        );
      } else {
        Get.snackbar("Error", "Failed to update material: ${response.statusCode}");
        log("Failed to update material: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      log("Error updating material: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Clear all fields
  void clearFields() {
    materialId.value = "";
    materialCodeController.clear();
    materialNameController.clear();
    categoryIdController.clear();
    currentQuantityController.clear();
    unitOfMeasureController.clear();
    minStockLevelController.clear();
    maxStockLevelController.clear();
    reorderPointController.clear();
    costPriceController.clear();
    supplierIdController.clear();
    locationController.clear();
    descriptionController.clear();
    statusController.clear();
  }
}