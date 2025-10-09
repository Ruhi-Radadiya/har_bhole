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

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

      child: Scaffold(
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
                      CustomDateField(
                        label: "Date",
                        controller: TextEditingController(),
                        onTap: () => _selectDate(),
                        hint: "Select Date",
                      ),
                      SizedBox(height: Get.height / 50),

                      // User Dropdown and IN/OUT Toggle
                      Row(
                        children: [
                          // User Dropdown
                          Expanded(
                            flex: 2,
                            child: CustomDropdownField(
                              label: "User",
                              items: userList,
                              value: selectedUser,
                              getLabel: (item) => item.toString(),
                              onChanged: (value) {
                                setState(() {
                                  selectedUser = value;
                                });
                              },
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
                                    textStyle: TextStyle(
                                      fontSize: Get.width / 26,
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

                      CustomTextField(
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
                              textStyle: TextStyle(
                                fontSize: Get.width / 26,
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

                      CustomTextField(
                        label: 'Reference No',
                        hint: 'Optional Reference',
                        controller: _referenceController,
                      ),

                      SizedBox(height: Get.height / 50),
                      CustomTextField(
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
                              textStyle: TextStyle(
                                fontSize: Get.width / 22.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
            SizedBox(height: Get.height / 30),
          ],
        ),
      ),
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
                  fontSize: Get.width / 30,
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
              fontSize: Get.width / 30,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
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
