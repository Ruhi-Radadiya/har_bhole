import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditFinishedGoodsStockController extends GetxController {
  // Product ID for editing
  final productId = "".obs;

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

  void setProductId(String id) {
    productId.value = id;
  }

  @override
  void onInit() {
    super.onInit();
    weightGramsController.addListener(_updateTotalWeight);
    quantityProducedController.addListener(_updateTotalWeight);
  }

  void _updateTotalWeight() {
    double weight = double.tryParse(weightGramsController.text) ?? 0.0;
    int quantity = int.tryParse(quantityProducedController.text) ?? 0;

    double total = weight * quantity;
    totalWeightController.text = total.toStringAsFixed(2);
  }

  Future<void> updateFinishedGood() async {
    if (productId.value.isEmpty) {
      Get.snackbar('Error', 'Product ID is required');
      return;
    }

    isLoading.value = true;

    const String url =
        "https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=edit";

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      // Required Fields
      request.fields['product_id'] = productId.value;
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
      request.fields['updated_by'] = '1';
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
          'Finished Good Updated Successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        log('Finished Good Updated Successfully: $result');
      } else {
        Get.snackbar(
          'Error',
          'Failed to update finished good: ${result['message'] ?? 'Unknown error'}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        log(
          'Failed to update finished good: ${result['message'] ?? 'Unknown error'}',
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
    productId.value = "";
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
}