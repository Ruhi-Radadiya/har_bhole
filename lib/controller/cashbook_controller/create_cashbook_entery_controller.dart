import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:har_bhole/main.dart';
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
  RxString selectedInOut = "In".obs;

  /// Loading state
  RxBool isLoading = false.obs;

  /// ------------------- ADD CASHBOOK ENTRY -------------------
  Future<void> addCashbookEntry() async {
    isLoading.value = true;

    const String url =
        "https://harbhole.eihlims.com/Api/cashbook_entries_api.php?action=add";

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      // Add required fields
      request.fields['entry_date'] =
          cashEntryController.entryDateController.text;
      request.fields['entry_type'] = cashEntryController.selectedInOut.value;
      request.fields['amount'] = amountController.text;
      request.fields['category_id'] = "1";
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
        Fluttertoast.showToast(
          msg: "Cashbook entry added successfully!",
          backgroundColor: Colors.green.shade300,
          textColor: Colors.white,
        );

        clearAllFields();
        await cashbookController.fetchCashbookEntries();
        Get.back();
      } else {
        Fluttertoast.showToast(
          msg:
              "Failed to add cashbook entry: ${result['message'] ?? 'Unknown error'}",
          backgroundColor: Colors.red.shade300,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      log('Error adding cashbook entry: $e');
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ------------------- DELETE CASHBOOK ENTRY -------------------
  Future<void> deleteCashbookEntry(String entryId) async {
    isLoading.value = true;

    const String url =
        "https://harbhole.eihlims.com/Api/cashbook_entries_api.php?action=delete";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'entry_id': entryId}), // ✅ fixed key here
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['success'] == true) {
        Fluttertoast.showToast(
          msg: "Cashbook entry deleted successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // 🔁 Refresh list if needed
        await cashbookController.fetchCashbookEntries();
      } else {
        Fluttertoast.showToast(
          msg: result['message'] ?? "Failed to delete entry",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        debugPrint("Failed to delete entry: ${result['message']}");
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Something went wrong: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red.shade600,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ------------------- CLEAR FORM -------------------
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
