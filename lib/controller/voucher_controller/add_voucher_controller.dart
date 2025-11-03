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

  // ---------------- Controllers ----------------
  final voucherDateController = TextEditingController();
  final voucherTypeController = TextEditingController();
  final amountController = TextEditingController();
  final voucherNoController = TextEditingController();
  final descriptionController = TextEditingController();
  final paymentModeController = TextEditingController();
  final referenceNoController = TextEditingController();
  final referenceDocController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final transactionNumberController = TextEditingController();
  final billToController = TextEditingController();
  final voucherCodeController = TextEditingController();

  var selectedType = ''.obs;
  var selectedPaymentMode = ''.obs;

  var qtyValue = 1.obs;
  var items = <VoucherItem>[].obs;
  final Map<String, int> statusMap = {
    'Pending': 1,
    'Approved': 2,
    'Rejected': 3,
  };

  final String postApiUrl =
      'https://harbhole.eihlims.com/Api/general_voucher.php?action=add';
  final String updateApiUrl =
      'https://harbhole.eihlims.com/Api/general_voucher.php?action=edit';
  final String deleteApiUrl =
      'https://harbhole.eihlims.com/Api/general_voucher.php?action=delete';

  // ---------------- Helper Methods ----------------

  void addItem(String name, int qty, double rate) {
    items.add(VoucherItem(item: name, qty: qty, rate: rate, total: qty * rate));
    _recalculateTotal();
  }

  void removeItem(int index) {
    items.removeAt(index);
    _recalculateTotal();
  }

  void _recalculateTotal() {
    double total = items.fold(0, (sum, item) => sum + (item.total ?? 0));
    amountController.text = total.toStringAsFixed(2);
  }

  void clearForm() {
    voucherDateController.clear();
    voucherTypeController.clear();
    amountController.clear();
    voucherNoController.clear();
    descriptionController.clear();
    paymentModeController.clear();
    referenceNoController.clear();
    referenceDocController.clear();
    bankNameController.clear();
    accountNumberController.clear();
    transactionNumberController.clear();
    billToController.clear();
    voucherCodeController.clear();

    selectedType.value = '';
    selectedPaymentMode.value = '';
    selectedStatus.value = '';
    qtyValue.value = 1;
    items.clear();
  }

  // ---------------- AUTO VOUCHER NUMBER LOGIC ----------------
  void generateVoucherNo(String type) {
    String prefix = 'OHB';
    String code = '';
    switch (type.toLowerCase()) {
      case 'receipt':
        code = 'REC';
        break;
      case 'payment':
        code = 'PAY';
        break;
      case 'journal':
        code = 'JOU';
        break;
      default:
        code = 'GEN';
    }

    final count = DateTime.now().millisecondsSinceEpoch % 10000;
    final formattedCount = count.toString().padLeft(4, '0');
    voucherNoController.text = '$prefix/$code/$formattedCount';
    log('🔢 Auto-generated Voucher No: ${voucherNoController.text}');
  }

  // ---------------- API: Submit ----------------
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

    // Auto-generate voucher number if empty
    if (voucherNoController.text.isEmpty) {
      generateVoucherNo(
        selectedType.value.isNotEmpty
            ? selectedType.value
            : voucherTypeController.text,
      );
    }

    isLoading.value = true;

    final body = {
      "voucher_date": voucherDateController.text,
      "voucher_type": selectedType.value.isNotEmpty
          ? selectedType.value
          : voucherTypeController.text,
      "voucher_no": voucherNoController.text,
      "bill_to": billToController.text,
      "amount": double.tryParse(amountController.text) ?? 0,
      "description": descriptionController.text,
      "payment_mode": selectedPaymentMode.value.isNotEmpty
          ? selectedPaymentMode.value
          : paymentModeController.text,
      "reference_no": referenceNoController.text,
      "reference_doc": referenceDocController.text,
      "status": statusMap[selectedStatus.value] ?? 1, // default to 1 = Pending
      "bank_name": bankNameController.text,
      "account_number": accountNumberController.text,
      "transaction_number": transactionNumberController.text,
      "voucher_code": voucherCodeController.text,
      "items_json": items.map((e) => e.toJson()).toList(),
      "created_by": "1",
    };

    log('🟠 Add Voucher Body: ${jsonEncode(body)}');

    try {
      final response = await http.post(
        Uri.parse(postApiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      log('🟢 Response: ${response.body}');
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Voucher submitted successfully!',
          backgroundColor: Colors.green.shade300,
          textColor: Colors.white,
        );
        clearForm();
        await vouchersController.fetchVouchers();
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
      log('❌ Submit voucher error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------- API: Update ----------------
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

    // Auto-generate voucher number if empty
    if (voucherNoController.text.isEmpty) {
      generateVoucherNo(
        selectedType.value.isNotEmpty
            ? selectedType.value
            : voucherTypeController.text,
      );
    }

    isLoading.value = true;

    final body = {
      "voucher_id": voucherId,
      "voucher_date": voucherDateController.text,
      "voucher_type": selectedType.value.isNotEmpty
          ? selectedType.value
          : voucherTypeController.text,
      "voucher_no": voucherNoController.text,
      "bill_to": billToController.text,
      "amount": double.tryParse(amountController.text) ?? 0,
      "description": descriptionController.text,
      "payment_mode": selectedPaymentMode.value.isNotEmpty
          ? selectedPaymentMode.value
          : paymentModeController.text,
      "reference_no": referenceNoController.text,
      "reference_doc": referenceDocController.text,
      "status": statusMap[selectedStatus.value] ?? 1, // default to 1 = Pending
      "bank_name": bankNameController.text,
      "account_number": accountNumberController.text,
      "transaction_number": transactionNumberController.text,
      "voucher_code": voucherCodeController.text,
      "items_json": items.map((e) => e.toJson()).toList(),
      "updated_by": "1",
    };

    log('🟣 Update Voucher Body: ${jsonEncode(body)}');

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
      log('❌ Update voucher error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------- Delete ----------------
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
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong: $e',
        backgroundColor: Colors.red.shade300,
        textColor: Colors.white,
      );
      log('❌ Delete voucher error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateVoucherNo(String type) {
    String prefix = '';
    switch (type) {
      case 'Journal':
        prefix = 'CHB/JRN/';
        break;
      case 'Payment':
        prefix = 'CHB/PAY/';
        break;
      case 'Receipt':
        prefix = 'CHB/RCPT/';
        break;
      default:
        prefix = 'CHB/GEN/';
    }

    try {
      // Use dynamic count from the vouchersController list
      final allVouchers = vouchersController.voucherList;
      int nextNumber = (allVouchers.isNotEmpty ? allVouchers.length + 1 : 1);

      String formattedNo = nextNumber.toString().padLeft(4, '0');
      voucherNoController.text = '$prefix$formattedNo';

      log('🧾 Dynamic Voucher No generated: ${voucherNoController.text}');
    } catch (e) {
      log('⚠️ Error generating dynamic voucher no: $e');
      voucherNoController.text = '${prefix}0001';
    }
  }

  void incrementQty() => qtyValue.value++;
  void decrementQty() {
    if (qtyValue.value > 1) qtyValue.value--;
  }
}
