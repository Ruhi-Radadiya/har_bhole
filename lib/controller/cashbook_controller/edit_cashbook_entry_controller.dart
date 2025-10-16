import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditCashEntryController extends GetxController {
  // Entry ID for editing
  final entryId = "".obs;

  /// Text controllers
  final entryDateController = TextEditingController();
  final entryTypeController = TextEditingController(); // Income/Expense
  final amountController = TextEditingController();
  final categoryIdController = TextEditingController();
  final paymentMethodController = TextEditingController();
  final referenceNoController = TextEditingController();
  final descriptionController = TextEditingController();

  /// Attachment
  Rx<File?> attachmentFile = Rx<File?>(null);

  /// Loading state
  RxBool isLoading = false.obs;

  void setEntryId(String id) {
    entryId.value = id;
  }

  /// Load existing cashbook entry data
  Future<void> loadEntryData() async {
    if (entryId.value.isEmpty) return;

    try {
      isLoading.value = true;
      
      final response = await http.get(
        Uri.parse('https://harbhole.eihlims.com/Api/cashbook_entries_api.php?action=get&entry_id=${entryId.value}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['entry'] != null) {
          final entry = data['entry'];
          entryDateController.text = entry['entry_date'] ?? '';
          entryTypeController.text = entry['entry_type'] ?? '';
          amountController.text = entry['amount']?.toString() ?? '';
          categoryIdController.text = entry['category_id']?.toString() ?? '';
          paymentMethodController.text = entry['payment_method'] ?? '';
          referenceNoController.text = entry['reference_no'] ?? '';
          descriptionController.text = entry['description'] ?? '';
        }
      }
    } catch (e) {
      log('Error loading entry data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Set existing data for editing (manual)
  void setEntryData({
    required String date,
    required String type,
    required String amount,
    required String categoryId,
    required String paymentMethod,
    required String referenceNo,
    required String description,
  }) {
    entryDateController.text = date;
    entryTypeController.text = type;
    amountController.text = amount;
    categoryIdController.text = categoryId;
    paymentMethodController.text = paymentMethod;
    referenceNoController.text = referenceNo;
    descriptionController.text = description;
  }

  /// PUT API - Update Cashbook Entry
  Future<void> updateCashbookEntry() async {
    if (entryId.value.isEmpty) {
      Get.snackbar('Error', 'Entry ID is required');
      return;
    }

    isLoading.value = true;

    const String url =
        "https://harbhole.eihlims.com/Api/cashbook_entries_api.php?action=edit";

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      // Add required fields
      request.fields['entry_id'] = entryId.value;
      request.fields['entry_date'] = entryDateController.text;
      request.fields['entry_type'] = entryTypeController.text;
      request.fields['amount'] = amountController.text;
      request.fields['category_id'] = categoryIdController.text;
      request.fields['payment_method'] = paymentMethodController.text;
      request.fields['reference_no'] = referenceNoController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['updated_by'] = '1';

      // Attach file if selected
      if (attachmentFile.value != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'attachment',
            attachmentFile.value!.path,
          ),
        );
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      log('Cashbook Update Response: $responseBody');

      final result = jsonDecode(responseBody);

      if (response.statusCode == 200 && result['success'] == true) {
        Get.snackbar(
          'Success',
          'Cashbook entry updated successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to update cashbook entry: ${result['message'] ?? 'Unknown error'}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      log('Error updating cashbook entry: $e');
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear all fields
  void clearAllFields() {
    entryId.value = "";
    entryDateController.clear();
    entryTypeController.clear();
    amountController.clear();
    categoryIdController.clear();
    paymentMethodController.clear();
    referenceNoController.clear();
    descriptionController.clear();
    attachmentFile.value = null;
  }
}