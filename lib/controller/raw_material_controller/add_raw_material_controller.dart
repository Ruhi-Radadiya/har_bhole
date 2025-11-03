import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:har_bhole/main.dart';
import 'package:http/http.dart' as http;

class AddRawMaterialController extends GetxController {
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
  final createdByController = TextEditingController();

  RxBool isLoading = false.obs;
  var selectedCategory = ''.obs;
  var selectedSupplier = RxnInt();
  var selectedUnit = RxnInt();
  var selectedStatus = ''.obs;
  var descriptionText = ''.obs;
  var materialImagePath = ''.obs;

  var selectSupplierName = ''.obs;
  var selectSupplierId = ''.obs;
  final String postApiUrl =
      'https://harbhole.eihlims.com/Api/raw_material_api.php?action=add';
  final String getApiUrl =
      'https://harbhole.eihlims.com/Api/raw_material_api.php?action=list';

  @override
  void onInit() {
    super.onInit();
    generateNextMaterialCode(); // auto-generate code when controller starts
  }

  void setSupplier({required String id, required String name}) {
    selectSupplierId.value = id;
    selectSupplierName.value = name;
  }

  /// ✅ Generate next sequential material code (e.g. RM015 → RM016)
  Future<void> generateNextMaterialCode() async {
    try {
      final response = await http.get(Uri.parse(getApiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true && data['items'] != null) {
          // Sort to find the highest material_code
          final items = List.from(data['items']);
          if (items.isNotEmpty) {
            items.sort(
              (a, b) => a['material_code'].toString().compareTo(
                b['material_code'].toString(),
              ),
            );

            // Get the last material code (highest)
            final lastCode = items.last['material_code']
                .toString(); // e.g. RM015

            // Extract the numeric part
            final numberPart =
                int.tryParse(lastCode.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

            // Increment it
            final nextNumber = numberPart + 1;

            // Format it with leading zeros (e.g. RM016)
            final newCode = 'RM${nextNumber.toString().padLeft(3, '0')}';

            materialCodeController.text = newCode;
          } else {
            // If no items exist yet
            materialCodeController.text = 'RM001';
          }
        } else {
          materialCodeController.text = 'RM001';
        }
      } else {
        materialCodeController.text = 'RM001';
      }
    } catch (e) {
      log('Error generating next code: $e');
      materialCodeController.text = 'RM001';
    }
  }

  /// ✅ Submit data to API
  Future<void> addRawMaterial() async {
    try {
      isLoading.value = true;

      final body = {
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
        "created_by": int.tryParse(createdByController.text) ?? 1,
      };

      final response = await http.post(
        Uri.parse(postApiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Raw material added successfully");
        rawMaterialController.fetchRawMaterials();
        log(
          "Raw material added successfully with status code: ${response.statusCode}",
        );

        clearFields();
        await generateNextMaterialCode();
      } else {
        Get.snackbar("Error", "Failed to add material: ${response.statusCode}");
        log("Failed to add material: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      log("Error adding material: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Clear all fields except material code
  void clearFields() {
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
    createdByController.clear();
    selectSupplierId.value = '';
    selectSupplierName.value = '';
  }
}
