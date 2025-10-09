import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../component/textfield.dart';

class CreateNewB2BOrder extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController productCodeController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController basePriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  CreateNewB2BOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

      child: Scaffold(
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
              child: Column(
                children: [
                  SizedBox(height: Get.height / 100),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xffF78520),
                        ),
                        onPressed: () => Get.back(),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(minWidth: Get.width / 15),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Create New Category',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Get.width / 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width / 15),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(Get.width / 30),

                child: Container(
                  padding: EdgeInsets.all(Get.width / 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Create Manual Order"),
                      CustomTextField(
                        label: "customer Name",
                        hint: "Enter Your Name",
                        controller: productCodeController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "customer Email",
                        hint: "Enter Your email",
                        controller: productNameController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "customer Phone",
                        hint: "Enter Your Phone Number",
                        controller: productNameController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "customer Address",
                        hint: "Enter Your Address",
                        controller: productNameController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "Company",
                        hint: "Enter Your Company Name",
                        controller: productNameController,
                      ),
                      SizedBox(height: Get.height / 60),

                      CustomTextField(
                        label: "GST",
                        hint: "₹336.00",
                        controller: productNameController,
                      ),
                      SizedBox(height: Get.height / 60),
                      _sectionTitle("Order Items"),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Product",
                        hint: "Select Product",
                        controller: basePriceController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Variation",
                        hint: "Select Variation",
                        controller: stockController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Quantity",
                        hint: "0",
                        controller: stockController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Price",
                        hint: "0.00",
                        controller: stockController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "Total",
                        hint: "0.00",
                        controller: stockController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      CustomTextField(
                        label: "GST",
                        hint: "₹336.00",
                        controller: stockController,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: Get.height / 60),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height / 18,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffF78520),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // handle submit
                            }
                          },
                          child: Text(
                            "Create Order",
                            style: GoogleFonts.poppins(
                              fontSize: Get.width / 22.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 60),
                      SizedBox(
                        height: Get.height / 18,
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                              color: Color(0xffF78520),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Delete',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: Get.width / 22.5,
                                color: Color(0xffF78520),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height / 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: Get.width / 21,
          color: Color(0xffF78520),
        ),
      ),
    );
  }
}
