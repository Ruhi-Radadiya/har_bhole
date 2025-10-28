import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../model/cashbook_model/cashbook_model.dart';
import '../../../component/textfield.dart';
import 'creat_cashbook_entry.dart';

class ViewNetbankingScreen extends StatefulWidget {
  const ViewNetbankingScreen({super.key});

  @override
  State<ViewNetbankingScreen> createState() => _ViewNetbankingScreenState();
}

class _ViewNetbankingScreenState extends State<ViewNetbankingScreen> {
  late CashbookEntry entry;

  String selectedInOut = "In";
  String selectedPayment = "NetBanking";

  @override
  void initState() {
    super.initState();
    entry = Get.arguments as CashbookEntry;

    selectedPayment = entry.paymentMethod.isNotEmpty
        ? entry.paymentMethod
        : "NetBanking";
    selectedInOut = entry.entryType.isNotEmpty ? entry.entryType : "In";
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
            // --- Header ---
            Container(
              padding: EdgeInsets.only(
                left: Get.width / 25,
                right: Get.width / 25,
                bottom: Get.height / 100,
              ),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
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
                        'View Netbanking',
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

            // --- Body ---
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
                      // --- Header ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Entry Details',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 22,
                                fontWeight: FontWeight.bold,
                                color: mainOrange,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Add/Edit Cashbook Screen
                              Get.to(
                                CreateCashbookEntryScreen(),
                                arguments: entry,
                              );
                            },
                            child: Container(
                              child: Text(
                                'Edit',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: Get.width / 26,
                                    fontWeight: FontWeight.w600,
                                    color: mainOrange,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Date",
                        hint: entry.entryDate.split(' ').first,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        hint: entry.entryType,
                        label: "Type",
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Amount",
                        hint: entry.amount,
                        isReadOnly: true,
                      ),
                      // --- Payment Method ---
                      Text(
                        'Payment Method',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: Get.width / 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPaymentChip('UPI', selectedPayment == "UPI"),
                          _buildPaymentChip('Cash', selectedPayment == "Cash"),
                          _buildPaymentChip(
                            'NetBanking',
                            selectedPayment == "NetBanking",
                          ),
                          _buildPaymentChip('Card', selectedPayment == "Card"),
                        ],
                      ),
                      SizedBox(height: Get.height / 60),

                      // --- Reference No ---
                      CustomTextField(
                        label: "Reference No",
                        hint: entry.referenceNo,
                        isReadOnly: true,
                      ),

                      // --- Description ---
                      CustomTextField(
                        label: "Description",
                        hint: entry.description,
                        isReadOnly: true,
                      ),

                      // --- Attachment ---
                      entry.attachment.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                // Open PDF or image
                              },
                              child: Text(
                                "Attachment available",
                                style: TextStyle(
                                  fontSize: Get.width / 28,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(height: Get.height / 30),
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Delete Entry",
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
                                  "Are you sure you want to delete this entry?",
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
                                await cashEntryController.deleteCashbookEntry(
                                  entry.entryId,
                                );
                                if (Get.isDialogOpen ?? false) Get.back();
                                Get.back(); // go back after deletion
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
            SizedBox(height: Get.height / 40),
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
          horizontal: Get.width / 30,
          vertical: Get.height / 125,
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
              fontSize: Get.width / 28,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeToggle(String text, bool isSelected) {
    const Color mainOrange = Color(0xffF78520);
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedInOut = text;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width / 18,
          vertical: Get.height / 110,
        ),
        decoration: BoxDecoration(
          color: isSelected ? mainOrange : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: Get.width / 30,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
