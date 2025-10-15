import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Future<void> addFinishedGood() async {
    isLoading.value = true;

    const String url =
        "https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=add";

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      // Required Fields
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

      // Variants JSON
      request.fields['variants_json'] = jsonEncode(variantsList);

      // BOM JSON
      request.fields['bom_json'] = jsonEncode(bomList);

      // Image Upload
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

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Finished Good Added Successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        log('Finished Good Added Successfully: $result');

        // Clear all fields
        clearAllFields();

        // Navigate back or show success UI
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          'Failed to add finished good: ${result['message'] ?? 'Unknown error'}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        log(
          'Failed to add finished good: ${result['message'] ?? 'Unknown error'}',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      log('Something went wrong: $e');
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
  }

  Future<void> generateNextProductCode() async {
    const String getApiUrl =
        "https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=list";

    try {
      final response = await http.get(Uri.parse(getApiUrl));
      log('API Response status: ${response.statusCode}');
      log('API Response body: ${response.body}');

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
          final newCode = 'FG${nextNumber.toString().padLeft(3, '0')}';
          log('Generated product code: $newCode');
          productCodeController.text = newCode;
        } else {
          productCodeController.text = 'FG001';
        }
      } else {
        productCodeController.text = 'FG001';
      }
    } catch (e, stackTrace) {
      log('Error generating next product code: $e', stackTrace: stackTrace);
      productCodeController.text = 'FG001';
    }
  }
}
