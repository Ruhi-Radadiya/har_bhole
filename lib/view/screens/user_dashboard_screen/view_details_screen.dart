import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/user_controller/user_controller.dart';
import '../../../model/user_model.dart';

class ViewDetailsScreen extends StatelessWidget {
  final String userCode;

  const ViewDetailsScreen({super.key, required this.userCode});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    final UserModel? user = userController.users.firstWhereOrNull(
      (user) => user.userCode == userCode,
    );

    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'User not found',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.back();
      });
      return Scaffold(
        backgroundColor: const Color(0xffF7F9FA),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F9FA),
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'User Details',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 15),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: Get.width / 9,
                        backgroundImage:
                            user.userImage != null && user.userImage!.isNotEmpty
                            ? FileImage(File(user.userImage!)) as ImageProvider
                            : const AssetImage('asset/images/person_image.jpg'),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      // Status tick/cross
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: user.isActive
                                ? const Color(0xff2EB324)
                                : const Color(0xffAD111E),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            user.isActive ? Icons.check : Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height / 100),
                  Text(
                    user.name,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 200),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatusTag(
                        user.isActive ? 'Active' : 'Inactive',
                        user.isActive
                            ? const Color(0xff4E6B37)
                            : const Color(0xffAD111E),
                      ),
                      SizedBox(width: Get.width / 50),
                      _buildStatusTag('Employee', const Color(0xff3747AD)),
                    ],
                  ),
                  SizedBox(height: Get.height / 200),
                  Text(
                    user.designation,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height / 30),
            _buildInfoCard(
              title: 'Personal Information',
              children: [
                _buildDetailRow(
                  image: "asset/icons/new_user_icon.png",
                  label: 'Full Name',
                  value: user.name,
                ),
                _buildDetailRow(
                  image: "asset/icons/user_code_icon.png",
                  label: 'User Code',
                  value: user.userCode,
                ),
                _buildDetailRow(
                  image: "asset/icons/email_icon.png",
                  label: 'Email Address',
                  value: user.email,
                ),
                _buildDetailRow(
                  image: "asset/icons/location_icon.png",
                  label: 'Address',
                  value: user.address,
                ),
                _buildDetailRow(
                  image: "asset/icons/designation_icon.png",
                  label: 'Designation',
                  value: user.designation,
                ),
                _buildDetailRow(
                  image: "asset/icons/phone_icon.png",
                  label: 'Phone Number',
                  value: user.contact,
                ),
              ],
            ),
            SizedBox(height: Get.height / 30),
            _buildInfoCard(
              title: 'Employment/Bank',
              children: [
                _buildDetailRow(
                  image: "asset/icons/calender_icon.png",
                  label: 'Joining Date',
                  value: user.joiningDate,
                ),
                _buildDetailRow(
                  image: "asset/icons/salary_icon.png",
                  label: 'Salary',
                  value: '₹${user.salary}',
                ),
                _buildDetailRow(
                  image: "asset/icons/aadhar_card_icon.png",
                  label: 'Aadhar Number',
                  value: user.aadharNumber,
                ),
                _buildDetailRow(
                  image: "asset/icons/bank_icon.png",
                  label: 'Bank Name',
                  value: user.bankName,
                ),
                _buildDetailRow(
                  image: "asset/icons/account_icon.png",
                  label: 'Account Number',
                  value: user.accountNumber,
                ),
                _buildDetailRow(
                  image: "asset/icons/ifsc_icon.png",
                  label: 'IFSC Code',
                  value: user.ifscCode,
                ),
              ],
            ),
            SizedBox(height: Get.height / 13),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(Get.width / 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: Get.height / 80),
          Column(children: children),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String image,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height / 150),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: Get.width / 18,
            backgroundColor: const Color(0xffFDE9D6),
            child: SizedBox(
              height: Get.width / 17,
              width: Get.width / 17,
              child: Image.asset(image, color: const Color(0xffF78520)),
            ),
          ),
          SizedBox(width: Get.width / 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                Text(
                  value.isNotEmpty ? value : 'Not provided',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
