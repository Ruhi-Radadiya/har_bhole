import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../main.dart';
import '../../../component/textfield.dart';

class CreateNewUserScreen extends StatelessWidget {
  CreateNewUserScreen({super.key});

  final _formKey = GlobalKey<FormState>();

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
                          label: 'User Code *',
                          hint: 'U001',
                          controller: createUserController.userCodeController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Name *',
                          hint: 'Enter your full name',
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
                        CustomTextField(
                          label: 'Password *',
                          hint: 'Enter password',
                          controller: createUserController.passwordController,
                          isPassword: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: 'Contact *',
                          hint: 'Enter phone number',
                          controller: createUserController.contactController,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: Get.height / 60),
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
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              final formattedDate =
                                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

                              createUserController.joiningDateController.text =
                                  formattedDate;
                              createUserController.joiningDate.value =
                                  formattedDate;
                            }
                          },
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
                          controller: createUserController.bankNameController,

                          hint: 'Enter bank name',
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
                        SizedBox(height: Get.height / 40),
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
                                borderRadius: BorderRadius.circular(12),
                              ),
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
