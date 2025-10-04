import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/textfield.dart';

class CreateNewB2BUser extends StatelessWidget {
  CreateNewB2BUser({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Local controllers
  final TextEditingController userCodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController aadharNumberController = TextEditingController();

  final RxString selectedDesignation = "".obs;

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
                        controller: nameController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Email Address',
                        hint: 'Enter your Email Address',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Password',
                        hint: 'Enter your Password',
                        controller: passwordController,
                        isPassword: true,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Phone',
                        hint: 'Enter your Contact Number',
                        controller: contactController,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: Get.height / 60),
                      _buildDesignationDropdown(),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Address',
                        hint: 'Enter your Address',
                        controller: addressController,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: 'Status',
                        hint: 'Enter Status',
                        controller: aadharNumberController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Get.snackbar("Form", "User Saved Successfully!");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF78520),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
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
              SizedBox(height: Get.height / 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesignationDropdown() {
    final options = ["Manager", "Staff", "Intern", "Other"];
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
        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 25),
            height: Get.height / 20,
            decoration: BoxDecoration(
              color: const Color(0xffF3F7FC),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedDesignation.value.isEmpty
                    ? null
                    : selectedDesignation.value,
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
                items: options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  selectedDesignation.value = newValue ?? '';
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
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              joiningDateController.text =
                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
            }
          },
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
                    controller: joiningDateController,
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
                const Icon(Icons.calendar_today, color: Color(0xff858585)),
              ],
            ),
          ),
        ),
        SizedBox(height: Get.height / 50),
      ],
    );
  }
}
