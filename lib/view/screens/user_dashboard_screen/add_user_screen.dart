import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../component/textfield.dart';

class CreateNewUserScreen extends StatelessWidget {
  CreateNewUserScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => SingleChildScrollView(
            padding: EdgeInsets.all(Get.width / 30),
            child: Container(
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
                      validator: (value) =>
                          createUserController.validateRequired(value, 'Name'),
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
                    _buildDesignationDropdown(), // still custom dropdown
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
                    _buildJoiningDateField(context), // keep date field custom
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
                      controller: createUserController.accountNumberController,
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
                      controller: createUserController.aadharNumberController,
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
                      onFileSelected: createUserController.setChequebookImage,
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
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: Get.height / 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesignationDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Designation *',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff000000),
            ),
          ),
        ),
        SizedBox(height: Get.height / 150),
        Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
          height: Get.height / 20,
          decoration: BoxDecoration(
            color: const Color(0xffF3F7FC),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: createUserController.selectedDesignation.value.isEmpty
                    ? null
                    : createUserController.selectedDesignation.value,
                isExpanded: true,
                hint: Text(
                  'Select Designation',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: const Color(0xff858585),
                      fontSize: Get.width / 30,
                    ),
                  ),
                ),
                items: createUserController.userController.designationOptions
                    .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                onChanged: (String? newValue) {
                  createUserController.selectedDesignation.value =
                      newValue ?? '';
                },
              ),
            ),
          ),
        ),
        SizedBox(height: Get.height / 50),
      ],
    );
  }

  Widget _buildJoiningDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Joining Date *',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff000000),
            ),
          ),
        ),
        SizedBox(height: Get.height / 150),
        GestureDetector(
          onTap: () => createUserController.selectJoiningDate(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
            height: Get.height / 20,
            decoration: BoxDecoration(
              color: const Color(0xffF3F7FC),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: createUserController.joiningDateController,
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: const Color(0xff858585),
                          fontSize: Get.width / 30,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.calendar_today, color: const Color(0xff858585)),
              ],
            ),
          ),
        ),
        SizedBox(height: Get.height / 50),
      ],
    );
  }
}
