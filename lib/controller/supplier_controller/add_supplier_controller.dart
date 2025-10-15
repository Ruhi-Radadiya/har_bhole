import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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

  /// Loading state
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    generateNextSupplierCode();
  }

  /// Generate supplier code automatically
  Future<void> generateNextSupplierCode() async {
    const String getApiUrl =
        "https://harbhole.eihlims.com/api/suppliers_api.php?action=list";

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
        Get.snackbar(
          'Error',
          'Invalid response from server.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (response.statusCode == 200 && result['success'] == true) {
        Get.snackbar(
          'Success',
          'Supplier added successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        clearAllFields();
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          'Failed to add supplier: ${result['message'] ?? 'Unknown error'}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
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
