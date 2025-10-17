import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';
import 'package:har_bhole/view/component/textfield.dart';

import '../../../../routes/routes.dart';

class CashbookScreen extends StatelessWidget {
  const CashbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: Get.height / 25,
                  left: Get.width / 25,
                  right: Get.width / 25,
                  bottom: Get.height / 50,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    colors: [Color(0xffFFE1C7), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 1.0],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height / 100),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Color(0xffFAD6B5),
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(
                            height: Get.width / 15,
                            width: Get.width / 15,
                            child: Image.asset('asset/icons/users_icon.png'),
                          ),
                        ),
                        SizedBox(width: Get.width / 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cashbook',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: Get.width / 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height / 200),
                            Text(
                              'Manage all cashbook',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: Get.width / 28,
                                  color: Color(0xff4A4541),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 50),
                    SizedBox(
                      height: Get.height / 18,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.createCashbookEntry);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffF78520),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Add Entry',
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
                    SizedBox(
                      height: Get.height / 18,
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: Color(0xffF78520),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Export CSV',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 22.5,
                              color: mainOrange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height / 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cashbook',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Get.width / 20,
                              color: Color(0xff747784),
                            ),
                          ),
                        ),
                        Text(
                          'View All',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: Get.width / 26,
                              fontWeight: FontWeight.w500,
                              color: mainOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 80),
                    Container(
                      padding: EdgeInsets.all(Get.width / 28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- Chips Row ---
                          Wrap(
                            spacing: Get.width / 50,
                            children: [
                              _buildCashChip(
                                label: 'Cash In: ₹100.00',
                                color: Color(0xff4E6B37),
                                bgColor: Color(0xffDCE1D7),
                              ),
                              _buildCashChip(
                                label: 'Cash In: ₹0.00',
                                color: Color(0xffB52934),
                                bgColor: Color(0xffEFCFD2),
                              ),
                              _buildCashChip(
                                label: 'Cash In: ₹100.00',
                                color: Color(0xffA67014),
                                bgColor: Color(0xffFFF9E8),
                              ),
                            ],
                          ),

                          SizedBox(height: Get.height / 50),

                          // --- Search Box ---
                          CustomTextField(
                            hint: "Reference/Description",
                            icon: Icons.search,
                          ),

                          SizedBox(height: Get.height / 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildFilterField(
                                label: "Type",
                                child: _buildFilterDropdown(label: "All"),
                              ),
                              _buildFilterField(
                                label: "Status",
                                child: _buildFilterDropdown(label: "All"),
                              ),
                              _buildFilterField(
                                label: "From",
                                child: _buildDateFilter(date: "25/09/2024"),
                              ),
                              _buildFilterField(
                                label: "To",
                                child: _buildDateFilter(date: "25/09/2024"),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height / 30),
                          Obx(() {
                            if (cashbookController.entries.isEmpty) {
                              return const Center(
                                child: Text("No entries found"),
                              );
                            }

                            return Column(
                              children: cashbookController.entries.map((entry) {
                                return Container(
                                  padding: EdgeInsets.all(Get.width / 30),
                                  margin: EdgeInsets.only(
                                    bottom: Get.height / 50,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            entry.paymentMethod.isNotEmpty
                                                ? entry.paymentMethod
                                                : "Unknown",
                                            style: TextStyle(
                                              fontSize: Get.width / 26,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "₹${entry.amount}",
                                            style: TextStyle(
                                              fontSize: Get.width / 28,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                Routes.viewNetbanking,
                                                arguments: entry,
                                              );
                                            },
                                            child: Container(
                                              child: Text(
                                                "View Details",
                                                style: TextStyle(
                                                  fontSize: Get.width / 32,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCashChip({
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width / 65,
        vertical: Get.height / 130,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: Get.width / 36,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown({required String label}) {
    return Container(
      width: Get.width / 4.5,
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
                fontSize: Get.width / 40,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDateFilter({required String date}) {
    return Container(
      width: Get.width / 4.5,
      height: Get.height / 22,
      padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        date,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: Get.width / 40,
            color: Colors.grey.shade700,
          ),
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
            style: TextStyle(
              fontSize: Get.width / 30,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: Get.height / 140),
          child,
        ],
      ),
    );
  }
}
