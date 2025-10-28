import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Assuming you have these imports correctly configured
import '../../../../main.dart';
import '../../../../model/user_model.dart';

class ViewDetailsScreen extends StatelessWidget {
  final String userCode;

  const ViewDetailsScreen({super.key, required this.userCode});

  // Existing methods like build and _buildStatusTag remain the same
  // ... (Your existing build method and _buildStatusTag)

  @override
  Widget build(BuildContext context) {
    // ... (Your existing user fetching logic)
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
        body: const Center(
          child: CircularProgressIndicator(color: Color(0xffF78520)),
        ),
      );
    }

    // You must include the rest of your original methods for a complete, runnable class.
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
            textStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: Get.width / 18,
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
                      textStyle: TextStyle(
                        fontSize: Get.width / 18,
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
                        fontSize: Get.width / 26,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height / 30),

            // Replaced the old Column with the new _buildDetailRow
            _buildInfoCard(
              title: 'Personal Information',
              children: [
                _buildDetailRow(label: 'Full Name', value: user.name),
                _buildDetailRow(label: 'User Code', value: user.userCode),
                _buildDetailRow(label: 'Email Address', value: user.email),
                _buildDetailRow(
                  label: 'Location',
                  value: user.address,
                ), // changed label to match image
                _buildDetailRow(label: 'Designation', value: user.designation),
                _buildDetailRow(label: 'Phone Number', value: user.contact),
              ],
            ),
            SizedBox(height: Get.height / 30),
            _buildInfoCard(
              title: 'Employment/Bank',
              children: [
                _buildDetailRow(label: 'Joining Date', value: user.joiningDate),
                _buildDetailRow(
                  label: 'Salary',
                  value: user.salary,
                ), // Removed currency sign here, let _buildDetailRow handle it if needed
                _buildDetailRow(
                  label: 'Aadhar Number',
                  value: user.aadharNumber,
                ),
                _buildDetailRow(label: 'Bank Name', value: user.bankName),
                _buildDetailRow(
                  label: 'Account Number',
                  value: user.accountNumber,
                ),
                _buildDetailRow(label: 'IFSC Code', value: user.ifscCode),
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
      padding: EdgeInsets.fromLTRB(
        Get.width / 20,
        Get.width / 20,
        Get.width / 20,
        Get.width / 30,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for Title and Edit button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: Get.width / 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffF78520),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // TODO: Implement navigation to the Edit screen
                  print('Edit $title tapped');
                },
                child: Text(
                  'Edit',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: Get.width / 30,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffF78520),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height / 40),
          Column(children: children),
        ],
      ),
    );
  }

  Widget _buildDetailRow({required String label, required String value}) {
    String displayValue = value.isNotEmpty ? value : 'Not provided';
    if (label == 'Salary') {
      displayValue = '₹$displayValue';
    }

    return Padding(
      padding: EdgeInsets.only(bottom: Get.height / 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label (e.g., Full Name)
          Text(
            label,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: Get.width / 26, // Slightly larger label
                fontWeight: FontWeight.w500,
                color: Colors.black, // Darker color for the label
              ),
            ),
          ),
          SizedBox(height: Get.height / 200),

          // Value Container (the input-like box)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: Get.width / 25,
              vertical: Get.height / 80,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffFAF7F6),
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            child: Text(
              displayValue,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: Get.width / 26,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff858585),
                ),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Existing _buildStatusTag remains the same
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
            fontSize: Get.width / 36,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
