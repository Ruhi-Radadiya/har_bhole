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
  var isLoading = true.obs;

  // Info cards
  var totalItem = 0.obs;
  var inStock = 0.obs;
  var lowStock = 0.obs;
  var outOfStock = 0.obs;

  // For dropdowns or lists
  List<SemiFinishedMaterialModel> get materialList => materials;

  @override
  void onInit() {
    fetchMaterials();
    super.onInit();
  }

  // --------------------- FETCH DATA ---------------------
  void fetchMaterials() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final url = Uri.parse(
        'https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=list',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

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
        errorMessage.value = 'API Error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = '❌ Error fetching materials: $e';
      _loadDummyData();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSemiFinishedMaterial(String stockId) async {
    if (stockId.isEmpty || stockId == 'null') {
      Fluttertoast.showToast(
        msg: 'Invalid Stock ID — cannot delete!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      log('❌ Stock ID missing in delete call');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=delete',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'stock_id': stockId}),
      );
      log('🟢 Sending delete request for stock_id: $stockId');

      final data = jsonDecode(response.body);

      log('🔵 Delete API Response: $data');

      if (response.statusCode == 200 && data['success'] == true) {
        Fluttertoast.showToast(
          msg: data['message'] ?? 'Material deleted successfully!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xff4CAF50),
          textColor: Colors.white,
        );
        fetchMaterials();
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: data['message'] ?? 'Failed to delete material.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        log('❌ Delete failed: ${data['message']}');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong while deleting: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      log('🔥 Error deleting material: $e');
    }
  }

  // --------------------- SEARCH LOGIC ---------------------
  void searchMaterial(String query) {
    if (query.isEmpty) {
      filteredMaterials.assignAll(materials);
    } else {
      final results = materials.where((m) {
        final name = m.itemName?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase());
      }).toList();
      filteredMaterials.assignAll(results);
    }
  }

  // --------------------- ADD DATA ---------------------
  Future<void> addSemiFinishedMaterial({
    required String itemName,
    required String categoryId,
    required String currentQuantity,
    required String unitOfMeasure,
    required String reorderPoint,
    required String location,
    required String description,
    required String outputType,
    required String boxWeight,
    required String boxDimensions,
    required String createdBy,
  }) async {
    try {
      final url = Uri.parse(
        'https://harbhole.eihlims.com/Api/semi_finished_stock_api.php?action=add',
      );
      final body = {
        'item_name': itemName,
        'category_id': categoryId,
        'current_quantity': currentQuantity,
        'unit_of_measure': unitOfMeasure,
        'reorder_point': reorderPoint,
        'location': location,
        'description': description,
        'output_type': outputType,
        'box_weight': boxWeight,
        'box_dimensions': boxDimensions,
        'created_by': createdBy,
      };

      final response = await http.post(url, body: body);
      final res = jsonDecode(response.body);

      if (response.statusCode == 200 && res['success'] == true) {
        Get.snackbar(
          'Success',
          res['message'] ?? 'Material added successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
        fetchMaterials();
      } else {
        Get.snackbar(
          'Error',
          res['message'] ?? 'Failed to add material!',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong while adding material!');
    }
  }

  // --------------------- INFO CARD COUNTS ---------------------
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

  // --------------------- DUMMY DATA ---------------------
  void _loadDummyData() {
    final dummy = [
      SemiFinishedMaterialModel(
        stockId: "27",
        itemCode: "SFS0027",
        itemName: "Sev (Medium)",
        categoryId: "19",
        currentQuantity: '0',
        unitOfMeasure: "kg",
        reorderPoint: "5",
        location: "Warehouse A",
        description: "Test semi-finished product",
        outputType: "kg",
        boxWeight: "1.2",
        boxDimensions: "30x20x10",
        itemImage: null,
        createdBy: "Admin",
        createdAt: DateTime.now(),
        updatedAt: null,
        bomItems: [
          BomItem(
            productionId: "98",
            rawMaterialId: "3",
            quantityRequired: "10",
            unitOfMeasure: "kg",
            wastagePercentage: "1",
            notes: "For testing",
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          BomItem(
            productionId: "99",
            rawMaterialId: "7",
            quantityRequired: "2",
            unitOfMeasure: "kg",
            wastagePercentage: "0.5",
            notes: "Secondary material",
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ],
      ),
    ];

    materials.value = dummy;
    filteredMaterials.value = dummy;
    _calculateStockInfo();
  }
}
