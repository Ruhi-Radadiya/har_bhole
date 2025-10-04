import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/routes/routes.dart';

import '../../component/textfield.dart';

class B2BUserScreen extends StatelessWidget {
  const B2BUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color mainOrange = Color(0xffF78520);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Header
          Container(
            padding: EdgeInsets.only(
              top: Get.height / 25,
              left: Get.width / 25,
              right: Get.width / 25,
              bottom: Get.height / 50,
            ),
            decoration: BoxDecoration(
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
                    Text(
                      'B2B Users',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height / 50),
                SizedBox(
                  height: Get.height / 18,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.createNewb2bUser);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Add B2B Users',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16,
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

          SizedBox(height: Get.height / 50),

          // Search & Filter
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 40),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomTextField(
                      icon: Icons.search,
                      hint: "Search by Name...",
                    ),
                  ),
                ),
                SizedBox(width: Get.width / 40),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width / 40,
                    vertical: Get.height / 200,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "All Status",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: Get.height / 50),

          // User List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              children: [
                _buildRecentUserTile(
                  name: "Rahul Sharma",
                  email: "rahul.sharma@email.com",
                  mobile: "+91 98765 43210",
                  status: "Active",
                  statusColor: Color(0xff4E6B37),
                  statusBgColour: Color(0xffDCE1D7),
                  userCode: "USR001",
                ),
                _buildRecentUserTile(
                  name: "Anjali Gupta",
                  email: "anjali.gupta@email.com",
                  mobile: "+91 91234 56789",
                  status: "Inactive",
                  statusColor: Color(0xffAD111E),
                  statusBgColour: Color(0xffEFCFD2),
                  userCode: "USR002",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentUserTile({
    required String name,
    required String email,
    required String mobile,
    required String status,
    required Color statusColor,
    required Color statusBgColour,
    String? userImagePath,
    required String userCode,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height / 100),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              CircleAvatar(
                radius: Get.width / 16,
                backgroundImage:
                    userImagePath != null && userImagePath.isNotEmpty
                    ? FileImage(File(userImagePath)) as ImageProvider
                    : const AssetImage('asset/images/person_image.jpg'),
                backgroundColor: Colors.grey.shade200,
              ),

              SizedBox(width: Get.width / 25),

              // User Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: Get.height / 200),
                    Text(
                      email,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: Get.height / 250),
                    Text(
                      mobile,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              // Status + View Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width / 40,
                      vertical: Get.height / 200,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColour,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 120),
                  GestureDetector(
                    onTap: () {
                      Get.snackbar("User", "View Details of $userCode");
                      // Example: Get.toNamed(Routes.viewDetails, arguments: userCode);
                    },
                    child: Text(
                      'View Details',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: const Color(0xff2A86D1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Divider
        Divider(height: Get.height / 200, color: Colors.grey.shade300),
      ],
    );
  }
}
