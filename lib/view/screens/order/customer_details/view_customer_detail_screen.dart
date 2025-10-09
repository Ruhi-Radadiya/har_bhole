import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/textfield.dart';

class ViewCustomerDetailScreen extends StatelessWidget {
  const ViewCustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Edit Profile',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: Get.width / 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffF78520),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: Get.height / 50),
                          CustomTextField(
                            label: 'Name',
                            hint: 'tstt',
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            label: 'Email',
                            hint: 'testt@gmail.com',
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            label: 'Mobile',
                            hint: '93652 36985',
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            label: 'Current Password',
                            hint: 'admin 1',
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            label: 'Password',
                            hint: 'Password',
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            label: 'City ',
                            hint: 'Surat',
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            label: 'Address ',
                            hint: 'Address',
                            isReadOnly: true,
                          ),

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
                                "Save Change",
                                style: GoogleFonts.poppins(
                                  fontSize: Get.width / 22.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height / 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Orders Summary",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Color(0xffF78520),
                                    fontWeight: FontWeight.w700,
                                    fontSize: Get.width / 20,
                                  ),
                                ),
                              ),
                              Text(
                                "Edit",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Color(0xffF78520),
                                    fontWeight: FontWeight.w500,
                                    fontSize: Get.width / 26,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomDropdownField(
                            label: "Total Orders",
                            items: [1, 2, 3],
                            value: (),
                            getLabel: (item) => item.toString(),
                            onChanged: (value) {},
                          ),
                          SizedBox(height: Get.height / 60),
                          CustomTextField(
                            label: 'Time Spent ',
                            hint: '₹0.00',
                            isReadOnly: true,
                          ),
                          SizedBox(height: Get.height / 60),
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
                                'View Order',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: Get.width / 22.5,
                                    color: Color(0xffF78520),
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
      ),
    );
  }
}
