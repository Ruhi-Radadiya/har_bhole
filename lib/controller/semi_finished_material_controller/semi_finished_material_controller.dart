import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/semi_finished_material_model/semi_finished_material_model.dart';

class SemiFinishedController extends GetxController {
  static SemiFinishedController get instance => Get.find();

  // --------------------- Observables ---------------------
  var materials = <SemiFinishedMaterialModel>[].obs;
  var filteredMaterials = <SemiFinishedMaterialModel>[].obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  // Form controllers
  final itemCodeController = TextEditingController();
  final itemNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final quantityRequiredController = TextEditingController();
  final unitController = TextEditingController();
  final wastageController = TextEditingController();
  final quantityCreatedController = TextEditingController();
  final boxWeightController = TextEditingController();
  final boxDimensionsController = TextEditingController();
  final currentQuantityController = TextEditingController();
  final unitOfMeasureController = TextEditingController();
  final reorderPointController = TextEditingController();
  final locationController = TextEditingController();

  // Dropdown values
  var selectedCategory = ''.obs;
  var selectedRawMaterial = ''.obs;
  var selectedOutputType = ''.obs;
  var selectedStockId = ''.obs;

  // Edit mode
  var isEditMode = false.obs;
  var editProductId = ''.obs;

  // Info cards
  var totalItem = 0.obs;
  var inStock = 0.obs;
  var lowStock = 0.obs;
  var outOfStock = 0.obs;

  // --------------------- INIT & DISPOSE ---------------------
  @override
  void onInit() {
    fetchMaterials();
    super.onInit();
  }

  // --------------------- FORM MANAGEMENT ---------------------
  void clearForm() {
    itemCodeController.clear();
    itemNameController.clear();
    descriptionController.clear();
    quantityRequiredController.clear();
    unitController.clear();
    wastageController.clear();
    quantityCreatedController.clear();
    boxWeightController.clear();
    boxDimensionsController.clear();

    selectedCategory.value = '';
    selectedRawMaterial.value = '';
    selectedOutputType.value = '';

    isEditMode.value = false;
    editProductId.value = '';
  }

  void fillFormForEdit(SemiFinishedMaterialModel product) {
    isEditMode.value = true;
    selectedStockId.value = product.stockId; // <-- This stores the stock ID
    itemCodeController.text = product.itemCode ?? '';
    itemNameController.text = product.itemName ?? '';
    selectedCategory.value = product.categoryId ?? '';
    currentQuantityController.text = product.currentQuantity ?? '';
    unitOfMeasureController.text = product.unitOfMeasure ?? '';
    reorderPointController.text = product.reorderPoint ?? '';
    locationController.text = product.location ?? '';
    descriptionController.text = product.description ?? '';
    selectedOutputType.value = product.outputType ?? '';
    boxWeightController.text = product.boxWeight ?? '';
    boxDimensionsController.text = product.boxDimensions ?? '';
  }

  void setEditMode(SemiFinishedMaterialModel product) {
    isEditMode.value = true;
    editProductId.value = product.stockId;

    // Prefill form data
    itemCodeController.text = product.itemCode;
    itemNameController.text = product.itemName;
    descriptionController.text = product.description ?? '';
    selectedCategory.value = product.categoryId;
    selectedOutputType.value = product.outputType;
    quantityCreatedController.text = product.currentQuantity;
    unitController.text = product.unitOfMeasure;
    boxWeightController.text = product.boxWeight;
    boxDimensionsController.text = product.boxDimensions;

    // Prefill BOM data if available
    if (product.bomItems.isNotEmpty) {
      final firstBom = product.bomItems.first;
      quantityRequiredController.text = firstBom.quantityRequired;
      wastageController.text = firstBom.wastagePercentage;
      selectedRawMaterial.value = firstBom.rawMaterialId;
    }
  }

  // --------------------- GENERATE ITEM CODE ---------------------
  Future<void> generateItemCode() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=list',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> items = (data["items"] ?? []) as List;

        if (items.isEmpty) {
          itemCodeController.text = "SF001";
          return;
        }

        final codes = items
            .map((e) => e["item_code"]?.toString() ?? "")
            .where((code) => code.startsWith("SF"))
            .toList();

        if (codes.isEmpty) {
          itemCodeController.text = "SF001";
          return;
        }

        final numbers = codes.map((code) {
          final numericPart = code.replaceAll(RegExp(r'[^0-9]'), '');
          return int.tryParse(numericPart) ?? 0;
        }).toList()..sort();

        final next = (numbers.last + 1).toString().padLeft(3, '0');
        itemCodeController.text = "SF$next";
      } else {
        itemCodeController.text = "SF001";
      }
    } catch (e) {
      log("❌ Error generating code: $e");
      itemCodeController.text = "SF001";
    }
  }

  // --------------------- VALIDATION ---------------------
  bool validateForm() {
    if (!isEditMode.value) {
      // Strict validation only for ADD mode
      if (itemNameController.text.isEmpty ||
          selectedCategory.value.isEmpty ||
          selectedOutputType.value.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please fill all required fields",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return false;
      }
    } else {
      // Edit mode validation (only name required)
      if (itemNameController.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "Item name is required",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return false;
      }
    }
    return true;
  }

  // --------------------- PREPARE PAYLOAD ---------------------
  Map<String, dynamic> _prepareAddPayload() {
    return {
      "item_name": itemNameController.text.trim(),
      "category_id": selectedCategory.value,
      "current_quantity": quantityCreatedController.text.isEmpty
          ? 0
          : double.parse(quantityCreatedController.text),
      "unit_of_measure": unitController.text.isEmpty
          ? "kg"
          : unitController.text.trim(),
      "reorder_point": 50,
      "location": "Warehouse B",
      "description": descriptionController.text.trim(),
      "output_type": selectedOutputType.value,
      "box_weight": boxWeightController.text.trim(),
      "box_dimensions": boxDimensionsController.text.trim(),
      "created_by": 1,
    };
  }

  Map<String, dynamic> prepareEditPayload() {
    return {
      "stock_id": selectedStockId.value, // REQUIRED
      "item_code": itemCodeController.text,
      "item_name": itemNameController.text,
      "category_id": selectedCategory.value,
      "current_quantity": currentQuantityController.text,
      "unit_of_measure": unitOfMeasureController.text,
      "reorder_point": reorderPointController.text,
      "location": locationController.text,
      "description": descriptionController.text,
      "output_type": selectedOutputType.value,
      "box_weight": boxWeightController.text,
      "box_dimensions": boxDimensionsController.text,
      "created_by": "Ruhi", // or your logged-in user variable
    };
  }

  // --------------------- ADD MATERIAL ---------------------
  Future<void> addSemiFinishedMaterial() async {
    if (!validateForm()) return;

    isLoading.value = true;
    final payload = _prepareAddPayload();

    try {
      final response = await http.post(
        Uri.parse(
          "https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=add",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload),
      );

      final data = json.decode(response.body);
      log("🧾 Add Response: $data");

      if (data["success"] == true) {
        Fluttertoast.showToast(
          msg: "Semi-Finished Material Added Successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        clearForm();
        fetchMaterials();
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: data["message"] ?? "Failed to add material!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      log("❌ Error adding material: $e");
      Fluttertoast.showToast(
        msg: "Error adding material: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // --------------------- EDIT MATERIAL ---------------------
  Future<void> editSemiFinishedMaterial() async {
    isLoading.value = true;
    final payload = prepareEditPayload();

    try {
      log("📤 Edit Payload: $payload");
      final response = await http.post(
        Uri.parse(
          "https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=edit",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload),
      );

      final data = json.decode(response.body);
      log("🧾 Edit Response: $data");

      if (data["success"] == true) {
        Fluttertoast.showToast(
          msg: "Material Updated Successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        log(
          "🟡 Update Request Body: ${{"stock_id": selectedStockId.value, "item_code": itemCodeController.text, "item_name": itemNameController.text, "category_id": selectedCategory.value, "current_quantity": currentQuantityController.text, "unit_of_measure": unitOfMeasureController.text, "reorder_point": reorderPointController.text, "location": locationController.text, "description": descriptionController.text, "output_type": selectedOutputType.value, "box_weight": boxWeightController.text, "box_dimensions": boxDimensionsController.text}}",
        );

        clearForm();
        fetchMaterials();
        Get.back();
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: data["message"] ?? "Failed to update material!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      log("❌ Error editing material: $e");
      Fluttertoast.showToast(
        msg: "Error editing material: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // --------------------- SUBMIT FORM (AUTO DETECT MODE) ---------------------
  Future<void> submitForm() async {
    if (isEditMode.value) {
      await editSemiFinishedMaterial();
    } else {
      await addSemiFinishedMaterial();
    }
  }

  // --------------------- FETCH MATERIALS ---------------------
  Future<void> fetchMaterials() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=list',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          materials.value = (data['items'] as List)
              .map((e) => SemiFinishedMaterialModel.fromJson(e))
              .toList();
          filteredMaterials.assignAll(materials);
          _calculateStockInfo();
        } else {
          errorMessage.value = data['message'] ?? 'No data found';
        }
      } else {
        errorMessage.value = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = '❌ Error fetching materials: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // --------------------- DELETE MATERIAL ---------------------
  Future<void> deleteSemiFinishedMaterial(String stockId) async {
    if (stockId.isEmpty) return;

    try {
      final response = await http.post(
        Uri.parse(
          "https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=delete",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'stock_id': stockId}),
      );

      final data = jsonDecode(response.body);
      log('🗑️ Delete Response: $data');

      if (data["success"] == true) {
        Fluttertoast.showToast(
          msg: "Material deleted successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        fetchMaterials();
      } else {
        Fluttertoast.showToast(
          msg: data["message"] ?? "Failed to delete material!",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error deleting material: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  // --------------------- SEARCH ---------------------
  void searchMaterial(String query) {
    if (query.isEmpty) {
      filteredMaterials.assignAll(materials);
    } else {
      final results = materials.where((m) {
        final name = m.itemName.toLowerCase();
        final code = m.itemCode.toLowerCase();
        return name.contains(query.toLowerCase()) ||
            code.contains(query.toLowerCase());
      }).toList();
      filteredMaterials.assignAll(results);
    }
  }

  // --------------------- STOCK SUMMARY ---------------------
  void _calculateStockInfo() {
    totalItem.value = materials.length;
    inStock.value = materials.where((m) {
      final qty = double.tryParse(m.currentQuantity) ?? 0;
      return qty > 10;
    }).length;
    lowStock.value = materials.where((m) {
      final qty = double.tryParse(m.currentQuantity) ?? 0;
      return qty > 0 && qty <= 10;
    }).length;
    outOfStock.value = materials.where((m) {
      final qty = double.tryParse(m.currentQuantity) ?? 0;
      return qty == 0;
    }).length;
  }
}
