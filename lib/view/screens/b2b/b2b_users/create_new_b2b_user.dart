import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../component/textfield.dart';

class CreateNewB2BUser extends StatelessWidget {
  CreateNewB2BUser({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // GetX Controller

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
            'Create New B2B User',
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: 'Name',
                        hint: 'Enter your full Name',
                        controller: createB2bUserController.nameController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Email Address',
                        hint: 'Enter your Email Address',
                        controller: createB2bUserController.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Password',
                        hint: 'Enter your Password',
                        controller: createB2bUserController.passwordController,
                        isPassword: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Phone',
                        hint: 'Enter your Contact Number',
                        controller: createB2bUserController.phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Company',
                        hint: 'Enter Company Name',
                        controller: createB2bUserController.companyController,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'GSTIN',
                        hint: 'Enter GSTIN',
                        controller: createB2bUserController.gstinController,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Address',
                        hint: 'Enter your Address',
                        controller: createB2bUserController.addressController,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Status',
                        hint: 'Enter Status',
                        controller: createB2bUserController.statusController,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: Get.height / 60),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: createB2bUserController.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      createB2bUserController.addB2BUser();
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF78520),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 0,
                            ),
                            child: createB2bUserController.isLoading.value
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
                      ),
                      SizedBox(height: Get.height / 40),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height / 20),
            ],
          ),
        ),
      ),
    );
  }
}
