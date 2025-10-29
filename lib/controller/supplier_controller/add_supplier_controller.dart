import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:har_bhole/main.dart';
import 'package:http/http.dart' as http;

import '../../model/supplier_model/supplier_model.dart';

class AddSupplierController extends GetxController {
  /// Text Controllers
  final supplierCodeController = TextEditingController();
  final supplierNameController = TextEditingController();
  final contactPersonController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();
  final countryController = TextEditingController();
  final gstNumberController = TextEditingController();
  final panNumberController = TextEditingController();
  final paymentTermsController = TextEditingController();
  final creditLimitController = TextEditingController();
  final notesController = TextEditingController();
  final statusController = TextEditingController();

  void fillSupplierData(Supplier supplier) {
    supplierCodeController.text = supplier.supplierCode ?? '';
    supplierNameController.text = supplier.supplierName ?? '';
    contactPersonController.text = supplier.contactPerson ?? '';
    phoneController.text = supplier.phone ?? '';
    emailController.text = supplier.email ?? '';
    websiteController.text = supplier.website ?? '';
    addressController.text = supplier.address ?? '';
    cityController.text = supplier.city ?? '';
    stateController.text = supplier.state ?? '';
    pinCodeController.text = supplier.pinCode ?? '';
    countryController.text = supplier.country ?? '';
    gstNumberController.text = supplier.gstNumber ?? '';
    panNumberController.text = supplier.panNumber ?? '';
    paymentTermsController.text = supplier.paymentTerms ?? '';
    creditLimitController.text = supplier.creditLimit ?? '';
    notesController.text = supplier.notes ?? '';
    statusController.text = supplier.status ?? 'Active';
  }

  /// Loading state
  RxBool isLoading = false.obs;
  var selectedStatus = ''.obs;

  @override
  void onInit() {
    super.onInit();
    generateNextSupplierCode();
  }

  /// Toast helper
  void showToast(String message, {bool success = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: success ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Generate supplier code automatically
  Future<void> generateNextSupplierCode() async {
    const String getApiUrl =
        "https://harbhole.eihlims.com/Api/suppliers_api.php?action=list";

    try {
      final response = await http.get(Uri.parse(getApiUrl));
      log('API Response status: ${response.statusCode}');
      log('API Response body: ${response.body}');

      if (response.statusCode == 200 && response.body.trim().isNotEmpty) {
        try {
          final data = jsonDecode(response.body);
          if (data['success'] == true && data['suppliers'] != null) {
            final suppliers = List.from(data['suppliers']);

            int maxNumber = 0;
            for (var item in suppliers) {
              final code = item['supplier_code']?.toString() ?? '';
              final numberPart = int.tryParse(
                code.replaceAll(RegExp(r'[^0-9]'), ''),
              );
              if (numberPart != null && numberPart > maxNumber) {
                maxNumber = numberPart;
              }
            }

            final nextNumber = maxNumber + 1;
            final newCode = 'SUP${nextNumber.toString().padLeft(3, '0')}';
            supplierCodeController.text = newCode;
          } else {
            supplierCodeController.text = 'SUP001';
          }
        } catch (e) {
          log('Failed to parse JSON in supplier list: $e');
          supplierCodeController.text = 'SUP001';
        }
      } else {
        supplierCodeController.text = 'SUP001';
      }
    } catch (e, stackTrace) {
      log('Error generating supplier code: $e', stackTrace: stackTrace);
      supplierCodeController.text = 'SUP001';
    }
  }

  Future<bool> updateSupplier(String supplierId) async {
    isLoading.value = true;

    const String url =
        "https://harbhole.eihlims.com/Api/suppliers_api.php?action=edit";

    try {
      // ✅ Build correct body (matching backend exactly)
      final Map<String, dynamic> body = {
        "supplier_id": supplierId,
        "supplier_code": supplierCodeController.text,
        "supplier_name": supplierNameController.text,
        "contact_person": contactPersonController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "website": websiteController.text,
        "address": addressController.text,
        "city": cityController.text,
        "state": stateController.text,
        "pin_code": pinCodeController.text,
        "country": countryController.text,
        "gst_number": gstNumberController.text,
        "pan_number": panNumberController.text,
        "payment_terms": paymentTermsController.text,
        "credit_limit": creditLimitController.text,
        "notes": notesController.text,
        "status": statusController.text.isEmpty
            ? "Active"
            : statusController.text,
        "is_active": "1",
        "created_by": "1",
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      log("🔹 Update Supplier Status: ${response.statusCode}");
      log("🔹 Update Supplier Raw Response: ${response.body}");

      // 🧩 Check if response contains HTML (invalid JSON)
      if (response.body.trim().startsWith('<')) {
        showToast("Invalid response from server (HTML).", success: false);
        log("❌ Response is HTML, not JSON.");
        return false;
      }

      // 🧩 Try decoding safely
      dynamic result;
      try {
        result = jsonDecode(response.body);
      } catch (e) {
        showToast("Invalid JSON response from server.", success: false);
        log("❌ JSON decode failed: $e");
        log("❌ Raw Response: ${response.body}");
        return false;
      }

      // 🧩 Handle backend success
      if (response.statusCode == 200 && result["success"] == true) {
        showToast("Supplier updated successfully!", success: true);
        clearAllFields();
        supplierController.fetchSuppliers();
        Get.back();
        return true;
      } else {
        showToast(
          "Failed to update supplier: ${result["message"] ?? "Unknown error"}",
          success: false,
        );
        return false;
      }
    } catch (e) {
      log("❌ Error updating supplier: $e");
      showToast("Something went wrong: $e", success: false);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// POST API - Add Supplier
  Future<void> addSupplier() async {
    isLoading.value = true;

    const String url =
        "https://harbhole.eihlims.com/Api/suppliers_api.php?action=add";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'supplier_code': supplierCodeController.text,
          'supplier_name': supplierNameController.text,
          'contact_person': contactPersonController.text,
          'phone': phoneController.text,
          'email': emailController.text,
          'website': websiteController.text,
          'address': addressController.text,
          'city': cityController.text,
          'state': stateController.text,
          'pin_code': pinCodeController.text,
          'country': countryController.text,
          'gst_number': gstNumberController.text,
          'pan_number': panNumberController.text,
          'payment_terms': paymentTermsController.text,
          'credit_limit': creditLimitController.text,
          'notes': notesController.text,
          'status': statusController.text.isEmpty
              ? 'Active'
              : statusController.text,
          'created_by': '1',
        }),
      );

      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      dynamic result;
      try {
        result = jsonDecode(response.body);
      } catch (e) {
        log('Response is not JSON: ${response.body}');
        showToast('Invalid response from server.', success: false);
        return;
      }

      if (response.statusCode == 200 && result['success'] == true) {
        showToast('Supplier added successfully!', success: true);
        clearAllFields();
        Get.back();
      } else {
        showToast(
          'Failed to add supplier: ${result['message'] ?? 'Unknown error'}',
          success: false,
        );
      }
    } catch (e) {
      showToast('Something went wrong: $e', success: false);
      log('Error adding supplier: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear all text fields
  void clearAllFields() {
    supplierCodeController.clear();
    supplierNameController.clear();
    contactPersonController.clear();
    phoneController.clear();
    emailController.clear();
    websiteController.clear();
    addressController.clear();
    cityController.clear();
    stateController.clear();
    pinCodeController.clear();
    countryController.clear();
    gstNumberController.clear();
    panNumberController.clear();
    paymentTermsController.clear();
    creditLimitController.clear();
    notesController.clear();
    statusController.clear();
  }
}
