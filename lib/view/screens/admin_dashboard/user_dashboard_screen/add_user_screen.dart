import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/model/user_model/dashboard_user_model.dart';

import '../../../../main.dart';
import '../../../component/textfield.dart';

class CreateNewUserScreen extends StatefulWidget {
  final DashboardUserModel? user; // optional constructor param
  const CreateNewUserScreen({super.key, this.user});

  @override
  State<CreateNewUserScreen> createState() => _CreateNewUserScreenState();
}

class _CreateNewUserScreenState extends State<CreateNewUserScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isEdit = false;
  DashboardUserModel? resolvedUser;
  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    DashboardUserModel? argUser;

    // ✅ Extract user data from arguments if passed
    if (args != null &&
        args is Map<String, dynamic> &&
        args.containsKey('user')) {
      final raw = args['user'];
      if (raw is DashboardUserModel) {
        argUser = raw;
      } else if (raw is Map) {
        argUser = DashboardUserModel.fromJson(Map<String, dynamic>.from(raw));
      }
    }

    // ✅ Determine if we are editing or adding new
    resolvedUser = widget.user ?? argUser;
    isEdit = resolvedUser != null;

    if (isEdit) {
      // ✅ Fill data in the SAME controller your form uses
      createUserController.fillUserData(resolvedUser!);
    } else {
      // ✅ Clear all fields and generate new code
      createUserController.clearForm();
      createUserController.generateNextUserCode();
    }
  }

  // ✅ Auto-generate next user code like U001, U002, etc.
  void _generateNextUserCode() {
    // Suppose you already have all users list in controller
    final users = dashboardUsersController.allUsers;
    if (users.isNotEmpty) {
      // Get the last code number from existing users
      final lastCode =
          users.last.userCode?.replaceAll(RegExp(r'[^0-9]'), '') ?? '0';
      final nextNum = int.parse(lastCode) + 1;
      final newCode = 'U${nextNum.toString().padLeft(3, '0')}';
      dashboardUsersController.userCodeController.text = newCode;
    } else {
      // if no user exists yet
      dashboardUsersController.userCodeController.text = 'U001';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xffF7611B)),
            onPressed: () => Get.back(),
          ),
          title: Text(
            isEdit ? 'Edit User' : 'Create New User',
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
        body: Obx(
          () => SingleChildScrollView(
            padding: EdgeInsets.all(Get.width / 25),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(Get.width / 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'User Code *',
                          hint: 'U001',
                          controller: createUserController.userCodeController,
                          isReadOnly: true,
                        ),

                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Name *',
                          hint: 'Enter full name',
                          controller: createUserController.nameController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Email *',
                          hint: 'Enter email',
                          controller: createUserController.emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: Get.height / 60),

                        // ✅ Show password field only when adding
                        if (!isEdit)
                          CustomTextField(
                            label: 'Password *',
                            hint: 'Enter password',
                            controller: createUserController.passwordController,
                            isPassword: true,
                          ),
                        if (!isEdit) SizedBox(height: Get.height / 60),

                        CustomTextField(
                          label: 'Contact *',
                          hint: 'Enter phone number',
                          controller: createUserController.contactController,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: Get.height / 60),

                        // ✅ Designation dropdown
                        Obx(
                          () => CustomDropdownField<String>(
                            label: 'Designation *',
                            items: createUserController.designationOptions,
                            value:
                                createUserController
                                    .selectedDesignation
                                    .value
                                    .isEmpty
                                ? null
                                : createUserController
                                      .selectedDesignation
                                      .value,
                            getLabel: (item) => item,
                            onChanged: (value) {
                              createUserController.selectedDesignation.value =
                                  value!;
                            },
                          ),
                        ),
                        SizedBox(height: Get.height / 60),

                        CustomTextField(
                          label: 'Address *',
                          hint: 'Enter address',
                          controller: createUserController.addressController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomDateField(
                          label: 'Joining Date *',
                          controller:
                              createUserController.joiningDateController,
                          hint: 'Select Date',
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Salary *',
                          hint: '0.00',
                          keyboardType: TextInputType.number,
                          controller: createUserController.salaryController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Bank Name *',
                          hint: 'Enter bank name',
                          controller: createUserController.bankNameController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          hint: 'Enter account number',
                          label: 'Account Number *',
                          controller:
                              createUserController.accountNumberController,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          hint: 'Enter IFSC code',
                          label: 'IFSC Code *',
                          controller: createUserController.ifscCodeController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          hint: 'Enter Aadhar number',
                          label: 'Aadhar Number *',
                          controller:
                              createUserController.aadharNumberController,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: Get.height / 60),
                        UploadFileField(
                          label: 'User Image',
                          onFileSelected: (file) {
                            createUserController.userImage.value =
                                file as File?;
                          },
                        ),
                        UploadFileField(
                          label: 'Chequebook Image',
                          onFileSelected: (file) {
                            createUserController.chequebookImage.value =
                                file as File?;
                          },
                        ),
                        SizedBox(height: Get.height / 40),
                        SizedBox(
                          width: double.infinity,
                          height: Get.height / 18,
                          child: ElevatedButton(
                            onPressed: createUserController.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      if (isEdit) {
                                        createUserController.updateUser(
                                          createUserController.editingUserId,
                                        );
                                      } else {
                                        createUserController.submitForm();
                                      }
                                    }
                                  },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: createUserController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    isEdit ? 'Update User' : 'Save User',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: Get.width / 22.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height / 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
