import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CashEntryController extends GetxController {
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

  /// POST API - Add Cashbook Entry
  Future<void> addCashbookEntry() async {
    isLoading.value = true;

    const String url =
        "https://harbhole.eihlims.com/Api/cashbook_entries_api.php?action=add";

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      // Add required fields
      request.fields['entry_date'] = entryDateController.text;
      request.fields['entry_type'] = entryTypeController.text;
      request.fields['amount'] = amountController.text;
      request.fields['category_id'] = categoryIdController.text;
      request.fields['payment_method'] = paymentMethodController.text;
      request.fields['reference_no'] = referenceNoController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['created_by'] = '1';

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

      log('Cashbook Response: $responseBody');

      final result = jsonDecode(responseBody);

      if (response.statusCode == 200 && result['success'] == true) {
        Get.snackbar(
          'Success',
          'Cashbook entry added successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        clearAllFields();
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          'Failed to add cashbook entry: ${result['message'] ?? 'Unknown error'}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      log('Error adding cashbook entry: $e');
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
