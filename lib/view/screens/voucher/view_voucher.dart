import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/textfield.dart';

class ViewVouchersScreen extends StatelessWidget {
  ViewVouchersScreen({super.key});

  final _dateController = TextEditingController(text: '25 Aug 2025');
  final _amountController = TextEditingController(text: '6010.00');
  final _voucherNoController = TextEditingController(text: 'CHB/(PAY)/0002');
  final _refNoController = TextEditingController(text: '69');
  final _bankNameController = TextEditingController(text: 'hdfc');
  final _accountNoController = TextEditingController(text: '1234567890');
  final _transactionNoController = TextEditingController(text: '5875');
  final _descriptionController = TextEditingController(text: 'avghalkash');
  final _priceController = TextEditingController(text: '500');
  final _lineTotalController = TextEditingController(text: '5000.00');
  final _billToController = TextEditingController(text: 'gjbfcjchbdskskc');

  final String _selectedType = 'Journal';
  final String _selectedPaymentMode = 'UPI';
  final String _selectedStatus = 'Approved';
  final List<String> _statusOptions = const ['Approved', 'Pending', 'Rejected'];
  final String _qtyValue = '1';

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
                      'View Vouchers',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                      color: Colors.black.withOpacity(0.05),
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
                          'Update Voucher',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: mainOrange,
                            ),
                          ),
                        ),
                        Text(
                          'Edit',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: mainOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 50),

                    CustomTextField(
                      label: 'Date',
                      hint: '25 Aug 2025',
                      controller: _dateController,
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff858585),
                      ),
                      isReadOnly: true,
                    ),

                    _buildChipSelector(
                      label: 'Type',
                      options: const ['Journal', 'Payment', 'Receipt'],
                      selectedValue: _selectedType,
                      optionColors: [
                        Color(0xff4E6B37),
                        Color(0xffA67014),
                        Color(0xffB52934),
                      ], // unique color for each
                    ),

                    CustomTextField(
                      label: 'Amount',
                      hint: '6010.00',
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff858585),
                      ),
                    ),

                    _buildChipSelector(
                      label: 'Payment Mode',
                      options: const ['UPI', 'Cash', 'NetBanking', 'Card'],
                      selectedValue: _selectedPaymentMode,
                      optionColors: [
                        Color(0xff000000),
                        Color(0xff000000),
                        Color(0xff000000),
                        Color(0xff000000),
                      ],
                    ),

                    CustomTextField(
                      label: 'Voucher No.',
                      hint: 'CHB/(PAY)/0002',
                      controller: _voucherNoController,
                    ),
                    CustomTextField(
                      label: 'Reference No',
                      hint: '69',
                      controller: _refNoController,
                    ),
                    CustomTextField(
                      label: 'Bank Name',
                      hint: 'hdfc',
                      controller: _bankNameController,
                    ),
                    CustomTextField(
                      label: 'Account Number',
                      hint: '1234567890',
                      controller: _accountNoController,
                      keyboardType: TextInputType.number,
                    ),
                    CustomTextField(
                      label: 'Transaction No',
                      hint: '5875',
                      controller: _transactionNoController,
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: Get.height / 100),
                      child: Text(
                        'Items',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: mainOrange,
                          ),
                        ),
                      ),
                    ),

                    CustomTextField(
                      label: 'Description',
                      hint: 'avghalkash',
                      controller: _descriptionController,
                    ),

                    _buildQtyField(),

                    CustomTextField(
                      label: 'Price',
                      hint: '500',
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      icon: Icons.currency_rupee,
                    ),

                    CustomTextField(
                      label: 'Line Total',
                      hint: '5000.00',
                      controller: _lineTotalController,
                      keyboardType: TextInputType.number,
                      isReadOnly: true,
                    ),

                    CustomTextField(
                      label: 'Voucher No.',
                      hint: 'CHB/(PAY)/0002',
                      controller: TextEditingController(text: 'CHB/(PAY)/0002'),
                    ),
                    CustomTextField(
                      label: 'Reference No',
                      hint: '69',
                      controller: TextEditingController(text: '69'),
                    ),
                    SizedBox(height: Get.height / 50),

                    SizedBox(
                      height: Get.height / 18,
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
                      controller: _billToController,
                    ),

                    UploadFileField(
                      label: 'Reference Document (image/pdf)',
                      onFileSelected: (path) {},
                    ),

                    CustomDropdownField<String>(
                      label: 'Status',
                      items: _statusOptions,
                      value: _selectedStatus,
                      getLabel: (status) => status,
                      onChanged: (newValue) {},
                      hint: 'Select Status',
                    ),

                    SizedBox(height: Get.height / 50),

                    SizedBox(
                      height: Get.height / 18,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Update Vouchers',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
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
          SizedBox(height: Get.height / 30),
        ],
      ),
    );
  }

  Widget _buildChipSelector({
    required String label,
    required List<String> options,
    required String selectedValue,
    required List<Color> optionColors,
  }) {
    const Color mainOrange = Color(0xffF78520);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
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
              onTap: () {
                // handle selection
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width / 30,
                  vertical: Get.height / 150,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffF7F3F1),
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
        const Text(
          'QTY',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        ),
        SizedBox(height: Get.height / 150),
        Container(
          height: Get.height / 20,
          width: Get.width / 3, // Constrained width as in the image
          decoration: BoxDecoration(
            color: const Color(0xffF3F7FC),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Minus Button
              InkWell(
                onTap: () {},
                child: Container(
                  width: Get.width / 15,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.remove,
                    size: 18,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              // QTY Value
              Text(
                _qtyValue, // Static QTY value
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: Get.width / 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              // Plus Button
              InkWell(
                onTap: () {},
                child: Container(
                  width: Get.width / 15,
                  alignment: Alignment.center,
                  child: const Icon(Icons.add, size: 18, color: mainOrange),
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
