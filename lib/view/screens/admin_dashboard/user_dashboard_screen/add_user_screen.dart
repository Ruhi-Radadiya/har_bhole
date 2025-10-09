import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../../controller/user_controller/user_controller.dart';
import '../../../component/textfield.dart';

class CreateNewUserScreen extends StatelessWidget {
  CreateNewUserScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xffF7611B)),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Create New User',
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
            padding: EdgeInsets.all(Get.width / 30),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(Get.width / 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'User Code',
                          hint: 'emp004',
                          controller: createUserController.userCodeController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Name *',
                          hint: 'Enter your full Name',
                          controller: createUserController.nameController,
                          keyboardType: TextInputType.name,
                          validator: (value) => createUserController
                              .validateRequired(value, 'Name'),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Email Address *',
                          hint: 'Enter your Email Address',
                          controller: createUserController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: createUserController.validateEmail,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Password *',
                          hint: 'Enter your Password',
                          controller: createUserController.passwordController,
                          isPassword: true,
                          validator: (value) => createUserController
                              .validateRequired(value, 'Password'),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Contact Number *',
                          hint: 'Enter your Contact Number',
                          controller: createUserController.contactController,
                          keyboardType: TextInputType.phone,
                          validator: createUserController.validatePhone,
                        ),
                        SizedBox(height: Get.height / 60),
                        Obx(
                          () => CustomDropdownField<String>(
                            label: "Designation",
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
                              print("Selected Designation: $value");
                            },
                          ),
                        ),

                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Address *',
                          hint: 'Enter your Address',
                          controller: createUserController.addressController,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) => createUserController
                              .validateRequired(value, 'Address'),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomDateField(
                          label: "Joining Date *",
                          controller:
                              createUserController.joiningDateController,
                          onTap: () =>
                              createUserController.selectJoiningDate(context),
                          hint: "Select Date",
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Salary *',
                          hint: '0.00',
                          controller: createUserController.salaryController,
                          keyboardType: TextInputType.number,
                          validator: (value) => createUserController
                              .validateRequired(value, 'Salary'),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Bank Name *',
                          hint: 'Enter your Bank Name',
                          controller: createUserController.bankNameController,
                          validator: (value) => createUserController
                              .validateRequired(value, 'Bank Name'),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Account Number *',
                          hint: 'Enter your Account Number',
                          controller:
                              createUserController.accountNumberController,
                          keyboardType: TextInputType.number,
                          validator: (value) => createUserController
                              .validateRequired(value, 'Account Number'),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'IFSC Code *',
                          hint: 'Enter your IFSC Code',
                          controller: createUserController.ifscCodeController,
                          validator: (value) => createUserController
                              .validateRequired(value, 'IFSC Code'),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Aadhar Number *',
                          hint: 'Enter your Aadhar Number',
                          controller:
                              createUserController.aadharNumberController,
                          keyboardType: TextInputType.number,
                          validator: createUserController.validateAadhar,
                        ),
                        SizedBox(height: Get.height / 60),
                        UploadFileField(
                          label: 'User Image',
                          onFileSelected: createUserController.setUserImage,
                        ),
                        SizedBox(height: Get.height / 60),
                        UploadFileField(
                          label: 'Chequebook Image',
                          onFileSelected:
                              createUserController.setChequebookImage,
                        ),
                        SizedBox(height: Get.height / 60),
                        SizedBox(
                          width: double.infinity,
                          height: Get.height / 18,
                          child: ElevatedButton(
                            onPressed: createUserController.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      createUserController.submitForm();
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            ),
                            child: createUserController.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Save User',
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
