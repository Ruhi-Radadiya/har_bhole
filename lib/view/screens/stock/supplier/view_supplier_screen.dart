import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/textfield.dart';

class ViewSupplierScreen extends StatelessWidget {
  const ViewSupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

      child: Scaffold(
        backgroundColor: Colors.white,
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
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xffF78520),
                        ),
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(minWidth: Get.width / 15),
                      ),
                    ],
                  ),
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
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffF78520)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  color: Color(0xffF78520),
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width / 36,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width / 100),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffF78520)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'cancel',
                              style: TextStyle(
                                color: Color(0xffF78520),
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width / 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFilterField(
                            label: "Statue",
                            child: _buildFilterDropdown(label: "Alll Statue"),
                          ),
                          _buildFilterField(
                            label: "City",
                            child: _buildFilterDropdown(label: "All City"),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 40),
                      CustomDropdownField(
                        label: "Code",
                        items: [1, 2, 3],
                        value: "+91 95663 54236",
                        getLabel: (val) {
                          return val.toString();
                        },
                        onChanged: (val) {},
                        hint: "SUP002",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(label: "Name", hint: "Ramesh Kumar"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Phone Number",
                        hint: "+91 95634 32654",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Email Id ",
                        hint: "rameshkumar@gmail.com",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Location",
                        hint: "Mumbai, Maharashtra, India",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(label: "Payment Terms", hint: "Net 85"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Credit Limit",
                        hint: "₹75,000.00",
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(label: "Statue", hint: "Active"),
                      SizedBox(height: Get.height / 60),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffF78520),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Add Suppliers",
                            style: GoogleFonts.poppins(
                              fontSize: Get.width / 22.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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

  Widget _buildFilterField({required String label, required Widget child}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 30,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({required String label}) {
    return Container(
      width: Get.width / 3,
      height: Get.height / 22,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 36,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}
