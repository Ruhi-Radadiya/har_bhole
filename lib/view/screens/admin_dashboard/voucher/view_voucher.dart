import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../model/voucher_model/voucher_model.dart';
import '../../../component/textfield.dart';
import 'add_voucher.dart';

class ViewVouchersScreen extends StatelessWidget {
  ViewVouchersScreen({super.key});

  final dateController = TextEditingController();
  final amountController = TextEditingController();
  final voucherNoController = TextEditingController();
  final refNoController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNoController = TextEditingController();
  final transactionNoController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final lineTotalController = TextEditingController();
  final billToController = TextEditingController();

  final List<String> statusOptions = const ['Approved', 'Pending', 'Rejected'];
  final List<String> voucherTypes = const ['Journal', 'Payment', 'Receipt'];
  final List<String> paymentModes = const ['UPI', 'Cash', 'NetBanking', 'Card'];

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);
    final Voucher voucher = Get.arguments as Voucher;

    // Initialize controllers with voucher data
    dateController.text = voucher.voucherDate ?? '';
    amountController.text = voucher.amount ?? '';
    voucherNoController.text = voucher.voucherNo ?? '';
    refNoController.text = voucher.referenceNo ?? '';
    bankNameController.text = voucher.bankName ?? '';
    accountNoController.text = voucher.accountNumber ?? '';
    transactionNoController.text = voucher.transactionNumber ?? '';
    descriptionController.text = voucher.description ?? '';
    priceController.text = voucher.amount ?? '';
    // lineTotalController.text = voucher. ?? '';
    billToController.text = voucher.billTo ?? '';

    String selectedType = voucher.voucherType ?? 'Journal';
    String selectedPaymentMode = voucher.paymentMode ?? 'UPI';
    final selectedStatus =
        ((voucher.status ?? 'Pending').capitalizeFirst!.trim()).obs;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.only(
                top: Get.height / 25,
                left: Get.width / 25,
                right: Get.width / 25,
                bottom: Get.height / 100,
              ),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Get.back(),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: Get.width / 15),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'View Voucher',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width / 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width / 15),
                ],
              ),
            ),

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Get.width / 30),
                child: Container(
                  padding: EdgeInsets.all(Get.width / 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Voucher Info
                      CustomTextField(
                        hint: 'Date',
                        label: 'Date',
                        controller: dateController,
                        isReadOnly: true,
                        suffixIcon: const Icon(Icons.calendar_today, size: 20),
                      ),
                      SizedBox(height: Get.height / 50),
                      _buildChipSelector(
                        label: 'Type',
                        options: voucherTypes,
                        selectedValue: selectedType,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        hint: '6010.00',
                        label: 'Amount',
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 50),

                      _buildChipSelector(
                        label: 'Payment Mode',
                        options: paymentModes,
                        selectedValue: selectedPaymentMode,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        hint: 'CHB/(PAY)/0002',
                        label: 'Voucher No.',
                        controller: voucherNoController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        hint: '69',
                        label: 'Reference No.',
                        controller: refNoController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        hint: 'hdfc',
                        label: 'Bank Name',
                        controller: bankNameController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        hint: '1234567890',
                        label: 'Account Number',
                        controller: accountNoController,
                        isReadOnly: true,

                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        hint: '5875',
                        label: 'Transaction No.',
                        controller: transactionNoController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        hint: 'avghalkash',
                        label: 'Description',
                        controller: descriptionController,
                        isReadOnly: true,

                        maxLines: 3,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        hint: '500',
                        label: 'Price',
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        hint: '500',
                        label: 'Line Total',
                        controller: lineTotalController,
                        keyboardType: TextInputType.number,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        hint: 'avghalkash',
                        label: 'Bill To',
                        controller: billToController,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 50),

                      UploadFileField(
                        label: 'Reference Document (image/pdf)',
                        onFileSelected: (path) {
                          // handle file
                        },
                      ),
                      SizedBox(height: Get.height / 50),
                      Obx(
                        () => CustomDropdownField<String>(
                          label: 'Status',
                          items: statusOptions,
                          value: selectedStatus.value,
                          getLabel: (status) => status,
                          onChanged: (newValue) {
                            if (newValue != null)
                              selectedStatus.value = newValue;
                          },
                          hint: 'Select Status',
                        ),
                      ),
                      SizedBox(height: Get.height / 50),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to AddVouchersScreen with voucher data
                            Get.to(
                              () => AddVouchersScreen(),
                              arguments: voucher,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            'Edit Voucher',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 22.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 50),
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Delete Voucher",
                              titleStyle: TextStyle(
                                color: const Color(0xffF78520),
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width / 20,
                              ),
                              backgroundColor: Colors.white,
                              radius: 20,
                              barrierDismissible: false,
                              content: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width / 20,
                                  vertical: Get.height / 50,
                                ),
                                child: Text(
                                  "Are you sure you want to delete this voucher?",
                                  style: TextStyle(
                                    color: const Color(0xffF78520),
                                    fontSize: Get.width / 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              textConfirm: "Yes",
                              textCancel: "No",
                              confirmTextColor: const Color(0xffF78520),
                              cancelTextColor: const Color(0xffF78520),
                              buttonColor: Colors.white,
                              onConfirm: () async {
                                // Call deleteVoucher and wait for it
                                await addVoucherController.deleteVoucher(
                                  voucher.voucherId,
                                );

                                // Close dialog first
                                if (Get.isDialogOpen ?? false) Get.back();

                                Get.back();
                              },
                              onCancel: () {
                                if (Get.isDialogOpen ?? false) Get.back();
                              },
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xffF78520),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(color: const Color(0xffF78520)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height / 20),
          ],
        ),
      ),
    );
  }

  Widget _buildChipSelector({
    required String label,
    required List<String> options,
    required String selectedValue,
  }) {
    const Color mainOrange = Color(0xffF78520);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: Get.width / 26,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: Get.height / 150),
        Wrap(
          spacing: Get.width / 40,
          children: options.map((option) {
            final isSelected = option == selectedValue;
            return InkWell(
              onTap: () {
                selectedValue = option;
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 30,
                  vertical: Get.height / 150,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? mainOrange : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: Get.width / 32,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
