import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/view/component/textfield.dart';

import '../../../../main.dart';
import '../../../../model/cashbook_model/cashbook_model.dart';

class CreateCashbookEntryScreen extends StatefulWidget {
  const CreateCashbookEntryScreen({super.key});

  @override
  State<CreateCashbookEntryScreen> createState() =>
      _CreateCashbookEntryScreenState();
}

class _CreateCashbookEntryScreenState extends State<CreateCashbookEntryScreen> {
  String selectedInOut = "Income"; // default
  String selectedPayment = "UPI"; // default
  final List<String> paymentMethods = ["UPI", "Cash", "NetBanking", "Card"];

  bool isEditMode = false;
  String? entryId;

  @override
  void initState() {
    super.initState();

    final CashbookEntry? entry = Get.arguments as CashbookEntry?;

    if (entry != null) {
      // --- Edit Mode ---
      isEditMode = true;
      entryId = entry.entryId;

      // Pre-fill controller values
      cashEntryController.entryDateController.text = entry.entryDate;
      cashEntryController.entryTypeController.text = entry.entryType;
      cashEntryController.amountController.text = entry.amount;
      cashEntryController.paymentMethodController.text = entry.paymentMethod;
      cashEntryController.referenceNoController.text = entry.referenceNo;
      cashEntryController.descriptionController.text = entry.description;

      selectedInOut = entry.entryType;
      selectedPayment = entry.paymentMethod;

      if (entry.attachment.isNotEmpty) {
        try {
          cashEntryController.attachmentFile.value = File(entry.attachment);
        } catch (e) {
          cashEntryController.attachmentFile.value = null;
        }
      }
    } else {
      // --- New Entry Mode ---
      isEditMode = false;
      entryId = null;

      // Reset all controllers
      cashEntryController.entryDateController.clear();
      cashEntryController.entryTypeController.clear();
      cashEntryController.amountController.clear();
      cashEntryController.paymentMethodController.clear();
      cashEntryController.referenceNoController.clear();
      cashEntryController.descriptionController.clear();
      cashEntryController.attachmentFile.value = null;

      selectedInOut = "Income";
      selectedPayment = "UPI";
    }
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
            // Header
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
                            isEditMode
                                ? 'Edit Cashbook Entry'
                                : 'Create Cashbook Entry',
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
                        controller: cashEntryController.entryDateController,
                        hint: "Select Date",
                      ),
                      SizedBox(height: Get.height / 50),

                      // Type Dropdown
                      CustomDropdownField<String>(
                        label: "Type",
                        items: ["Income", "Expense"],
                        value:
                            cashEntryController
                                .entryTypeController
                                .text
                                .isNotEmpty
                            ? cashEntryController.entryTypeController.text
                            : "Income",
                        getLabel: (type) => type,
                        onChanged: (value) {
                          if (value != null) {
                            cashEntryController.entryTypeController.text =
                                value;
                            setState(() {
                              selectedInOut = value;
                            });
                          }
                        },
                      ),
                      SizedBox(height: Get.height / 50),

                      // Amount Field
                      CustomTextField(
                        label: 'Amount',
                        hint: 'Enter your Amount',
                        controller: cashEntryController.amountController,
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

                      // Reference No
                      CustomTextField(
                        label: 'Reference No',
                        hint: 'Optional Reference',
                        controller: cashEntryController.referenceNoController,
                      ),
                      SizedBox(height: Get.height / 50),

                      // Description
                      CustomTextField(
                        label: 'Description',
                        hint: 'Note',
                        controller: cashEntryController.descriptionController,
                        maxLines: 6,
                      ),
                      SizedBox(height: Get.height / 30),

                      // Attachment
                      UploadFileField(
                        label: "Attachment (image/pdf)",
                        onFileSelected: (path) {
                          if (path != null && path.isNotEmpty) {
                            cashEntryController.attachmentFile.value = File(
                              path,
                            );
                          } else {
                            cashEntryController.attachmentFile.value = null;
                          }
                        },
                      ),
                      SizedBox(height: Get.height / 30),

                      // Save or Update Button
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: cashEntryController.isLoading.value
                                ? null
                                : () {
                                    // Set type & payment before API call
                                    cashEntryController
                                            .entryTypeController
                                            .text =
                                        selectedInOut;
                                    cashEntryController
                                            .paymentMethodController
                                            .text =
                                        selectedPayment;

                                    if (isEditMode && entryId != null) {
                                      cashEntryController.updateCashbookEntry(
                                        entryId!,
                                      );
                                    } else {
                                      cashEntryController.addCashbookEntry();
                                    }
                                  },
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
                                    isEditMode ? 'Update Entry' : 'Save Entry',
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
}
