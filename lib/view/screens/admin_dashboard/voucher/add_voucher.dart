import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';
import 'package:har_bhole/view/component/frenchies_food_card.dart';

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
  int qtyValue = 1;

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null && Get.arguments is Voucher) {
      editingVoucher = Get.arguments as Voucher;
      _fillFormWithVoucher(editingVoucher!);
    }
  }

  void _fillFormWithVoucher(Voucher voucher) {
    addVoucherController.voucherDateController.text = voucher.voucherDate;
    addVoucherController.amountController.text = voucher.amount;
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
    addVoucherController.billToController.text = voucher.billTo ?? '';
    addVoucherController.voucherCodeController.text = voucher.voucherCode ?? '';
    addVoucherController.selectedStatus.value = voucher.status ?? 'Pending';
    selectedType = voucher.voucherType;
    selectedPaymentMode = voucher.paymentMode ?? 'Cash';

    if (voucher.itemsJson.isNotEmpty) {
      addVoucherController.items.assignAll(voucher.itemsJson);
    }
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
            // ---------------- Header ----------------
            Container(
              padding: EdgeInsets.only(
                top: Get.height / 25,
                left: Get.width / 25,
                right: Get.width / 25,
                bottom: Get.height / 100,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Get.back(),
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

            // ---------------- Body ----------------
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
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CustomTextField(
                      //   label: 'Voucher Code',
                      //   hint: 'GV000015',
                      //   controller: addVoucherController.voucherCodeController,
                      // ),
                      // SizedBox(height: Get.height / 50),
                      CustomDateField(
                        label: 'Date',
                        controller: addVoucherController.voucherDateController,
                      ),
                      SizedBox(height: Get.height / 50),
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
                          addVoucherController.updateVoucherNo(value);
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
                          mainOrange,
                          mainOrange,
                          mainOrange,
                          mainOrange,
                        ],
                        onSelect: (value) {
                          setState(() => selectedPaymentMode = value);
                          addVoucherController.paymentModeController.text =
                              value;
                        },
                      ),
                      CustomTextField(
                        label: 'Voucher No.',
                        hint: 'Auto-generated',
                        controller: addVoucherController.voucherNoController,
                        isReadOnly: true,
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
                      SizedBox(height: Get.height / 50), _buildItemsSection(),
                      SizedBox(height: Get.height / 40),

                      // CustomTextField(
                      //   label: 'Bill To',
                      //   hint: 'Client name',
                      //   controller: addVoucherController.billToController,
                      // ),
                      // SizedBox(height: Get.height / 50),
                      CustomTextField(
                        label: 'Bill To',
                        hint: 'Optional Notes',
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
                          getLabel: (s) => s,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              addVoucherController.selectedStatus.value =
                                  newValue;
                            }
                          },
                          hint: 'Select Status',
                        ),
                      ),
                      SizedBox(height: Get.height / 40),

                      // ---------------- Save Button ----------------
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
                              await addVoucherController.updateVoucher(
                                editingVoucher!.voucherId,
                              );
                            } else {
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

  // ---------------- Helper Widgets ----------------
  Widget _buildChipSelector({
    required String label,
    required List<String> options,
    required List<Color> optionColors,
    required String selectedValue,
    required Function(String) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
        ),
        SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (int i = 0; i < options.length; i++)
              ChoiceChip(
                labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                label: Text(
                  options[i],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: selectedValue == options[i]
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
                selected: selectedValue == options[i],
                selectedColor: optionColors[i],
                backgroundColor: Colors.grey.shade200,
                showCheckmark: false, // ❌ hide the check icon
                side: BorderSide(
                  color: selectedValue == options[i]
                      ? optionColors[i]
                      : Colors.grey.shade400,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onSelected: (_) => onSelect(options[i]),
              ),
          ],
        ),
        SizedBox(height: Get.height / 60),
      ],
    );
  }

  Widget _buildItemsSection() {
    return Obx(() {
      final items = addVoucherController.items;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Items',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          ...items.asMap().entries.map(
            (entry) => ListTile(
              title: Text(entry.value.item ?? ''),
              subtitle: Text(
                'Qty: ${entry.value.qty}, Rate: ${entry.value.rate}, \nTotal: ₹${entry.value.total}',
              ),
              trailing: IconButton(
                icon: Icon(Icons.cancel_outlined, color: Colors.red),
                onPressed: () => addVoucherController.removeItem(entry.key),
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              _showAddItemDialog();
            },
            icon: const Icon(Icons.add, color: mainOrange),
            label: const Text(
              'Add Item',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    });
  }

  void _showAddItemDialog() {
    final itemNameController = TextEditingController();
    final qtyController = TextEditingController(text: '1');
    final rateController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Item',
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomTextField(
              label: 'Item Name',
              controller: itemNameController,
              hint: 'Enter Product Name',
            ),
            CustomTextField(
              label: 'Qty',
              controller: qtyController,
              keyboardType: TextInputType.number,
              hint: '0',
            ),
            CustomTextField(
              label: 'Rate',
              controller: rateController,
              keyboardType: TextInputType.number,
              hint: 'Enter Rate',
            ),
          ],
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          final name = itemNameController.text.trim();
          final qty = int.tryParse(qtyController.text) ?? 1;
          final rate = double.tryParse(rateController.text) ?? 0;
          if (name.isNotEmpty && rate > 0) {
            addVoucherController.addItem(name, qty, rate);
            Get.back();
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: mainOrange),
        child: const Text('Add', style: TextStyle(color: Colors.white)),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: const Text('Cancel', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
