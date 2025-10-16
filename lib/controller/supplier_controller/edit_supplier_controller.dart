import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditSupplierController extends GetxController {
  // Supplier ID for editing
  final supplierId = "".obs;

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

  void setSupplierId(String id) {
    supplierId.value = id;
  }

  /// PUT API - Update Supplier
  Future<void> updateSupplier() async {
    if (supplierId.value.isEmpty) {
      Get.snackbar('Error', 'Supplier ID is required');
      return;
    }

    isLoading.value = true;

    const String url =
        "https://harbhole.eihlims.com/Api/suppliers_api.php?action=edit";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'supplier_id': supplierId.value,
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
          'updated_by': '1',
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
          'Supplier updated successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to update supplier: ${result['message'] ?? 'Unknown error'}',
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
      log('Error updating supplier: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear all text fields
  void clearAllFields() {
    supplierId.value = "";
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