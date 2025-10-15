import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../component/textfield.dart';

class AddVouchersScreen extends StatefulWidget {
  const AddVouchersScreen({super.key});

  @override
  State<AddVouchersScreen> createState() => _AddVouchersScreenState();
}

class _AddVouchersScreenState extends State<AddVouchersScreen> {
  // Inject controller
  String selectedType = 'Journal';
  String selectedPaymentMode = 'Cash';
  String selectedStatus = 'Active';
  final List<String> statusOptions = const ['Approved', 'Pending', 'Rejected'];
  int qtyValue = 1;

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
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
                        'Add Vouchers',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'add Voucher',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 20,
                                fontWeight: FontWeight.bold,
                                color: mainOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 50),

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
                              value; // important!
                        },
                      ),

                      CustomTextField(
                        label: 'Amount',
                        hint: '6010.00',
                        controller: addVoucherController.amountController,
                        keyboardType: TextInputType.number,
                      ),

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
                        controller: addVoucherController.voucherTypeController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Reference No',
                        hint: '69',
                        controller: addVoucherController.referenceNoController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Bank Name',
                        hint: 'hdfc',
                        controller: addVoucherController.bankNameController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Account Number',
                        hint: '1234567890',
                        controller:
                            addVoucherController.accountNumberController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Transaction No',
                        hint: '5875',
                        controller:
                            addVoucherController.transactionNumberController,
                      ),
                      SizedBox(height: Get.height / 60),

                      Padding(
                        padding: EdgeInsets.only(bottom: Get.height / 100),
                        child: Text(
                          'Items',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 20,
                              fontWeight: FontWeight.bold,
                              color: mainOrange,
                            ),
                          ),
                        ),
                      ),

                      CustomTextField(
                        label: 'Description',
                        hint: 'avghalkash',
                        controller: addVoucherController.descriptionController,
                      ),
                      SizedBox(height: Get.height / 60),
                      _buildQtyField(),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Price',
                        hint: '500',
                        controller: addVoucherController
                            .amountController, // reused amount
                        keyboardType: TextInputType.number,
                        icon: Icons.currency_rupee,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Line Total',
                        hint: '5000.00',
                        controller: addVoucherController.amountController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      Text(
                        'Action',
                        style: TextStyle(
                          fontSize: Get.width / 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: Get.height / 18,
                              child: ElevatedButton(
                                onPressed: () {
                                  addVoucherController.addItem(
                                    addVoucherController
                                        .descriptionController
                                        .text,
                                    addVoucherController.qtyValue.value,
                                    double.tryParse(
                                          addVoucherController
                                              .amountController
                                              .text,
                                        ) ??
                                        0,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff88A940),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Save',
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
                          ),
                          SizedBox(width: Get.width / 40),
                          Expanded(
                            child: SizedBox(
                              height: Get.height / 18,
                              child: ElevatedButton(
                                onPressed: addVoucherController.clearForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffD93031),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Cancel',
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
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Reference No',
                        hint: '69',
                        controller: addVoucherController.referenceNoController,
                      ),
                      SizedBox(height: Get.height / 50),
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            addVoucherController.addItem(
                              addVoucherController.descriptionController.text,
                              qtyValue,
                              double.tryParse(
                                    addVoucherController.amountController.text,
                                  ) ??
                                  0,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: mainOrange, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            'Add Item',
                            style: GoogleFonts.poppins(
                              color: mainOrange,
                              fontSize: Get.width / 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 50),
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: addVoucherController.clearForm,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: mainOrange, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            'Clear All',
                            style: GoogleFonts.poppins(
                              color: mainOrange,
                              fontSize: Get.width / 30,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 50),
                      CustomTextField(
                        label: 'Bill To',
                        hint: 'gjbfcjchbdskskc',
                        controller: addVoucherController.amountController,
                      ),
                      SizedBox(height: Get.height / 60),
                      UploadFileField(
                        label: 'Reference Document (image/pdf)',
                        onFileSelected: (path) {
                          addVoucherController.referenceDocController.text =
                              path;
                        },
                      ),
                      SizedBox(height: Get.height / 60),
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
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            addVoucherController.voucherTypeController.text =
                                selectedType;
                            addVoucherController.paymentModeController.text =
                                selectedPaymentMode;
                            await addVoucherController.submitVoucher();
                            vouchersController.fetchVouchers();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Save Vouchers',
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
                      SizedBox(height: Get.height / 80),
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

  Widget _buildQtyField() {
    const Color mainOrange = Color(0xffF78520);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QTY',
          style: TextStyle(
            fontSize: Get.width / 26,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: Get.height / 150),
        Container(
          height: Get.height / 20,
          width: Get.width / 3,
          decoration: BoxDecoration(
            color: Color(0xffF3F7FC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (qtyValue > 1) setState(() => qtyValue--);
                },
                child: Container(
                  width: Get.width / 15,
                  alignment: Alignment.center,
                  child: Icon(Icons.remove, size: 18),
                ),
              ),
              Text(
                '$qtyValue',
                style: TextStyle(
                  fontSize: Get.width / 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () => setState(() => qtyValue++),
                child: Container(
                  width: Get.width / 15,
                  alignment: Alignment.center,
                  child: Icon(Icons.add, size: 18, color: mainOrange),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Get.height / 50),
      ],
    );
  }
}
