import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/model/customer_detail_model/customer_detail_model.dart';

import '../../../component/textfield.dart';

class ViewCustomerDetailScreen extends StatelessWidget {
  const ViewCustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerDetailModel customer = Get.arguments; // ✅ receive data

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
              child: Row(
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
                  SizedBox(width: Get.width / 100),
                  Text(
                    'Customer Detail',
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

            // 🔸 Customer Detail Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Get.width / 25),
                child: Container(
                  padding: EdgeInsets.all(Get.width / 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Profile',
                        style: GoogleFonts.poppins(
                          fontSize: Get.width / 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffF78520),
                        ),
                      ),
                      SizedBox(height: Get.height / 40),

                      // --- Customer Info Fields ---
                      CustomTextField(
                        label: 'Name',
                        hint: customer.name,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Email',
                        hint: customer.email,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Mobile',
                        hint: customer.mobile,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'City',
                        hint: customer.city,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Pincode',
                        hint: customer.pincode,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Status',
                        hint: customer.status,
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Registered On',
                        hint: customer.createdAt,
                        isReadOnly: true,
                      ),
                      if (customer.lastLoginAt != null &&
                          customer.lastLoginAt!.isNotEmpty) ...[
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Last Login',
                          hint: customer.lastLoginAt ?? 'N/A',
                          isReadOnly: true,
                        ),
                      ],
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Login Count',
                        hint: customer.loginCount,
                        isReadOnly: true,
                      ),

                      SizedBox(height: Get.height / 30),

                      // --- Save Button ---
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF78520),
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
                      SizedBox(height: Get.height / 30),

                      // --- Order Summary Section ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Orders Summary",
                            style: GoogleFonts.poppins(
                              color: const Color(0xffF78520),
                              fontWeight: FontWeight.w700,
                              fontSize: Get.width / 20,
                            ),
                          ),
                          Text(
                            "Edit",
                            style: GoogleFonts.poppins(
                              color: const Color(0xffF78520),
                              fontWeight: FontWeight.w500,
                              fontSize: Get.width / 26,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: 'Total Orders',
                        hint: '3 Orders',
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Total Spent',
                        hint: '₹0.00',
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),

                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            // TODO: Navigate to Orders List
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xffF78520),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            'View Orders',
                            style: GoogleFonts.poppins(
                              fontSize: Get.width / 22.5,
                              color: const Color(0xffF78520),
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
}
