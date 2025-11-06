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
  var selectedMaterialName = ''.obs;
  var selectedMaterialId = ''.obs;
  var selectedCategoryId = ''.obs;

  // Edit mode
  var isEditMode = false.obs;
  var editProductId = ''.obs;

  // Info cards
  var totalItem = 0.obs;
  var inStock = 0.obs;
  var lowStock = 0.obs;
  var outOfStock = 0.obs;

  // --------------------- BOM ITEMS ---------------------
  var bomItems = <Map<String, dynamic>>[].obs;

  void addBomItem({
    required String rawMaterialId,
    required String quantityRequired,
    required String unit,
    required String wastage,
  }) {
    bomItems.add({
      "raw_material_id": rawMaterialId,
      "quantity_required": quantityRequired,
      "unit_of_measure": unit,
      "wastage_percentage": wastage,
      "notes": "",
    });
  }

  void removeBomItem(Map<String, dynamic> item) {
    bomItems.remove(item);
  }

  void clearBomItems() {
    bomItems.clear();
  }

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
    clearBomItems();
  }

  void fillFormForEdit(SemiFinishedMaterialModel product) {
    isEditMode.value = true;
    selectedStockId.value = product.stockId;
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

  // --------------------- GENERATE ITEM CODE ---------------------
  var generatedCode = ''.obs;

  void autoGenerateSemiFinishedCode() {
    try {
      final items = materials;
      final existingCodes = items
          .map((item) => item.itemCode)
          .where((code) => code != null && code.startsWith('SF'))
          .toList();

      int maxNumber = 0;
      for (var code in existingCodes) {
        final number =
            int.tryParse(code!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
        if (number > maxNumber) maxNumber = number;
      }

      final nextCode = 'SF${(maxNumber + 1).toString().padLeft(3, '0')}';
      generatedCode.value = nextCode;
      log('✅ Generated semi-finished code: $nextCode');
    } catch (e) {
      log('❌ Error generating semi-finished code: $e');
    }
  }

  // --------------------- VALIDATION ---------------------
  bool validateForm() {
    if (!isEditMode.value) {
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
      "category_id": int.tryParse(selectedCategoryId.value.toString()) ?? 0,
      "current_quantity":
          double.tryParse(quantityCreatedController.text.trim()) ?? 0,
      "unit_of_measure": unitController.text.trim().isEmpty
          ? "pcs"
          : unitController.text.trim(),
      "created_by": 1,
      "reorder_point": int.tryParse(reorderPointController.text.trim()) ?? 10,
      "location": locationController.text.trim().isEmpty
          ? "Shelf A"
          : locationController.text.trim(),
      "description": descriptionController.text.trim().isEmpty
          ? "No description"
          : descriptionController.text.trim(),
      "output_type": selectedOutputType.value.isEmpty
          ? "Box"
          : selectedOutputType.value,
      "box_weight": boxWeightController.text.trim().isEmpty
          ? "1kg"
          : boxWeightController.text.trim(),
      "box_dimensions": boxDimensionsController.text.trim().isEmpty
          ? "10x5x2 cm"
          : boxDimensionsController.text.trim(),
    };
  }

  Map<String, dynamic> prepareEditPayload() {
    return {
      "stock_id": selectedStockId.value,
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
      "created_by": "1",
      "bom_items": bomItems
          .map(
            (e) => {
              "raw_material_id": e["raw_material_id"],
              "quantity_required": e["quantity_required"],
              "unit_of_measure": e["unit_of_measure"],
              "wastage_percentage": e["wastage_percentage"],
              "notes": e["notes"] ?? "",
            },
          )
          .toList(),
    };
  }

  // --------------------- ADD MATERIAL ---------------------
  Future<void> addSemiFinishedMaterial() async {
    if (itemNameController.text.trim().isEmpty ||
        unitController.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill all required fields",
        backgroundColor: Colors.red,
      );
      return;
    }

    isLoading.value = true;

    final payload = _prepareAddPayload();
    log("POST Payload: ${jsonEncode(payload)}");

    try {
      final response = await http.post(
        Uri.parse(
          "https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=add",
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      log("Response: ${response.body}");

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Item added successfully",
          backgroundColor: Colors.green,
        );
        log("✅ Item added successfully");
        clearForm();
      } else {
        Fluttertoast.showToast(
          msg: "Failed: ${response.reasonPhrase}",
          backgroundColor: Colors.red,
        );
        log("❌ Failed: ${response.reasonPhrase}");
      }
    } catch (e) {
      log("Error: $e");
      Fluttertoast.showToast(
        msg: "Something went wrong",
        backgroundColor: Colors.red,
      );
      log("❌ Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  // --------------------- EDIT MATERIAL ---------------------
  Future<void> editSemiFinishedMaterial() async {
    isLoading.value = true;
    final payload = prepareEditPayload();

    try {
      log("📤 Edit Payload: ${jsonEncode(payload)}");
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

  // --------------------- SUBMIT FORM ---------------------
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
