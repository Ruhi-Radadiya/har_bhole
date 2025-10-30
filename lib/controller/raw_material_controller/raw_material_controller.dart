import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/raw_material_model/raw_material_model.dart';

class RawMaterialController extends GetxController {
  static RawMaterialController get instance => Get.find();

  // -------------------- Observables --------------------
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxList<RawMaterialModel> materialList = <RawMaterialModel>[].obs;
  RxList<RawMaterialModel> filteredMaterials = <RawMaterialModel>[].obs;

  // -------------------- Text Controllers --------------------
  final materialCodeController = TextEditingController();
  final materialNameController = TextEditingController();
  final unitOfMeasureController = TextEditingController();
  final currentQuantityController = TextEditingController();
  final minStockLevelController = TextEditingController();
  final maxStockLevelController = TextEditingController();
  final costPriceController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  var selectedCategory = ''.obs;
  var selectedStatus = 'Active'.obs;
  var materialImagePath = ''.obs;
  var stockId = ''.obs;
  var selectedSupplier = 0.obs;

  // ==========================================================
  // 🔹 FETCH RAW MATERIAL LIST
  // ==========================================================
  Future<void> fetchRawMaterials() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/raw_material_api.php?action=list',
        ),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        if (result['success'] == true && result['items'] != null) {
          // ✅ Convert each map to RawMaterialModel safely
          materialList.value = (result['items'] as List)
              .map((item) => RawMaterialModel.fromJson(item))
              .toList();

          filteredMaterials.assignAll(materialList);
          log("✅ Loaded ${materialList.length} materials");
        } else {
          errorMessage.value = "No materials found.";
          materialList.clear();
          filteredMaterials.clear();
        }
      } else {
        errorMessage.value = "Failed to load materials.";
        Fluttertoast.showToast(
          msg: "❌ Server Error: ${response.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      log("❌ Error fetching materials: $e");
      Fluttertoast.showToast(
        msg: "⚠️ Error: $e",
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================================
  // 🔹 SEARCH MATERIAL
  // ==========================================================
  void searchMaterial(String query) {
    if (query.isEmpty) {
      filteredMaterials.assignAll(materialList);
    } else {
      filteredMaterials.assignAll(
        materialList.where(
          (item) =>
              (item.materialName ?? '').toLowerCase().contains(
                query.toLowerCase(),
              ) ||
              (item.description ?? '').toLowerCase().contains(
                query.toLowerCase(),
              ),
        ),
      );
    }
  }

  // ==========================================================
  // 🔹 ADD NEW RAW MATERIAL
  // ==========================================================
  Future<void> addRawMaterial() async {
    isLoading.value = true;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://harbhole.eihlims.com/Api/raw_material_api.php?action=add',
        ),
      );

      request.fields.addAll({
        'material_code': materialCodeController.text,
        'material_name': materialNameController.text,
        'category': selectedCategory.value,
        'supplier': selectedSupplier.value.toString(),
        'unit': unitOfMeasureController.text,
        'current_stock': currentQuantityController.text,
        'min_stock_level': minStockLevelController.text,
        'max_stock_level': maxStockLevelController.text,
        'cost_price': costPriceController.text,
        'location': locationController.text,
        'description': descriptionController.text,
        'status': selectedStatus.value,
      });

      if (materialImagePath.value.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('image', materialImagePath.value),
        );
      }

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      var data = json.decode(responseBody);

      if (data['success'] == true) {
        Fluttertoast.showToast(msg: "Material Added Successfully");
        fetchRawMaterials();
        Get.back();
      } else {
        Fluttertoast.showToast(msg: data['message'] ?? "Add failed");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================================
  // 🔹 EDIT RAW MATERIAL
  // ==========================================================
  Future<void> updateMaterial(String stockId) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://harbhole.eihlims.com/Api/raw_material_api.php?action=edit',
        ),
      );

      // ✅ Required field mapping — all backend keys must match exactly
      request.fields.addAll({
        'stock_id': stockId.toString(),
        'material_code': materialCodeController.text.trim(),
        'material_name': materialNameController.text.trim(),
        'category_id': selectedCategory.value.toString(),
        'current_quantity': currentQuantityController.text.trim(),
        'unit_of_measure': unitOfMeasureController.text.trim(),
        'cost_price': costPriceController.text.trim(),
        'min_stock_level': minStockLevelController.text.trim(),
        'max_stock_level': maxStockLevelController.text.trim(),
        'reorder_point': '30', // ⚠️ must be included as integer string
        'supplier_id': selectedSupplier.value.toString(),
        'location': locationController.text.trim(),
        'description': descriptionController.text.trim(),
        'status': '1',
      });

      // Optional image
      if (materialImagePath.value.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath('image', materialImagePath.value),
        );
      }

      final response = await request.send();
      final res = await http.Response.fromStream(response);

      log('🟠 Server Response: ${res.body}');

      if (response.statusCode == 200) {
        final result = jsonDecode(res.body);

        if (result['success'] == true) {
          Fluttertoast.showToast(
            msg: "✅ Material updated successfully",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
          );
          Get.back(); // go back to list
        } else {
          Fluttertoast.showToast(
            msg: "⚠️ Update failed: ${result['message'] ?? 'Unknown error'}",
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "❌ Server Error: ${response.statusCode}",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "💥 Exception: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  // ==========================================================
  // 🔹 DELETE RAW MATERIAL
  // ==========================================================
  Future<void> deleteRawMaterial(String stockId) async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/raw_material_api.php?action=delete',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'stock_id': stockId}),
      );

      final data = json.decode(response.body);
      if (data['success'] == true) {
        materialList.removeWhere((item) => item.stockId.toString() == stockId);
        filteredMaterials.removeWhere(
          (item) => item.stockId.toString() == stockId,
        );
        Fluttertoast.showToast(msg: "✅ Material deleted successfully");
      } else {
        Fluttertoast.showToast(
          msg: "❌ ${data['message'] ?? "Failed to delete"}",
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "⚠️ $e");
    } finally {
      isLoading.value = false;
    }
  }

  void fillMaterialData(RawMaterialModel m) {
    // store stock id for update
    stockId.value = m.stockId?.toString() ?? '';

    materialCodeController.text = m.materialCode ?? '';
    materialNameController.text = m.materialName ?? '';
    selectedCategory.value = m.categoryId?.toString() ?? '';
    // supplier may be null or string; convert safely to int
    selectedSupplier.value = int.tryParse(m.supplierId?.toString() ?? '') ?? 0;
    unitOfMeasureController.text = m.unitOfMeasure ?? '';
    currentQuantityController.text = m.currentQuantity?.toString() ?? '';
    minStockLevelController.text = m.minStockLevel?.toString() ?? '';
    maxStockLevelController.text = m.maxStockLevel?.toString() ?? '';
    // costPrice in model is string, so keep text as string
    costPriceController.text = m.costPrice?.toString() ?? '';
    locationController.text = m.location ?? '';
    descriptionController.text = m.description ?? '';
    selectedStatus.value = m.status ?? 'Active';
    materialImagePath.value = m.materialImage?.toString() ?? '';
  }

  void clearAllFields() {
    stockId.value = '';
    materialCodeController.clear();
    materialNameController.clear();
    unitOfMeasureController.clear();
    currentQuantityController.clear();
    minStockLevelController.clear();
    maxStockLevelController.clear();
    costPriceController.clear();
    locationController.clear();
    descriptionController.clear();
    selectedCategory.value = '';
    selectedSupplier.value = 0;
    selectedStatus.value = 'Active';
    materialImagePath.value = '';
  }

  // ==========================================================
  // 🔹 ON INIT
  // ==========================================================
  @override
  void onInit() {
    fetchRawMaterials();
    ever(materialList, (_) {
      filteredMaterials.assignAll(materialList);
    });
    super.onInit();
  }
}
