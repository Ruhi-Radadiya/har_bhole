import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import '../../model/voucher_model/voucher_model.dart';

class EditVoucherController extends GetxController {
  static EditVoucherController get instance => Get.find();

  // Voucher ID for editing
  var voucherId = ''.obs;

  // Loading states
  var isLoading = false.obs;
  var isFetching = false.obs;
  RxString selectedStatus = ''.obs;
  List<String> statusOptions = ['Pending', 'Approved', 'Rejected'];

  // Form fields
  var voucherDateController = TextEditingController();
  var voucherTypeController = TextEditingController();
  var amountController = TextEditingController();
  var descriptionController = TextEditingController();
  var paymentModeController = TextEditingController();
  var referenceNoController = TextEditingController();
  var referenceDocController = TextEditingController();
  var bankNameController = TextEditingController();
  var accountNumberController = TextEditingController();
  var transactionNumberController = TextEditingController();

  // Chip / dropdown selections
  var selectedType = ''.obs;
  var selectedPaymentMode = ''.obs;

  // Qty field
  var qtyValue = 1.obs;

  // Items list
  var items = <VoucherItem>[].obs;

  // API URL
  final String editApiUrl =
      'https://harbhole.eihlims.com/Api/general_voucher.php?action=edit';

  void setVoucherId(String id) {
    voucherId.value = id;
  }

  /// Add an item to voucher
  void addItem(String name, int qty, double rate) {
    items.add(VoucherItem(item: name, qty: qty, rate: rate, total: qty * rate));
  }

  /// Clear form
  void clearForm() {
    voucherId.value = '';
    voucherDateController.clear();
    voucherTypeController.clear();
    amountController.clear();
    descriptionController.clear();
    paymentModeController.clear();
    referenceNoController.clear();
    referenceDocController.clear();
    bankNameController.clear();
    accountNumberController.clear();
    transactionNumberController.clear();
    selectedType.value = '';
    selectedPaymentMode.value = '';
    selectedStatus.value = '';
    qtyValue.value = 1;
    items.clear();
  }

  /// Update voucher (POST)
  Future<void> updateVoucher() async {
    if (voucherId.value.isEmpty) {
      Get.snackbar('Error', 'Voucher ID is required');
      return;
    }

    // Add current input as item if items list is empty
    if (items.isEmpty &&
        descriptionController.text.isNotEmpty &&
        amountController.text.isNotEmpty) {
      double rate = double.tryParse(amountController.text) ?? 0;
      addItem(descriptionController.text, qtyValue.value, rate);
    }

    if (items.isEmpty) {
      Get.snackbar('Error', 'Add at least one item');
      return;
    }

    isLoading.value = true;

    final body = {
      'voucher_id': voucherId.value,
      'voucher_date': voucherDateController.text,
      'voucher_type': selectedType.value.isNotEmpty
          ? selectedType.value
          : voucherTypeController.text,
      'amount': double.tryParse(amountController.text) ?? 0,
      'description': descriptionController.text,
      'payment_mode': selectedPaymentMode.value.isNotEmpty
          ? selectedPaymentMode.value
          : paymentModeController.text,
      'reference_no': referenceNoController.text,
      'reference_doc': referenceDocController.text,
      'status': selectedStatus.value,
      'bank_name': bankNameController.text,
      'account_number': accountNumberController.text,
      'transaction_number': transactionNumberController.text,
      'items_json': items.map((e) => e.toJson()).toList(),
      "updated_by": "1",
    };

    try {
      final response = await http.post(
        Uri.parse(editApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Voucher updated successfully!');
        await vouchersController.fetchVouchers();
        log('Voucher updated successfully! Code: ${response.statusCode}');
        log('Response body: ${response.body}');
      } else {
        Get.snackbar(
          'Error',
          'Failed to update voucher. Code: ${response.statusCode}',
        );
        log('Failed to update voucher. Code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
      log('Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Increment qty
  void incrementQty() => qtyValue.value++;

  /// Decrement qty
  void decrementQty() {
    if (qtyValue.value > 1) qtyValue.value--;
  }
}