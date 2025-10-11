import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/view/component/textfield.dart';

import '../../../../main.dart';

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
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _createdByController = TextEditingController();

  String selectedInOut = "IN";
  String selectedPayment = "Cash";
  int? selectedCategoryId;
  String? attachmentFile;

  // Example users for created_by (replace with actual API/fetch logic)
  final List<Map<String, dynamic>> usersList = [
    {"id": 1, "name": "Admin"},
    {"id": 2, "name": "User1"},
    {"id": 3, "name": "User2"},
  ];
  int? selectedCreatedBy;

  @override
  void initState() {
    super.initState();
    cashEntryController.fetchCategories();
    if (usersList.isNotEmpty) selectedCreatedBy = usersList.first['id'];
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _saveEntry() async {
    if (_amountController.text.isEmpty ||
        _dateController.text.isEmpty ||
        selectedCategoryId == null ||
        selectedCreatedBy == null) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    await cashEntryController.addCashEntry(
      entryDate: _dateController.text,
      entryType: selectedInOut == "IN" ? "Income" : "Expense",
      amount: _amountController.text,
      categoryId: selectedCategoryId!,
      paymentMethod: selectedPayment,
      referenceNo: _referenceController.text,
      description: _descriptionController.text,
      attachment: attachmentFile ?? "",
      createdBy: selectedCreatedBy!,
    );

    Get.snackbar(
      'Success',
      cashEntryController.responseMessage.value,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    Get.back();
  }

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
              padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Get.back(),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Create Cashbook Entry',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
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
                      // Entry Date
                      CustomDateField(
                        label: "Date",
                        controller: _dateController,
                        onTap: _selectDate,
                        hint: "Select Date",
                      ),
                      SizedBox(height: Get.height / 50),

                      // Category Dropdown
                      Obx(() {
                        return CustomDropdownField<int>(
                          label: "Category",
                          items: cashEntryController.categories
                              .map((e) => e['id'] as int)
                              .toList(),
                          value: selectedCategoryId,
                          getLabel: (id) {
                            final cat = cashEntryController.categories
                                .firstWhere((c) => c['id'] == id);
                            return cat['name'] ?? 'Unknown';
                          },
                          onChanged: (value) {
                            setState(() {
                              selectedCategoryId = value;
                            });
                          },
                        );
                      }),
                      SizedBox(height: Get.height / 50),

                      // Entry Type Toggle (IN/OUT)
                      Row(
                        children: [
                          _buildInOutToggle('IN', selectedInOut == "IN"),
                          SizedBox(width: Get.width / 20),
                          _buildInOutToggle('OUT', selectedInOut == "OUT"),
                        ],
                      ),
                      SizedBox(height: Get.height / 50),

                      // Amount
                      CustomTextField(
                        label: 'Amount',
                        hint: 'Enter your Amount',
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 50),

                      // Payment Method Chips
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ["UPI", "Cash", "NetBanking", "Card"]
                            .map(
                              (method) => _buildPaymentChip(
                                method,
                                selectedPayment == method,
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: Get.height / 50),

                      // Reference No
                      CustomTextField(
                        label: 'Reference No',
                        hint: 'Optional Reference',
                        controller: _referenceController,
                      ),
                      SizedBox(height: Get.height / 50),

                      // Description
                      CustomTextField(
                        label: 'Description',
                        hint: 'Note',
                        controller: _descriptionController,
                        maxLines: 6,
                      ),
                      SizedBox(height: Get.height / 50),

                      // Created By Dropdown
                      CustomDropdownField<int>(
                        label: "Created By",
                        items: usersList.map((e) => e['id'] as int).toList(),
                        value: selectedCreatedBy,
                        getLabel: (id) {
                          final user = usersList.firstWhere(
                            (u) => u['id'] == id,
                          );
                          return user['name'] ?? 'Unknown';
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedCreatedBy = value;
                          });
                        },
                      ),
                      SizedBox(height: Get.height / 50),

                      // Attachment Upload
                      UploadFileField(
                        label: "Attachment (image/pdf)",
                        onFileSelected: (path) {
                          attachmentFile = path;
                        },
                      ),
                      SizedBox(height: Get.height / 30),

                      // Save Button
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          height: Get.height / 18,
                          child: ElevatedButton(
                            onPressed: cashEntryController.isLoading.value
                                ? null
                                : _saveEntry,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            ),
                            child: cashEntryController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Save Entry',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
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

  @override
  void dispose() {
    _amountController.dispose();
    _referenceController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
