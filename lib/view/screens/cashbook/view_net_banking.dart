import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/view/component/textfield.dart';

class ViewNetbankingScreen extends StatefulWidget {
  const ViewNetbankingScreen({super.key});

  @override
  State<ViewNetbankingScreen> createState() => _ViewNetbankingScreenState();
}

class _ViewNetbankingScreenState extends State<ViewNetbankingScreen> {
  String? selectedType;
  String? selectedTypeAmount;
  String selectedInOut = "In";
  String selectedPayment = "NetBanking";

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
                          'View Netbanking',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Update Entry',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16.5,
                              fontWeight: FontWeight.bold,
                              color: mainOrange,
                            ),
                          ),
                        ),
                        Text(
                          'Edit',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: mainOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 50),
                    CustomDropdownField<String>(
                      label: "Type",
                      value: selectedType,
                      items: ["All", "Income", "Expense"],
                      getLabel: (val) => val,
                      onChanged: (val) {
                        setState(() {
                          selectedType = val;
                        });
                      },
                      hint: "Select Type",
                    ),
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
                        _buildTypeToggle('In', selectedInOut == "In"),
                        SizedBox(width: Get.width / 30),
                        _buildTypeToggle('Out', selectedInOut == "Out"),
                      ],
                    ),
                    SizedBox(height: Get.height / 50),
                    CustomDropdownField<String>(
                      label: "Amount",
                      value: selectedTypeAmount,
                      items: ["100", "200", "300"],
                      getLabel: (val) => val,
                      onChanged: (val) {
                        setState(() {
                          selectedTypeAmount = val;
                        });
                      },
                      hint: "Select Amount",
                    ),

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
                    SizedBox(height: Get.height / 50),
                    Text(
                      'Reference No',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height / 150),
                    CustomTextField(hint: "Reference No"),
                    SizedBox(height: Get.height / 150),
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height / 150),
                    CustomTextField(hint: "Description"),

                    SizedBox(height: Get.height / 150),
                    UploadFileField(
                      label: "Attachment (image/pdf)",
                      onFileSelected: (path) {},
                    ),
                    SizedBox(height: Get.height / 40),
                  ],
                ),
              ),
            ),
          ),
        ],
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
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
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
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    int maxLines = 1,
  }) {
    final double fieldHeight = maxLines > 1 ? Get.height / 12 : Get.height / 20;
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
        Container(
          height: fieldHeight,
          alignment: maxLines > 1 ? Alignment.topLeft : Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            horizontal: Get.width / 25,
            vertical: Get.height / 100,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF3F7FC),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: Get.width / 30,
              ),
            ),
          ),
        ),
        SizedBox(height: Get.height / 50),
      ],
    );
  }
}
