import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';
import 'package:har_bhole/view/component/textfield.dart';

import '../../../../model/user_model/dashboard_user_model.dart';
import '../../../../routes/routes.dart';

class ViewDetailsScreen extends StatelessWidget {
  const ViewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    // ✅ Safely extract user from arguments
    final DashboardUserModel? user =
        args is Map<String, dynamic> && args.containsKey('user')
        ? args['user'] as DashboardUserModel
        : null;

    // ✅ Handle null user (fallback)
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'User data not found',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.back();
      });
      return const Scaffold(
        backgroundColor: Color(0xffF7F9FA),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xffF78520)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FA),
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
                  'Raw Material',
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
                  SizedBox(height: Get.height / 30),
                  _buildHeader(user),
                  SizedBox(height: Get.height / 30),
                  _buildInfoCard(
                    title: 'Personal Information',
                    onEditTap: () {
                      Get.toNamed(
                        Routes.addUsers,
                        arguments: {'isEdit': true, 'user': user},
                      );
                    },
                    children: [
                      CustomTextField(
                        label: 'Full Name',
                        hint: user.userName ?? '-',
                        isReadOnly: true,
                      ),
                      CustomTextField(
                        label: 'User Code',
                        hint: user.userCode ?? '-',
                        isReadOnly: true,
                      ),
                      CustomTextField(
                        label: 'Email Address',
                        hint: user.userEmail ?? '-',
                        isReadOnly: true,
                      ),
                      CustomTextField(
                        label: 'Phone Number',
                        hint: user.userPhone ?? '-',
                        isReadOnly: true,
                      ),
                      CustomTextField(
                        label: 'Designation',
                        hint: user.designation ?? '-',
                        isReadOnly: true,
                      ),
                      CustomTextField(
                        label: 'Address',
                        hint: user.userAddress ?? '-',
                        isReadOnly: true,
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height / 30),
                  _buildInfoCard(
                    title: 'Employment & Bank Details',
                    onEditTap: () {
                      Get.toNamed(
                        Routes.addUsers,
                        arguments: {'isEdit': true, 'user': user},
                      );
                    },
                    children: [
                      CustomTextField(
                        label: 'Joining Date',
                        hint: user.joiningDate ?? '-',
                        isReadOnly: true,
                      ),
                      CustomTextField(
                        label: 'Salary',
                        hint: user.salary ?? '-',
                        isReadOnly: true,
                      ),
                      CustomTextField(
                        label: 'Aadhar Number',
                        hint: user.aadharNumber ?? '-',
                        isReadOnly: true,
                      ),
                      CustomTextField(
                        label: 'Bank Name',
                        hint: user.bankName ?? '-',
                        isReadOnly: true,
                      ),
                      CustomTextField(
                        label: 'Account Number',
                        hint: user.accountNumber ?? '-',
                        isReadOnly: true,
                      ),
                      CustomTextField(
                        label: 'IFSC Code',
                        hint: user.ifscCode ?? '-',
                        isReadOnly: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () async {
                            await Get.defaultDialog(
                              title: "Delete User",
                              titleStyle: TextStyle(
                                color: const Color(0xffF78520),
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width / 20,
                              ),
                              backgroundColor: Colors.white,
                              radius: 20,
                              barrierDismissible: false,
                              content: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width / 20,
                                  vertical: Get.height / 50,
                                ),
                                child: Text(
                                  "Are you sure you want to delete this User?",
                                  style: TextStyle(
                                    color: const Color(0xffF78520),
                                    fontSize: Get.width / 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              textConfirm: "Yes",
                              textCancel: "No",
                              confirmTextColor: const Color(0xffF78520),
                              cancelTextColor: const Color(0xffF78520),
                              buttonColor: Colors.white,
                              onConfirm: () async {
                                if (Get.isDialogOpen ?? false) Get.back();
                                log(
                                  "🟢 Trying to delete user_id: ${user.userId}",
                                );

                                await createUserController.deleteUser(
                                  user.userId ?? '',
                                );
                              },
                              onCancel: () {
                                if (Get.isDialogOpen ?? false) Get.back();
                              },
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xffF78520),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Color(0xffF78520)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height / 20),
        ],
      ),
    );
  }

  /// 🧩 Header Section
  Widget _buildHeader(DashboardUserModel user) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: Get.width / 9,
              backgroundImage:
                  user.userImage != null && user.userImage!.isNotEmpty
                  ? (user.userImage!.startsWith('http')
                        ? NetworkImage(user.userImage!)
                        : FileImage(File(user.userImage!)) as ImageProvider)
                  : const AssetImage('asset/images/person_image.jpg'),
              backgroundColor: Colors.grey.shade200,
            ),
            // Positioned(
            //   right: 0,
            //   bottom: 0,
            //   child: Container(
            //     padding: const EdgeInsets.all(3),
            //     decoration: BoxDecoration(
            //       color: user.isActive == true
            //           ? const Color(0xff2EB324)
            //           : const Color(0xffAD111E),
            //       shape: BoxShape.circle,
            //     ),
            //     child: Icon(
            //       user.isActive == true ? Icons.check : Icons.close,
            //       color: Colors.white,
            //       size: 16,
            //     ),
            //   ),
            // ),
          ],
        ),
        SizedBox(height: Get.height / 100),
        Text(
          user.userName ?? '-',
          style: GoogleFonts.poppins(
            fontSize: Get.width / 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Get.height / 200),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // _buildStatusTag(
            //   user.isActive == true ? 'Active' : 'Inactive',
            //   user.isActive == true
            //       ? const Color(0xff4E6B37)
            //       : const Color(0xffAD111E),
            // ),
            // SizedBox(width: Get.width / 50),
            _buildStatusTag('Employee', const Color(0xff3747AD)),
          ],
        ),
        SizedBox(height: Get.height / 200),
        Text(
          user.designation ?? '-',
          style: GoogleFonts.poppins(
            fontSize: Get.width / 26,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  /// 🧩 Info Card Widget
  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
    required VoidCallback onEditTap,
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
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: Get.width / 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffF78520),
                ),
              ),
              InkWell(
                onTap: onEditTap,
                child: Text(
                  'Edit',
                  style: GoogleFonts.poppins(
                    fontSize: Get.width / 30,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffF78520),
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

  /// 🧩 Status Tag Widget
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
          fontSize: Get.width / 36,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
