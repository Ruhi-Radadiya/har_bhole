import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:har_bhole/main.dart';
import 'package:http/http.dart' as http;

class AddFinishedGoodsStockController extends GetxController {
  final productCodeController = TextEditingController();
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityProducedController = TextEditingController();
  final totalWeightController = TextEditingController();
  final reorderPointController = TextEditingController();
  final unitOfMeasureController = TextEditingController();
  final weightGramsController = TextEditingController();

  RxString selectedCategory = ''.obs;
  RxString selectedUnit = ''.obs;
  RxString selectedRawMaterial = ''.obs;
  RxString selectedVariantWeight = ''.obs;
  RxList<Map<String, dynamic>> variantsList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> bomList = <Map<String, dynamic>>[].obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  RxBool isLoading = false.obs;

  // 👇 For editing
  String? editingStockId;

  @override
  void onInit() {
    super.onInit();
    weightGramsController.addListener(_updateTotalWeight);
    quantityProducedController.addListener(_updateTotalWeight);
    generateNextProductCode();
  }

  void _updateTotalWeight() {
    double weight = double.tryParse(weightGramsController.text) ?? 0.0;
    int quantity = int.tryParse(quantityProducedController.text) ?? 0;
    double total = weight * quantity;
    totalWeightController.text = total.toStringAsFixed(2);
  }

  // 🟠 FILL FORM FOR EDIT
  void fillFormForEdit(Map<String, dynamic> data) {
    editingStockId = data['stock_id']?.toString(); // store ID for edit

    productCodeController.text = data['product_code'] ?? '';
    productNameController.text = data['product_name'] ?? '';
    descriptionController.text = data['description'] ?? '';
    reorderPointController.text = data['reorder_point'] ?? '';
    unitOfMeasureController.text = data['unit_of_measure'] ?? '';
    weightGramsController.text = data['weight_grams'] ?? '';
    totalWeightController.text = data['produced_total_weight_grams'] ?? '';
    quantityProducedController.text = data['quantity_produced'] ?? '';

    // Parse variants and BOM lists if available
    if (data['variants_json'] != null &&
        data['variants_json'].toString().isNotEmpty) {
      try {
        variantsList.assignAll(
          List<Map<String, dynamic>>.from(jsonDecode(data['variants_json'])),
        );
      } catch (e) {
        variantsList.clear();
      }
    }

    if (data['bom_json'] != null && data['bom_json'].toString().isNotEmpty) {
      try {
        bomList.assignAll(
          List<Map<String, dynamic>>.from(jsonDecode(data['bom_json'])),
        );
      } catch (e) {
        bomList.clear();
      }
    }

    log('✅ Form filled for edit (ID: $editingStockId)');
  }

  // 🟢 ADD NEW
  Future<void> addFinishedGood() async {
    isLoading.value = true;
    const String url =
        "https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=add";

    await _submitFinishedGood(url, isEdit: false);
  }

  // 🟣 EDIT EXISTING
  Future<void> editFinishedGood() async {
    if (editingStockId == null || editingStockId!.isEmpty) {
      Get.snackbar(
        'Error',
        'Stock ID is missing for edit!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    final String url =
        "https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=edit";

    await _submitFinishedGood(url, isEdit: true);
  }

  // COMMON METHOD for both ADD & EDIT
  Future<void> _submitFinishedGood(String url, {required bool isEdit}) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      // Add ID only if editing
      if (isEdit) {
        request.fields['stock_id'] = editingStockId!;
      }

      request.fields['product_code'] = productCodeController.text;
      request.fields['product_name'] = productNameController.text;
      request.fields['category_id'] = '12';
      request.fields['current_quantity'] = '0.00';
      request.fields['unit_of_measure'] =
          unitOfMeasureController.text.isNotEmpty
          ? unitOfMeasureController.text
          : 'kg';
      request.fields['reorder_point'] = reorderPointController.text.isEmpty
          ? '0.000'
          : reorderPointController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['status'] = 'active';
      request.fields['created_by'] = '1';
      request.fields['produced_total_weight_grams'] =
          totalWeightController.text.isEmpty ? '0' : totalWeightController.text;
      request.fields['weight_grams'] = weightGramsController.text.isEmpty
          ? '0'
          : weightGramsController.text;

      request.fields['variants_json'] = jsonEncode(variantsList);
      request.fields['bom_json'] = jsonEncode(bomList);

      if (selectedImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'product_image',
            selectedImage.value!.path,
          ),
        );
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final result = jsonDecode(responseBody);

      if (response.statusCode == 200 && result['success'] == true) {
        Get.snackbar(
          'Success',
          isEdit
              ? 'Finished Good Updated Successfully!'
              : 'Finished Good Added Successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        log('✅ Response: $result');
        finishedGoodsStockController.fetchFinishedGoodsStock();
        clearAllFields();
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          'Failed: ${result['message'] ?? 'Unknown error'}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        log('❌ Failed Response: $result');
      }
    } catch (e, st) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      log('Exception: $e\n$st');
    } finally {
      isLoading.value = false;
    }
  }

  void clearAllFields() {
    productCodeController.clear();
    productNameController.clear();
    descriptionController.clear();
    quantityProducedController.clear();
    totalWeightController.clear();
    reorderPointController.clear();
    unitOfMeasureController.clear();
    selectedCategory.value = '';
    selectedUnit.value = '';
    variantsList.clear();
    bomList.clear();
    selectedImage.value = null;
    weightGramsController.clear();
    selectedRawMaterial.value = '';
    selectedVariantWeight.value = '';
    editingStockId = null;
  }

  Future<void> generateNextProductCode() async {
    const String getApiUrl =
        "https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=list";

    try {
      final response = await http.get(Uri.parse(getApiUrl));
      if (response.statusCode == 200 && response.body.trim().isNotEmpty) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['items'] != null) {
          final items = List.from(data['items']);
          int maxNumber = 0;
          for (var item in items) {
            final code = item['product_code']?.toString() ?? '';
            final numberPart = int.tryParse(
              code.replaceAll(RegExp(r'[^0-9]'), ''),
            );
            if (numberPart != null && numberPart > maxNumber) {
              maxNumber = numberPart;
            }
          }
          final nextNumber = maxNumber + 1;
          productCodeController.text =
              'FG${nextNumber.toString().padLeft(3, '0')}';
        } else {
          productCodeController.text = 'FG001';
        }
      } else {
        productCodeController.text = 'FG001';
      }
    } catch (e, st) {
      log('Error generating code: $e\n$st');
      productCodeController.text = 'FG001';
    }
  }
}
