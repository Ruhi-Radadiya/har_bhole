import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:har_bhole/main.dart';

import '../../../component/textfield.dart';

class CreateNewB2BOrder extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                            'Create New B2B Order',
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
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.all(Get.width / 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
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
                          label: "Customer Name",
                          hint: "Enter Your Name",
                          controller:
                              createB2BOrderController.customerNameController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Customer Email",
                          hint: "Enter Your Email",
                          controller:
                              createB2BOrderController.customerEmailController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Customer Phone",
                          hint: "Enter Your Phone Number",
                          controller:
                              createB2BOrderController.customerPhoneController,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Customer Address",
                          hint: "Enter Your Address",
                          controller: createB2BOrderController
                              .customerAddressController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Company",
                          hint: "Enter Your Company Name",
                          controller: createB2BOrderController
                              .customerCompanyController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "GST",
                          hint: "₹336.00",
                          controller:
                              createB2BOrderController.customerGstController,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: Get.height / 60),
                        _sectionTitle("Order Items"),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Product",
                          hint: "Select Product",
                          controller:
                              createB2BOrderController.productController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Variation",
                          hint: "Select Variation",
                          controller:
                              createB2BOrderController.variationController,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Quantity",
                          hint: "0",
                          controller:
                              createB2BOrderController.quantityController,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => _updateTotal(),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Price",
                          hint: "0.00",
                          controller: createB2BOrderController.priceController,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => _updateTotal(),
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "Total",
                          hint: "0.00",
                          controller: createB2BOrderController.totalController,
                          keyboardType: TextInputType.number,
                          isReadOnly: true,
                        ),
                        SizedBox(height: Get.height / 60),
                        CustomTextField(
                          label: "GST",
                          hint: "₹336.00",
                          controller: createB2BOrderController.gstController,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => _updateTotal(),
                        ),
                        SizedBox(height: Get.height / 60),

                        // Submit Button
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            height: Get.height / 18,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffF78520),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed:
                                  createB2BOrderController.isLoading.value
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        createB2BOrderController.addB2BOrder();
                                      }
                                    },
                              child: createB2BOrderController.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Create Order",
                                      style: GoogleFonts.poppins(
                                        fontSize: Get.width / 22.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height / 60),

                        // Delete Button
                        SizedBox(
                          height: Get.height / 18,
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              _formKey.currentState!.reset();
                              createB2BOrderController.customerNameController
                                  .clear();
                              createB2BOrderController.customerEmailController
                                  .clear();
                              createB2BOrderController.customerPhoneController
                                  .clear();
                              createB2BOrderController.customerAddressController
                                  .clear();
                              createB2BOrderController.customerCompanyController
                                  .clear();
                              createB2BOrderController.customerGstController
                                  .clear();
                              createB2BOrderController.totalAmountController
                                  .clear();

                              createB2BOrderController.productController
                                  .clear();
                              createB2BOrderController.variationController
                                  .clear();
                              createB2BOrderController.quantityController
                                  .clear();
                              createB2BOrderController.priceController.clear();
                              createB2BOrderController.totalController.clear();
                              createB2BOrderController.gstController.clear();
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
            ),
            SizedBox(height: Get.height / 20),
          ],
        ),
      ),
    );
  }

  void _updateTotal() {
    double quantity =
        double.tryParse(createB2BOrderController.quantityController.text) ?? 0;
    double price =
        double.tryParse(createB2BOrderController.priceController.text) ?? 0;
    double gst =
        double.tryParse(createB2BOrderController.gstController.text) ?? 0;

    double total = (quantity * price) + gst;
    createB2BOrderController.totalController.text = total.toStringAsFixed(2);
    createB2BOrderController.totalAmountController.text = total.toStringAsFixed(
      2,
    ); // this is sent to API
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
