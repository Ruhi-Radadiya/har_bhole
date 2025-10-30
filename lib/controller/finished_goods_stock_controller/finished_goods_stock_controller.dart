import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/finished_goods_stock/finished_goods_stock_model.dart';

class FinishedGoodsStockController extends GetxController {
  static FinishedGoodsStockController get instance => Get.find();

  // --------------------- Observables ---------------------
  var isLoading = false.obs;
  var finishedGoodsList = <FinishedGoodsStockModel>[].obs;
  var filteredMaterials = <FinishedGoodsStockModel>[].obs;
  var errorMessage = ''.obs;

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
  final selectedCategory = ''.obs;
  final selectedRawMaterial = ''.obs;
  final selectedImage = Rxn<File>();
  final selectedStockId = ''.obs;
  var isEditMode = false.obs;

  // --------------------- ADD FINISHED GOOD ---------------------
  Future<void> addFinishedGood() async {
    isLoading.value = true;
    try {
      final payload = {
        "product_code": productCodeController.text,
        "product_name": productNameController.text,
        "category_id": selectedCategory.value,
        "description": descriptionController.text,
        "unit_of_measure": unitOfMeasureController.text,
        "quantity_produced": quantityProducedController.text,
        "total_weight": totalWeightController.text,
      };

      final response = await http.post(
        Uri.parse(
          "https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=add",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload),
      );

      final data = json.decode(response.body);
      log("🟢 Add Finished Good Payload: $payload");
      log("🟢 Add Finished Good Response: $data");

      if (data["success"] == true) {
        Fluttertoast.showToast(
          msg: "Finished Good Added Successfully ✅",
          backgroundColor: Colors.green,
        );
        clearForm();
        fetchFinishedGoodsStock();
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: data["message"] ?? "Failed to add finished good ❌",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e", backgroundColor: Colors.red);
      log("❌ Error adding finished good: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // --------------------- EDIT FINISHED GOOD ---------------------
  Future<void> editFinishedGood() async {
    isLoading.value = true;
    try {
      final payload = {
        "stock_id": selectedStockId.value,
        "product_code": productCodeController.text,
        "product_name": productNameController.text,
        "category_id": selectedCategory.value,
        "description": descriptionController.text,
        "unit_of_measure": unitOfMeasureController.text,
        "quantity_produced": quantityProducedController.text,
        "total_weight": totalWeightController.text,
      };

      final response = await http.post(
        Uri.parse(
          "https://harbhole.eihlims.com/Api/finished_goods_stock_api.php?action=edit",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload),
      );

      final data = json.decode(response.body);
      log("🟡 Edit Payload: $payload");
      log("🟢 Edit Response: $data");

      if (data["success"] == true) {
        Fluttertoast.showToast(
          msg: "Finished Good Updated Successfully ✅",
          backgroundColor: Colors.green,
        );
        clearForm();
        fetchFinishedGoodsStock();
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg: data["message"] ?? "Failed to update ❌",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error editing: $e",
        backgroundColor: Colors.red,
      );
      log("❌ Error editing finished good: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // --------------------- FILL FORM FOR EDIT ---------------------
  void fillFormForEdit(FinishedGoodsStockModel product) {
    isEditMode.value = true;
    selectedStockId.value = product.stockId ?? '';
    productCodeController.text = product.productCode ?? '';
    productNameController.text = product.productName ?? '';
    selectedCategory.value = product.categoryId ?? '';
    descriptionController.text = product.description ?? '';
    unitOfMeasureController.text = product.unitOfMeasure ?? '';
    quantityProducedController.text = product.currentQuantity ?? '';
    totalWeightController.text = product.producedTotalWeightGrams ?? '';
  }

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

  @override
  void onInit() {
    super.onInit();
    fetchFinishedGoodsStock();
  }
}
