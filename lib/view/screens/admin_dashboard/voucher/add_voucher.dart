import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../model/voucher_model/voucher_model.dart';
import '../../../component/textfield.dart';

class AddVouchersScreen extends StatefulWidget {
  const AddVouchersScreen({super.key});

  @override
  State<AddVouchersScreen> createState() => _AddVouchersScreenState();
}

class _AddVouchersScreenState extends State<AddVouchersScreen> {
  Voucher? editingVoucher;

  String selectedType = 'Journal';
  String selectedPaymentMode = 'Cash';
  final List<String> statusOptions = const ['Approved', 'Pending', 'Rejected'];
  int qtyValue = 1;

  @override
  void initState() {
    super.initState();

    // Check if a voucher was passed for editing
    if (Get.arguments != null && Get.arguments is Voucher) {
      editingVoucher = Get.arguments as Voucher;
      _fillFormWithVoucher(editingVoucher!);
    }
  }

  void _fillFormWithVoucher(Voucher voucher) {
    addVoucherController.voucherDateController.text = voucher.voucherDate ?? '';
    addVoucherController.amountController.text = voucher.amount ?? '';
    addVoucherController.voucherNoController.text = voucher.voucherNo ?? '';
    addVoucherController.referenceNoController.text = voucher.referenceNo ?? '';
    addVoucherController.bankNameController.text = voucher.bankName ?? '';
    addVoucherController.accountNumberController.text =
        voucher.accountNumber ?? '';
    addVoucherController.transactionNumberController.text =
        voucher.transactionNumber ?? '';
    addVoucherController.descriptionController.text = voucher.description ?? '';
    addVoucherController.referenceDocController.text =
        voucher.referenceDoc ?? '';
    addVoucherController.selectedStatus.value = voucher.status ?? 'Pending';
    selectedType = voucher.voucherType ?? 'Journal';
    selectedPaymentMode = voucher.paymentMode ?? 'Cash';
  }

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

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
                        editingVoucher != null ? 'Edit Voucher' : 'Add Voucher',
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
                      CustomDateField(
                        label: 'Date',
                        controller: addVoucherController.voucherDateController,
                      ),
                      SizedBox(height: Get.height / 60),

                      _buildChipSelector(
                        label: 'Type',
                        options: const ['Journal', 'Payment', 'Receipt'],
                        selectedValue: selectedType,
                        optionColors: [
                          Color(0xff4E6B37),
                          Color(0xffA67014),
                          Color(0xffB52934),
                        ],
                        onSelect: (value) {
                          setState(() => selectedType = value);
                          addVoucherController.voucherTypeController.text =
                              value;
                        },
                      ),

                      CustomTextField(
                        label: 'Amount',
                        hint: '6010.00',
                        controller: addVoucherController.amountController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 50),

                      _buildChipSelector(
                        label: 'Payment Mode',
                        options: const ['UPI', 'Cash', 'NetBanking', 'Card'],
                        selectedValue: selectedPaymentMode,
                        optionColors: [
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.black,
                        ],
                        onSelect: (value) {
                          setState(() => selectedPaymentMode = value);
                          addVoucherController.paymentModeController.text =
                              value;
                        },
                      ),

                      CustomTextField(
                        label: 'Voucher No.',
                        hint: 'CHB/(PAY)/0002',
                        controller: addVoucherController.voucherNoController,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        label: 'Reference No',
                        hint: '69',
                        controller: addVoucherController.referenceNoController,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        label: 'Bank Name',
                        hint: 'HDFC',
                        controller: addVoucherController.bankNameController,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        label: 'Account Number',
                        hint: '1234567890',
                        controller:
                            addVoucherController.accountNumberController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        label: 'Transaction No',
                        hint: '5875',
                        controller:
                            addVoucherController.transactionNumberController,
                      ),
                      SizedBox(height: Get.height / 50),

                      CustomTextField(
                        label: 'Description',
                        hint: 'Description here',
                        controller: addVoucherController.descriptionController,
                        maxLines: 3,
                      ),
                      SizedBox(height: Get.height / 50),

                      UploadFileField(
                        label: 'Reference Document (image/pdf)',
                        onFileSelected: (path) {
                          addVoucherController.referenceDocController.text =
                              path;
                        },
                      ),
                      SizedBox(height: Get.height / 50),

                      Obx(
                        () => CustomDropdownField<String>(
                          label: 'Status',
                          items: addVoucherController.statusOptions,
                          value:
                              addVoucherController.selectedStatus.value.isEmpty
                              ? null
                              : addVoucherController.selectedStatus.value,
                          getLabel: (status) => status,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              addVoucherController.selectedStatus.value =
                                  newValue;
                            }
                          },
                          hint: 'Select Status',
                        ),
                      ),

                      SizedBox(height: Get.height / 50),

                      // Save / Update button
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            addVoucherController.voucherTypeController.text =
                                selectedType;
                            addVoucherController.paymentModeController.text =
                                selectedPaymentMode;

                            if (editingVoucher != null) {
                              // Update existing voucher
                              await addVoucherController.updateVoucher(
                                editingVoucher!.voucherId,
                              );
                            } else {
                              // Add new voucher
                              await addVoucherController.submitVoucher();
                            }

                            vouchersController.fetchVouchers();
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            editingVoucher != null
                                ? 'Update Voucher'
                                : 'Save Voucher',
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
    required List<Color> optionColors,
    required void Function(String) onSelect,
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
          runSpacing: Get.height / 150,
          children: List.generate(options.length, (index) {
            final option = options[index];
            final optionColor = optionColors[index];
            final isSelected = option == selectedValue;

            return InkWell(
              onTap: () => onSelect(option),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 30,
                  vertical: Get.height / 150,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? mainOrange.withOpacity(0.2)
                      : Color(0xffF7F3F1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  option,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 32,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? mainOrange : optionColor,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(height: Get.height / 50),
      ],
    );
  }
}
