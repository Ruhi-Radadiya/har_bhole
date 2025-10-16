import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';
import '../../model/voucher_model/voucher_model.dart';

class AddVoucherController extends GetxController {
  static AddVoucherController get instance => Get.find();

  var isLoading = false.obs;
  var isFetching = false.obs;
  final selectedStatus = RxString('');
  List<String> statusOptions = ['Pending', 'Approved', 'Rejected'];

  var voucherDateController = TextEditingController();
  var voucherTypeController = TextEditingController();
  var amountController = TextEditingController();
  var voucherNoController = TextEditingController();
  var descriptionController = TextEditingController();
  var paymentModeController = TextEditingController();
  var referenceNoController = TextEditingController();
  var referenceDocController = TextEditingController();
  var bankNameController = TextEditingController();
  var accountNumberController = TextEditingController();
  var transactionNumberController = TextEditingController();

  var selectedType = ''.obs;
  var selectedPaymentMode = ''.obs;

  var qtyValue = 1.obs;
  var items = <VoucherItem>[].obs;

  final String postApiUrl =
      'https://harbhole.eihlims.com/Api/general_voucher.php?action=add';
  final String updateApiUrl =
      'https://harbhole.eihlims.com/Api/general_voucher.php?action=edit';
  final String deleteApiUrl =
      'https://harbhole.eihlims.com/Api/general_voucher.php?action=delete';

  void addItem(String name, int qty, double rate) {
    items.add(VoucherItem(item: name, qty: qty, rate: rate, total: qty * rate));
  }

  void clearForm() {
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

  Future<void> submitVoucher() async {
    if (items.isEmpty &&
        descriptionController.text.isNotEmpty &&
        amountController.text.isNotEmpty) {
      double rate = double.tryParse(amountController.text) ?? 0;
      addItem(descriptionController.text, qtyValue.value, rate);
    }

    if (items.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Add at least one item',
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    final body = {
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
      "created_by": "1",
    };

    try {
      final response = await http.post(
        Uri.parse(postApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Voucher submitted successfully!',
          backgroundColor: Colors.green.shade300,
          textColor: Colors.white,
        );
        clearForm();
        await vouchersController.fetchVouchers();
        log('Voucher submitted successfully! Code: ${response.statusCode}');
        log('Response body: ${response.body}');
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to submit voucher. Code: ${response.statusCode}',
          backgroundColor: Colors.red.shade300,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong: $e',
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
      );
      log('Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteVoucher(String voucherId) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse(deleteApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'voucher_id': voucherId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          Fluttertoast.showToast(
            msg: 'Voucher deleted successfully!',
            backgroundColor: Colors.green.shade300,
            textColor: Colors.white,
          );
          await vouchersController.fetchVouchers();
        } else {
          Fluttertoast.showToast(
            msg: data['message'] ?? 'Failed to delete voucher',
            backgroundColor: Colors.red.shade300,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to delete voucher. Code: ${response.statusCode}',
          backgroundColor: Colors.red.shade300,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong: $e',
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
      );
      log('Delete voucher error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateVoucher(String voucherId) async {
    if (items.isEmpty &&
        descriptionController.text.isNotEmpty &&
        amountController.text.isNotEmpty) {
      double rate = double.tryParse(amountController.text) ?? 0;
      addItem(descriptionController.text, qtyValue.value, rate);
    }

    if (items.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Add at least one item',
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    final body = {
      'voucher_id': voucherId,
      'voucher_date': voucherDateController.text,
      'voucher_type': selectedType.value.isNotEmpty
          ? selectedType.value
          : voucherTypeController.text,
      'voucher_no': voucherNoController.text,
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
        Uri.parse(updateApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Voucher updated successfully!',
          backgroundColor: Colors.green.shade300,
          textColor: Colors.white,
        );
        clearForm();
        await vouchersController.fetchVouchers();
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to update voucher. Code: ${response.statusCode}',
          backgroundColor: Colors.red.shade300,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong: $e',
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void incrementQty() => qtyValue.value++;

  void decrementQty() {
    if (qtyValue.value > 1) qtyValue.value--;
  }
}
