import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:har_bhole/main.dart';
import 'package:http/http.dart' as http;

class CreateProductController extends GetxController {
  // ===== Text Controllers =====
  final productCodeController = TextEditingController();
  final productNameController = TextEditingController();
  final basePriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  final stockController = TextEditingController();
  final netWeightController = TextEditingController();
  final manufacturingDateController = TextEditingController();
  final expiryDateController = TextEditingController();
  final ingredientsListController = TextEditingController();
  final descriptionController = TextEditingController();

  // ===== Nutritional Info =====
  final energyController = TextEditingController();
  final proteinController = TextEditingController();
  final totalFatController = TextEditingController();
  final carbohydrateController = TextEditingController();
  final totalSugarController = TextEditingController();
  final saturatedFatController = TextEditingController();
  final monounsaturatedFatController = TextEditingController();
  final polyunsaturatedFatController = TextEditingController();
  final sodiumController = TextEditingController();
  final ironController = TextEditingController();
  final calciumController = TextEditingController();
  final fiberController = TextEditingController();
  final vitaminCController = TextEditingController();
  final vitaminDController = TextEditingController();
  final cholesterolController = TextEditingController();

  // ===== Dropdowns & Tags =====
  var selectedCategoryId = ''.obs;
  var selectedCategoryName = ''.obs;

  var selectedTags = <String>{}.obs;
  final productTags = <String>[
    'Best Seller',
    'Gluten Free',
    'Organic',
    'Popular',
    'Spicy',
    'Sweet',
    'Vegan',
  ];
  var isActive = true.obs;

  // ===== Dates =====
  var selectedManufacturingDate = DateTime.now().obs;
  var selectedExpiryDate = DateTime.now().obs;

  // ===== Image =====
  var selectedImage = Rxn<File>();
  var productImageUrl = "".obs;

  // ===== Setters =====
  void setImage(File image) {
    selectedImage.value = image;
    productImageUrl.value = "";
  }

  void setImageUrl(String url) {
    productImageUrl.value = url;
    selectedImage.value = null;
  }

  void setCategory({required String id, required String name}) {
    selectedCategoryId.value = id;
    selectedCategoryName.value = name;
  }

  // ===== Toast =====
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  // ===== Validation =====
  bool validateInputs() {
    if (productNameController.text.trim().isEmpty) {
      showToast("Please enter product name");
      return false;
    }
    if (basePriceController.text.trim().isEmpty) {
      showToast("Please enter base price (MRP)");
      return false;
    }
    if (sellingPriceController.text.trim().isEmpty) {
      showToast("Please enter selling price");
      return false;
    }
    if (stockController.text.trim().isEmpty) {
      showToast("Please enter stock quantity");
      return false;
    }
    if (netWeightController.text.trim().isEmpty) {
      showToast("Please enter net weight");
      return false;
    }
    if (selectedCategoryId.value.isEmpty) {
      showToast("Please select a category");
      return false;
    }
    if (selectedImage.value == null && productImageUrl.value.isEmpty) {
      showToast("Please select a product image");
      return false;
    }
    return true;
  }

  // ===== Toggle Tag =====
  void toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  // ===== Clear Fields =====
  void clearFields() {
    productCodeController.clear();
    productNameController.clear();
    basePriceController.clear();
    sellingPriceController.clear();
    stockController.clear();
    netWeightController.clear();
    manufacturingDateController.clear();
    expiryDateController.clear();
    ingredientsListController.clear();
    descriptionController.clear();

    energyController.clear();
    proteinController.clear();
    totalFatController.clear();
    carbohydrateController.clear();
    totalSugarController.clear();
    saturatedFatController.clear();
    monounsaturatedFatController.clear();
    polyunsaturatedFatController.clear();
    sodiumController.clear();
    ironController.clear();
    calciumController.clear();
    fiberController.clear();
    vitaminCController.clear();
    vitaminDController.clear();
    cholesterolController.clear();

    selectedCategoryId.value = '';
    selectedCategoryName.value = '';
    selectedTags.clear();
    isActive.value = true;
    selectedImage.value = null;
    productImageUrl.value = "";
  }

  String generateProductCode(int nextProductId) {
    final now = DateTime.now();
    final year = now.year % 100; // last 2 digits of year
    final month = now.month.toString().padLeft(2, '0');
    final idPart = nextProductId.toString().padLeft(4, '0'); // e.g., 0057
    return '$year$month$idPart';
  }

  // ===== CREATE PRODUCT =====
  Future<bool> createProduct() async {
    if (!validateInputs()) return false;

    try {
      final uri = Uri.parse(
        "https://harbhole.eihlims.com/Api/product_api.php?action=add",
      );
      final request = http.MultipartRequest('POST', uri);

      final fields = _generateFields();
      request.fields.addAll(fields);

      if (selectedImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', selectedImage.value!.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log("🟢 Create Status: ${response.statusCode}");
      log("🟢 Create Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        showToast("Product created successfully");
        clearFields();
        return true;
      } else {
        showToast("Failed to create product");
        return false;
      }
    } catch (e) {
      log("❌ Error creating product: $e");
      showToast("Something went wrong: $e");
      return false;
    }
  }

  // ===== UPDATE PRODUCT =====
  Future<bool> updateProduct(String productId) async {
    if (!validateInputs()) return false;

    try {
      final uri = Uri.parse(
        "https://harbhole.eihlims.com/Api/product_api.php?action=edit",
      );
      final request = http.MultipartRequest('POST', uri);

      final fields = _generateFields(productId: productId, forUpdate: true);
      request.fields.addAll(fields);

      if (selectedImage.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', selectedImage.value!.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log("🟡 Update Status: ${response.statusCode}");
      log("🟡 Update Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        showToast("Product updated successfully");
        productController.fetchProducts();
        return true;
      } else {
        showToast("Failed to update product");
        return false;
      }
    } catch (e) {
      log("❌ Error updating product: $e");
      showToast("Something went wrong: $e");
      return false;
    }
  }

  Future<void> autoGenerateProductCode() async {
    try {
      final uri = Uri.parse(
        "https://harbhole.eihlims.com/Api/product_api.php?action=list",
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final regex = RegExp(r'"product_id"\s*:\s*"(\d+)"');
        final ids = regex
            .allMatches(body)
            .map((e) => int.parse(e.group(1)!))
            .toList();

        if (ids.isNotEmpty) {
          final nextId = (ids.reduce((a, b) => a > b ? a : b)) + 1;
          final code = generateProductCode(nextId);
          productCodeController.text = code;
          log("🟢 Auto-generated product code: $code");
        } else {
          // Default starting ID
          final code = generateProductCode(1);
          productCodeController.text = code;
        }
      } else {
        log("⚠️ Failed to fetch product list for code generation");
        productCodeController.text = generateProductCode(1);
      }
    } catch (e) {
      log("❌ Error generating product code: $e");
      productCodeController.text = generateProductCode(1);
    }
  }

  // ===== Helper: generate fields map =====
  Map<String, String> _generateFields({
    String? productId,
    bool forUpdate = false,
  }) {
    final Map<String, String> fields = {
      if (forUpdate && productId != null) "product_id": productId,
      "product_code": productCodeController.text,
      "product_name": productNameController.text,
      "category_id": selectedCategoryId.value,
      "category_name": selectedCategoryName.value,
      "stock_quantity": stockController.text,
      "net_weight":
          double.tryParse(netWeightController.text)?.toStringAsFixed(3) ??
          "0.000",
      "mrp":
          double.tryParse(basePriceController.text)?.toStringAsFixed(2) ??
          "0.00",
      "selling_price":
          double.tryParse(sellingPriceController.text)?.toStringAsFixed(2) ??
          "0.00",
      "manufacturing_date": selectedManufacturingDate.value
          .toIso8601String()
          .split('T')[0],
      "expiry_date": selectedExpiryDate.value.toIso8601String().split('T')[0],
      "stock_status": "1",
      "ingredients": ingredientsListController.text,
      "tags": selectedTags.isEmpty ? "" : selectedTags.join(","),
      "status": isActive.value ? "1" : "0",
      "energy_kcal":
          double.tryParse(energyController.text)?.toStringAsFixed(2) ?? "0.00",
      "protein_g":
          double.tryParse(proteinController.text)?.toStringAsFixed(2) ?? "0.00",
      "total_fat_g":
          double.tryParse(totalFatController.text)?.toStringAsFixed(2) ??
          "0.00",
      "carbohydrate_g":
          double.tryParse(carbohydrateController.text)?.toStringAsFixed(2) ??
          "0.00",
      "total_sugar_g":
          double.tryParse(totalSugarController.text)?.toStringAsFixed(2) ??
          "0.00",
      "saturated_fat_g":
          double.tryParse(saturatedFatController.text)?.toStringAsFixed(2) ??
          "0.00",
      "monounsaturated_fat_g":
          double.tryParse(
            monounsaturatedFatController.text,
          )?.toStringAsFixed(2) ??
          "0.00",
      "polyunsaturated_fat_g":
          double.tryParse(
            polyunsaturatedFatController.text,
          )?.toStringAsFixed(2) ??
          "0.00",
      "sodium_mg":
          double.tryParse(sodiumController.text)?.toStringAsFixed(2) ?? "0.00",
      "iron_mg":
          double.tryParse(ironController.text)?.toStringAsFixed(2) ?? "0.00",
      "calcium_mg":
          double.tryParse(calciumController.text)?.toStringAsFixed(2) ?? "0.00",
      "fiber_g":
          double.tryParse(fiberController.text)?.toStringAsFixed(2) ?? "0.00",
      "vitamin_c_mg":
          double.tryParse(vitaminCController.text)?.toStringAsFixed(2) ??
          "0.00",
      "vitamin_d_mcg":
          double.tryParse(vitaminDController.text)?.toStringAsFixed(2) ??
          "0.00",
      "cholesterol_mg":
          double.tryParse(cholesterolController.text)?.toStringAsFixed(2) ??
          "0.00",
      "created_by": "1",
    };
    return fields;
  }
}
