import 'dart:convert';
import 'dart:developer';

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
