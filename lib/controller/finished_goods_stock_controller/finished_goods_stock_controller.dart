import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import '../../model/finished_goods_stock/finished_goods_stock_model.dart';

class FinishedGoodsStockController extends GetxController {
  static FinishedGoodsStockController get instance => Get.find();

  RxString selectedCategory = ''.obs;
  RxString selectedUnit = ''.obs;
  RxString selectedRawMaterial = ''.obs;
  RxString selectedVariantWeight = ''.obs;
  RxList<Map<String, dynamic>> variantsList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> bomList = <Map<String, dynamic>>[].obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  var selectedRawMaterialId = ''.obs;

  // 👇 For editing
  String? editingStockId;

  @override
  void onInit() {
    super.onInit();
    weightGramsController.addListener(_updateTotalWeight);
    quantityProducedController.addListener(_updateTotalWeight);
    generateNextProductCode();
    fetchFinishedGoodsStock();
  }

  // --------------------- Observables ---------------------
  var isLoading = false.obs;
  var finishedGoodsList = <FinishedGoodsStockModel>[].obs;
  var filteredMaterials = <FinishedGoodsStockModel>[].obs;
  var errorMessage = ''.obs;
  var selectedCategoryName = ''.obs;
  var selectedCategoryId = ''.obs;
  var bomItems = <Map<String, dynamic>>[].obs;
  var variants = <Map<String, dynamic>>[].obs;

  // For dropdowns or lists
  List<FinishedGoodsStockModel> get materialList => finishedGoodsList;

  final String listUrl =
      "https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=list";
  final String deleteUrl =
      "https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=delete";

  // --------------------- FETCH DATA ---------------------
  Future<void> fetchFinishedGoodsStock() async {
    try {
      isLoading(true);
      finishedGoodsList.clear();
      errorMessage.value = '';

      final response = await http.get(Uri.parse(listUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["success"] == true && data["items"] != null) {
          finishedGoodsList.value = List<FinishedGoodsStockModel>.from(
            data["items"].map((x) => FinishedGoodsStockModel.fromJson(x)),
          );
          filteredMaterials.assignAll(finishedGoodsList);
          _showToast("Finished goods fetched successfully ✅", Colors.green);
          log("✅ Finished goods fetched: ${finishedGoodsList.length}");
        } else {
          errorMessage.value = data["message"] ?? "No finished goods found";
          _showToast(errorMessage.value, Colors.orange);
          log("⚠️ No finished goods found");
        }
      } else {
        errorMessage.value = "Failed to fetch data (${response.statusCode})";
        _showToast(errorMessage.value, Colors.red);
        log("❌ Failed to fetch data (${response.statusCode})");
      }
    } catch (e) {
      errorMessage.value = "Something went wrong: $e";
      _showToast(errorMessage.value, Colors.red);
      log("❌ Error fetching finished goods: $e");
    } finally {
      isLoading(false);
    }
  }

  // --------------------- SEARCH ---------------------
  void searchMaterial(String query) {
    if (query.isEmpty) {
      filteredMaterials.assignAll(finishedGoodsList);
    } else {
      final results = finishedGoodsList.where((item) {
        final name = item.productName?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase());
      }).toList();
      filteredMaterials.assignAll(results);
    }
  }

  // --------------------- DELETE ---------------------
  Future<void> deleteFinishedGoodsStock(String stockId) async {
    try {
      if (stockId.isEmpty) {
        _showToast("Stock ID is missing ⚠️", Colors.orange);
        return;
      }

      log("🟢 Deleting Finished Good with ID: $stockId");

      final response = await http.post(
        Uri.parse(deleteUrl),
        body: {"stock_id": stockId},
      );

      log("🔵 API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["success"] == true) {
          _showToast("Deleted successfully ✅", Colors.green);
          fetchFinishedGoodsStock();
          Get.back();
        } else {
          _showToast(data["message"] ?? "Delete failed ❌", Colors.red);
        }
      } else {
        _showToast("Server error: ${response.statusCode}", Colors.red);
      }
    } catch (e) {
      log("❌ Delete failed: $e");
      _showToast("Error: $e", Colors.red);
    }
  }

  // --------------------- FORM CONTROLLERS ---------------------
  final productCodeController = TextEditingController();
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final unitOfMeasureController = TextEditingController();
  final quantityProducedController = TextEditingController();
  final totalWeightController = TextEditingController();
  final weightGramsController = TextEditingController();
  final reorderPointController = TextEditingController();
  final unitController = TextEditingController();
  final selectedStockId = ''.obs;
  var isEditMode = false.obs;

  // --------------------- FILL FORM FOR EDIT ---------------------
  // void fillFormForEdit(FinishedGoodsStockModel product) {
  //   isEditMode.value = true;
  //   selectedStockId.value = product.stockId ?? '';
  //   productCodeController.text = product.productCode ?? '';
  //   productNameController.text = product.productName ?? '';
  //   selectedCategory.value = product.categoryId ?? '';
  //   descriptionController.text = product.description ?? '';
  //   unitOfMeasureController.text = product.unitOfMeasure ?? '';
  //   quantityProducedController.text = product.currentQuantity ?? '';
  //   totalWeightController.text = product.producedTotalWeightGrams ?? '';
  //   selectedImage.value = null;
  //   selectedCategoryName.value = product.categoryName ?? '';
  //   selectedCategoryId.value = product.categoryId ?? '';
  // }

  // --------------------- CLEAR FORM ---------------------
  void clearForm() {
    productCodeController.clear();
    productNameController.clear();
    descriptionController.clear();
    unitOfMeasureController.clear();
    quantityProducedController.clear();
    totalWeightController.clear();
    selectedCategory.value = '';
    selectedRawMaterial.value = '';
    selectedImage.value = null;
    selectedStockId.value = '';
    isEditMode.value = false;
    selectedCategoryName.value = '';
    selectedCategoryId.value = '';
  }

  // --------------------- TOAST HELPER ---------------------
  void _showToast(String message, Color bgColor) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: bgColor,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      fontSize: 15,
    );
  }

  // Add BOM item
  void addBomItem({
    required String semiFinishedProduct,
    required String quantityRequired,
  }) {
    final selectedProduct = semiFinishedController.materials.firstWhereOrNull(
      (e) => e.itemName == semiFinishedProduct,
    );

    final unit = selectedProduct?.unitOfMeasure ?? '';

    bomList.add({
      'semiFinishedProduct': semiFinishedProduct,
      'quantityRequired': quantityRequired,
      'unit': unit, // ✅ Store unit when adding item
    });
  }

  // Remove BOM item
  void removeBomItem(int index) {
    bomList.removeAt(index);
  }

  // Add Variant item
  void addVariant({required String weight, required String quantity}) {
    variantsList.add({'weight': weight, 'quantity': quantity});
  }

  // Remove Variant item
  void removeVariant(int index) {
    variantsList.removeAt(index);
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
      request.fields['variants_json'] = jsonEncode(
        variantsList.isEmpty ? [] : variantsList,
      );
      request.fields['bom_json'] = jsonEncode(bomList.isEmpty ? [] : bomList);

      if (selectedImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'product_image',
            selectedImage.value!.path,
          ),
        );
      }

      print("📤 Sending request to: $url");
      print("🧾 Request fields: ${request.fields}");
      print("📸 Has image: ${selectedImage.value != null}");

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("📥 Response status: ${response.statusCode}");
      print("📥 Response body: $responseBody");

      // ✅ Handle empty response safely
      if (responseBody.isEmpty) {
        Get.snackbar(
          'Error',
          'Empty response from server',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // ✅ Decode only if not empty
      dynamic result;
      try {
        result = jsonDecode(responseBody);
      } catch (e) {
        Get.snackbar(
          'Error',
          'Invalid JSON response: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print("❌ JSON decode error: $e");
        return;
      }

      // ✅ Success / failure handling
      if (response.statusCode == 200 && result['success'] == true) {
        Get.snackbar(
          '✅ Success',
          isEdit
              ? 'Finished Good Updated Successfully!'
              : 'Finished Good Added Successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        log('✅ Response: $result');
        fetchFinishedGoodsStock();
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
      log('❌ Exception: $e\n$st');
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
