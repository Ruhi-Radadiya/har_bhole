import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../routes/routes.dart';
import '../../../component/textfield.dart';

class ViewOrderAnalytics extends StatelessWidget {
  const ViewOrderAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xffF78520)),
                  onPressed: () => Get.back(),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: Get.width / 15),
                ),
                SizedBox(width: Get.width / 100),
                Text(
                  'Order Analytics',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffF78520),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Get.width / 30),
              child: Column(
                children: [
                  Container(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'All Order',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: Get.width / 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height / 50),
                        _buildCurrentStockField(),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Customer',
                          hint: 'admin',
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Mobile',
                          hint: '+91 95634 32654',
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Amount',
                          hint: '₹1,142.00',
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Statue',
                          hint: 'Pending',
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Payment ',
                          hint: 'Pending',
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Created',
                          hint: 'sep 16, 2025 11:22 AM',
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        SizedBox(
                          height: Get.height / 18,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(Routes.orderAnalyticsInvoice);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'View Invoice',
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
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height / 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStockField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order',
          style: TextStyle(
            fontSize: Get.width / 26,
            fontWeight: FontWeight.w500,
            color: Color(0xff000000),
          ),
        ),
        SizedBox(height: Get.height / 150),
        Container(
          height: Get.height / 20,
          padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
          decoration: BoxDecoration(
            color: const Color(0xffF3F7FC),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ord12032332',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: Get.width / 30,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xff858585),
                size: 20,
              ),
            ],
          ),
        ),
        SizedBox(height: Get.height / 50),
      ],
    );
  }
}
