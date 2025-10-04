import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/routes/routes.dart';

import '../../../main.dart';

class UserDashboardScreen extends StatelessWidget {
  UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F9FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: Get.width / 15,
                top: Get.height / 60,
                bottom: Get.height / 45,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffFFE1C7), Color(0xffF6E9DE)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height / 30),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: Color(0xffF8D3B3),
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
                            'User Dashboard',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height / 200),
                          Text(
                            'Manage all registered users',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 13,
                                color: Color(0xff4A4541),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height / 100),
                ],
              ),
            ),
            // Main Content
            Padding(
              padding: EdgeInsets.only(
                left: Get.width / 18,
                right: Get.width / 18,
              ),
              child: Column(
                children: [
                  // Statistics Grid
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: Get.width / 30,
                      mainAxisSpacing: Get.height / 80,
                      childAspectRatio: 1.1,
                      children: [
                        _buildStatCard(
                          value: userController.totalUsersCount.toString(),
                          label: 'Total Users',
                          valueColor: Color(0xff004CAF),
                          changePercent: '+12%',
                          image: "asset/icons/users_icon.png",
                          iconColor: Color(0xff004CAF),
                          iconBgColor: Color(0xffCCDBEF),
                        ),
                        _buildStatCard(
                          value: userController.activeUsersCount.toString(),
                          label: 'Active Users',
                          valueColor: Color(0xff73A70B),
                          changePercent: '+8%',
                          image: "asset/icons/active_user_icon.png",
                          iconColor: Color(0xff73A70B),
                          iconBgColor: Color(0xffDCE1D2),
                        ),
                        _buildStatCard(
                          value: userController.inactiveUsersCount.toString(),
                          label: 'Inactive Users',
                          valueColor: Color(0xffE91212),
                          changePercent: '+12%',
                          image: "asset/icons/inactive_user_icon.png",
                          iconColor: Color(0xffE91212),
                          iconBgColor: Color(0xffFDD2D2),
                        ),
                        _buildStatCard(
                          value: userController.newUsersThisMonth.toString(),
                          label: 'New This Month',
                          valueColor: Color(0xff273692),
                          changePercent: '+24%',
                          image: "asset/icons/new_user_icon.png",
                          iconColor: Color(0xff273692),
                          iconBgColor: Color(0xffCCD0E9),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Get.height / 40),

                  // Add User Button
                  _buildPrimaryButton(
                    text: 'Add User',
                    onPressed: () {
                      Get.toNamed(Routes.addUsers);
                    },
                  ),

                  SizedBox(height: Get.height / 40),

                  // Recent Users Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Users',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff747784),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // View All functionality can be implemented here
                          Get.snackbar(
                            'Info',
                            'View All functionality will be implemented soon',
                            snackPosition: SnackPosition.TOP,
                          );
                        },
                        child: Text(
                          'View All',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffF26E27),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Get.height / 60),

                  // Recent Users Card
                  Obx(
                    () => Container(
                      padding: EdgeInsets.all(Get.width / 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Search Bar
                          TextField(
                            onChanged: (value) {
                              // Search functionality can be implemented here
                            },
                            decoration: InputDecoration(
                              hintText: 'Search by Name, Email or Mobile',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 13,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey.shade500,
                              ),
                              filled: true,
                              fillColor: Color(0xffF7F9FA),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: Get.height / 80,
                                horizontal: Get.width / 25,
                              ),
                            ),
                          ),

                          SizedBox(height: Get.height / 80),
                          const Divider(height: 1, color: Colors.grey),

                          // User List
                          if (userController.recentUsers.isEmpty)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Get.height / 40,
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.people_outline,
                                    size: Get.width / 8,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(height: Get.height / 80),
                                  Text(
                                    'No users found',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height / 200),
                                  Text(
                                    'Add your first user to get started',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Column(
                              children: userController.recentUsers
                                  .map(
                                    (user) => _buildRecentUserTile(
                                      name: user.name,
                                      email: user.email,
                                      mobile: user.contact,
                                      status: user.isActive
                                          ? 'Active'
                                          : 'Inactive',
                                      statusColor: user.isActive
                                          ? Color(0xff4E6B37)
                                          : Color(0xffAD111E),
                                      statusBgColour: user.isActive
                                          ? Color(0xffDCE1D7)
                                          : Color(0xffEFCFD2),
                                      userImagePath: user.userImage,
                                      userCode: user.userCode,
                                    ),
                                  )
                                  .toList(),
                            ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: Get.height / 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Primary Button Widget
  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: Get.height / 17,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffF78520),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 3,
          shadowColor: Color(0xffF78520).withOpacity(0.3),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Stat Card Widget
  Widget _buildStatCard({
    required String value,
    required String label,
    required Color valueColor,
    required String changePercent,
    required String image,
    required Color iconColor,
    required Color iconBgColor,
  }) {
    return Container(
      padding: EdgeInsets.all(Get.width / 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon + Percentage Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  height: Get.width / 16,
                  width: Get.width / 16,
                  child: Image.asset(
                    image,
                    color: iconColor,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                changePercent,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: Get.height / 60),

          // Value
          Text(
            value,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          SizedBox(height: Get.height / 200),

          // Label
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
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
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              CircleAvatar(
                radius: Get.width / 16,
                backgroundImage:
                    userImagePath != null && userImagePath.isNotEmpty
                    ? FileImage(File(userImagePath)) as ImageProvider
                    : const AssetImage('asset/images/person_image.jpg')
                          as ImageProvider,
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
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      email,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),

                    SizedBox(height: 2),

                    Text(
                      mobile,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColour,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.viewDetails, arguments: userCode);
                    },
                    child: Text(
                      'View Details',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 10,
                          color: Color(0xff2A86D1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (userController.recentUsers.last.userCode != userCode)
          const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
