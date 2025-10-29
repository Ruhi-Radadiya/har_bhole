import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/supplier_model/supplier_model.dart';

class SupplierController extends GetxController {
  static SupplierController get instance => Get.find();

  var suppliersList = <Supplier>[].obs;
  var filteredSupplier = <Supplier>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isInitialized = false; // 👈 new flag to track lifecycle
  var isActive = true.obs;

  // ---------------------- FETCH SUPPLIERS ----------------------
  Future<void> fetchSuppliers() async {
    if (isInitialized) return; // ✅ Prevent re-calling after back navigation
    isInitialized = true;

    try {
      isLoading.value = true;
      suppliersList.clear();
      filteredSupplier.clear();

      final response = await http.get(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/suppliers_api.php?action=list',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final items = data['items'] as List<dynamic>;
          final suppliers = items.map((e) => Supplier.fromJson(e)).toList();

          suppliersList.assignAll(suppliers);
          filteredSupplier.assignAll(suppliers);
        } else {
          errorMessage.value = data['message'] ?? 'Failed to load suppliers.';
        }
      } else {
        errorMessage.value =
            "Failed to fetch suppliers. Status code: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Error fetching suppliers: $e";
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------------- DELETE SUPPLIER ----------------------
  Future<void> deleteSupplier(String supplierId) async {
    try {
      // ✅ Convert string ID to int safely
      final int id = int.tryParse(supplierId) ?? 0;
      if (id == 0) {
        Fluttertoast.showToast(msg: "Invalid supplier ID");
        return;
      }

      final response = await http.post(
        Uri.parse(
          'https://harbhole.eihlims.com/Api/suppliers_api.php?action=delete',
        ),
        body: {'supplier_id': id.toString()}, // ✅ send as int string
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        // ✅ Remove deleted supplier locally
        suppliersList.removeWhere((s) => s.supplierId == supplierId);
        filteredSupplier.removeWhere((s) => s.supplierId == supplierId);
        suppliersList.refresh();
        filteredSupplier.refresh();

        Fluttertoast.showToast(
          msg: data['message'] ?? "Supplier deleted successfully",
          backgroundColor: const Color(0xff4E6B37),
          textColor: Colors.white,
        );

        // 🔁 Optional: Refresh list from API to ensure sync
        await fetchSuppliers();
      } else {
        Fluttertoast.showToast(
          msg: data['message'] ?? "Failed to delete supplier",
          backgroundColor: const Color(0xffAD111E),
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error deleting supplier: $e",
        backgroundColor: const Color(0xffAD111E),
        textColor: Colors.white,
      );
    }
  }

  // ---------------------- SEARCH SUPPLIER ----------------------
  void searchSupplier(String query) {
    if (!isActive.value) return; // 👈 skip search if inactive (navigated away)

    if (query.isEmpty) {
      filteredSupplier.assignAll(suppliersList);
    } else {
      filteredSupplier.assignAll(
        suppliersList.where(
          (s) => (s.supplierName ?? '').toLowerCase().contains(
            query.toLowerCase(),
          ),
        ),
      );
    }
  }

  List<Supplier> get suppliers => filteredSupplier;

  @override
  void onClose() {
    isInitialized = false;
    super.onClose();
  }
}
