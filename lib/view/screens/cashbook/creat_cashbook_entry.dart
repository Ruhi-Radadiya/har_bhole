import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/view/component/textfield.dart';

class CreateCashbookEntryScreen extends StatefulWidget {
  const CreateCashbookEntryScreen({super.key});

  @override
  State<CreateCashbookEntryScreen> createState() =>
      _CreateCashbookEntryScreenState();
}

class _CreateCashbookEntryScreenState extends State<CreateCashbookEntryScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? selectedUser;
  String selectedInOut = "IN";
  String selectedPayment = "UPI";

  // Sample user data - you can replace with your actual user data
  final List<String> userList = [
    "emp001",
    "emp002",
    "emp003",
    "emp004",
    "emp005",
  ];

  final List<String> paymentMethods = ["UPI", "Cash", "NetBanking", "Card"];

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          SizedBox(height: Get.height / 30),
          Container(
            padding: EdgeInsets.only(
              left: Get.width / 25,
              right: Get.width / 25,
              bottom: Get.height / 100,
            ),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                SizedBox(height: Get.height / 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          'Create Cashbook Entry',
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
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Get.width / 17),
              child: Container(
                padding: EdgeInsets.all(Get.width / 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date Field
                    _buildDateField(),
                    SizedBox(height: Get.height / 50),

                    // User Dropdown and IN/OUT Toggle
                    Row(
                      children: [
                        // User Dropdown
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height / 150),
                              Container(
                                height: Get.height / 20,
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width / 25,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xffF3F7FC),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedUser,
                                    hint: Text(
                                      'Select User',
                                      style: TextStyle(
                                        color: const Color(0xff858585),
                                        fontSize: Get.width / 30,
                                      ),
                                    ),
                                    isExpanded: true,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff858585),
                                    ),
                                    style: TextStyle(
                                      fontSize: Get.width / 30,
                                      color: Colors.black,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedUser = newValue;
                                      });
                                    },
                                    items: userList.map((String user) {
                                      return DropdownMenuItem<String>(
                                        value: user,
                                        child: Text(user),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: Get.width / 20),

                        // IN/OUT Toggle
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Type',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height / 150),
                              Row(
                                children: [
                                  _buildInOutToggle(
                                    'IN',
                                    selectedInOut == "IN",
                                  ),
                                  SizedBox(width: Get.width / 40),
                                  _buildInOutToggle(
                                    'OUT',
                                    selectedInOut == "OUT",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: Get.height / 50),

                    // Amount Field
                    _buildField(
                      label: 'Amount',
                      hint: 'Enter your Amount',
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(height: Get.height / 50),

                    // Payment Method
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Method',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 150),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: paymentMethods.map((method) {
                            return _buildPaymentChip(
                              method,
                              selectedPayment == method,
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    SizedBox(height: Get.height / 50),

                    // Reference No Field
                    _buildField(
                      label: 'Reference No',
                      hint: 'Optional Reference',
                      controller: _referenceController,
                    ),

                    SizedBox(height: Get.height / 50),
                    _buildField(
                      label: 'Description',
                      hint: 'Note',
                      controller: _descriptionController,
                      maxLines: 6,
                    ),
                    // Attachment Field
                    UploadFileField(
                      label: "Attachment (image/pdf)",
                      onFileSelected: (path) {
                        print('Selected file: $path');
                      },
                    ),
                    SizedBox(height: Get.height / 30),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: Get.height / 18,
                      child: ElevatedButton(
                        onPressed: _saveEntry,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Save Entry',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff000000),
            ),
          ),
        ),
        SizedBox(height: Get.height / 150),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
            height: Get.height / 20,
            decoration: BoxDecoration(
              color: const Color(0xffF3F7FC),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _getCurrentDate(),
                    style: TextStyle(
                      color: const Color(0xff858585),
                      fontSize: Get.width / 30,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: const Color(0xff858585),
                  size: Get.width / 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInOutToggle(String text, bool isSelected) {
    const Color mainOrange = Color(0xffF78520);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedInOut = text;
          });
        },
        child: Container(
          height: Get.height / 23,
          decoration: BoxDecoration(
            color: isSelected ? mainOrange : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: isSelected ? mainOrange : Colors.grey.shade400,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentChip(String text, bool isSelected) {
    const Color mainOrange = Color(0xffF78520);
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = text;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width / 25,
          vertical: Get.height / 100,
        ),
        decoration: BoxDecoration(
          color: isSelected ? mainOrange : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected ? mainOrange : Colors.grey.shade400,
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff000000),
            ),
          ),
        ),
        SizedBox(height: Get.height / 150),
        CustomTextField(
          hint: hint,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
        ),
      ],
    );
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    return "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // Handle date selection
      print('Selected date: $picked');
    }
  }

  void _saveEntry() {
    // Validate and save the entry
    if (_amountController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter amount',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedUser == null) {
      Get.snackbar(
        'Error',
        'Please select a user',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Save logic here
    final entryData = {
      'date': _getCurrentDate(),
      'user': selectedUser,
      'type': selectedInOut,
      'amount': _amountController.text,
      'paymentMethod': selectedPayment,
      'reference': _referenceController.text,
      'description': _descriptionController.text,
    };

    print('Saving entry: $entryData');

    Get.snackbar(
      'Success',
      'Cashbook entry saved successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Clear form or navigate back
    Get.back();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _referenceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
