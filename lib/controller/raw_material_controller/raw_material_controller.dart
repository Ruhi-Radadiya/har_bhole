import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/raw_material_model/raw_material_model.dart';

class RawMaterialController extends GetxController {
  static RawMaterialController get instance => Get.find();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  RxList<RawMaterialModel> materialList = <RawMaterialModel>[].obs;
  RxList<RawMaterialModel> filteredMaterials = <RawMaterialModel>[].obs;

  // 🔹 Fetch data from API
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
        final data = json.decode(response.body);
        if (data['success'] == true && data['items'] != null) {
          materialList.value = List<RawMaterialModel>.from(
            data['items'].map((item) => RawMaterialModel.fromJson(item)),
          );
          filteredMaterials.assignAll(materialList);
        } else {
          errorMessage.value = "No materials found.";
        }
      } else {
        errorMessage.value = "Failed to load materials.";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // 🔹 Search filter
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

  // 🔹 Delete raw material
  Future<void> deleteRawMaterial(String stockId) async {
    try {
      print("🧾 Deleting material with stock_id: $stockId");
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/raw_material_api.php?action=delete',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'stock_id': stockId}),
      );

      print("🧾 Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          // ✅ Remove from local lists
          materialList.removeWhere(
            (item) => item.stockId.toString() == stockId,
          );
          filteredMaterials.removeWhere(
            (item) => item.stockId.toString() == stockId,
          );

          Fluttertoast.showToast(
            msg: "✅ Material deleted successfully",
            backgroundColor: const Color(0xFF4CAF50),
            textColor: const Color(0xFFFFFFFF),
          );
          fetchRawMaterials();
          Get.back();
        } else {
          Fluttertoast.showToast(
            msg: "❌ ${data['message'] ?? "Failed to delete material"}",
            backgroundColor: const Color(0xFFFF5252),
            textColor: const Color(0xFFFFFFFF),
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "❌ Server error: ${response.statusCode}",
          backgroundColor: const Color(0xFFFF5252),
          textColor: const Color(0xFFFFFFFF),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "⚠️ $e",
        backgroundColor: const Color(0xFFFF5252),
        textColor: const Color(0xFFFFFFFF),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchRawMaterials();
    ever(materialList, (_) {
      filteredMaterials.assignAll(materialList);
    });
    super.onInit();
  }
}
