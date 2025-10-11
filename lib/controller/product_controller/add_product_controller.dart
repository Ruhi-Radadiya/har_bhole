import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CreateProductController extends GetxController {
  // ===== Old fields (for backward compatibility with UI) =====
  final productCodeController = TextEditingController();
  final manufacturingDateController = TextEditingController();
  final expiryDateController = TextEditingController();
  final productTags = <String>[
    'Best Seller',
    'Gluten Free',
    'Organic',
    'Popular',
    'Spicy',
    'Sweet',
    'Vegan',
  ].obs;
  final isActive = true.obs;
  final selectedManufacturingDate = DateTime.now().obs;
  final selectedExpiryDate = DateTime.now().obs;

  final selectedCategory = "1".obs;
  final selectedTags = <String>{}.obs;

  // ===== Product data =====
  final productNameController = TextEditingController();
  final basePriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  final stockController = TextEditingController();
  final netWeightController = TextEditingController();
  final ingredientsListController = TextEditingController();

  // ===== Nutritional info controllers =====
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

  // ===== POST PRODUCT =====
  Future<bool> createProduct() async {
    try {
      final Map<String, dynamic> body = {
        "product_name": productNameController.text,
        "category_id": selectedCategory.value,
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
        "status": "1",

        // Nutritional info
        "energy_kcal":
            double.tryParse(energyController.text)?.toStringAsFixed(2) ??
            "0.00",
        "protein_g":
            double.tryParse(proteinController.text)?.toStringAsFixed(2) ??
            "0.00",
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
            double.tryParse(sodiumController.text)?.toStringAsFixed(2) ??
            "0.00",
        "iron_mg":
            double.tryParse(ironController.text)?.toStringAsFixed(2) ?? "0.00",
        "calcium_mg":
            double.tryParse(calciumController.text)?.toStringAsFixed(2) ??
            "0.00",
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
      };

      print("📦 Sending data: $body");

      final response = await http.post(
        Uri.parse(
          "https://harbhole.eihlims.com/Api/product_api.php?action=add",
        ),
        body: body.map((key, value) => MapEntry(key, value.toString())),
      );

      print("🔁 Response: ${response.statusCode} ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Product created successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
        return true;
      } else {
        Get.snackbar(
          "Error",
          "Failed to create product",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  void toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
  }

  void clearFields() {
    productCodeController.clear();
    manufacturingDateController.clear();
    expiryDateController.clear();
    productNameController.clear();
    basePriceController.clear();
    sellingPriceController.clear();
    stockController.clear();
    netWeightController.clear();
    ingredientsListController.clear();

    // Nutritional
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

    selectedCategory.value = "1";
    selectedTags.clear();
    isActive.value = true;
  }
}
